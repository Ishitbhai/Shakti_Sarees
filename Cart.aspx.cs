using System;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shakti_Sarees
{
    public partial class Cart : Page
    {
        // Your exact connection string
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        // Syllabus Topic (Unit 1): Constant declaration for GST/Tax calculation
        private const decimal TaxRate = 0.05m;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Require login to view Cart
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadCartItems();
            }
        }

        // Syllabus Topic (Unit 1): Method using 'ref' and 'out' parameters for bill calculation
        private void CalculateBillSummary(ref decimal grandTotal, decimal subtotal, out decimal taxAmount)
        {
            taxAmount = Math.Round(subtotal * TaxRate, 2);
            grandTotal = subtotal + taxAmount;
        }

        // Syllabus Topics: Unit 5 (LINQ Sum), Unit 7 (DataTable, DataColumn, DataRow)
        private void LoadCartItems()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            SqlConnection con = new SqlConnection(connectionstring);

            try
            {
                con.Open();

                string query = @"SELECT cr.CartID, cr.ProductID, cr.Quantity, 
                                        p.ProductName, p.Price, p.MainImage, p.StockQuantity, 
                                        c.CategoryName 
                                 FROM Cart cr 
                                 INNER JOIN Products p ON cr.ProductID = p.ProductID 
                                 INNER JOIN Categories c ON p.CategoryID = c.CategoryID 
                                 WHERE cr.UserID = @UserID";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserID", userId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Syllabus Topic (Unit 7): Dynamically adding a computed DataColumn to DataTable
                DataColumn itemTotalCol = new DataColumn("ItemTotal", typeof(decimal));
                dt.Columns.Add(itemTotalCol);

                foreach (DataRow row in dt.Rows)
                {
                    decimal price = Convert.ToDecimal(row["Price"]);
                    int qty = Convert.ToInt32(row["Quantity"]);
                    row["ItemTotal"] = price * qty;
                }

                rptCartItems.DataSource = dt;
                rptCartItems.DataBind();

                // Syllabus Topic (Unit 5): LINQ Method Syntax & Lambda Expressions to calculate totals
                int totalQuantity = dt.AsEnumerable().Sum(r => Convert.ToInt32(r["Quantity"]));
                decimal subtotal = dt.AsEnumerable().Sum(r => Convert.ToDecimal(r["ItemTotal"]));

                decimal taxAmount;
                decimal grandTotal = 0;
                CalculateBillSummary(ref grandTotal, subtotal, out taxAmount);

                litItemCount.Text = totalQuantity.ToString();
                litSubtotal.Text = subtotal.ToString("0.00");
                litTaxes.Text = taxAmount.ToString("0.00");
                litFinalTotal.Text = grandTotal.ToString("0.00");

                // Disable Checkout button if cart is empty
                btnCheckout.Enabled = totalQuantity > 0;
            }
            finally
            {
                con.Close();
            }
        }

        protected void btnMinus_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int cartId = int.Parse(btn.CommandArgument);

            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                string checkQuery = "SELECT Quantity FROM Cart WHERE CartID=@CartID";
                SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                checkCmd.Parameters.AddWithValue("@CartID", cartId);

                int currentQty = Convert.ToInt32(checkCmd.ExecuteScalar());

                if (currentQty > 1)
                {
                    string updateQuery = "UPDATE Cart SET Quantity=@Quantity WHERE CartID=@CartID";
                    SqlCommand updateCmd = new SqlCommand(updateQuery, con);
                    updateCmd.Parameters.AddWithValue("@Quantity", currentQty - 1);
                    updateCmd.Parameters.AddWithValue("@CartID", cartId);
                    updateCmd.ExecuteNonQuery();
                }
                else
                {
                    // If quantity is 1 and user clicks minus, remove item from Cart
                    string deleteQuery = "DELETE FROM Cart WHERE CartID=@CartID";
                    SqlCommand deleteCmd = new SqlCommand(deleteQuery, con);
                    deleteCmd.Parameters.AddWithValue("@CartID", cartId);
                    deleteCmd.ExecuteNonQuery();
                }
            }
            finally
            {
                con.Close();
            }

            Response.Redirect("Cart.aspx");
        }

        protected void btnPlus_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int cartId = int.Parse(btn.CommandArgument);

            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                // Check current quantity and maximum available product stock
                string checkQuery = @"SELECT cr.Quantity, p.StockQuantity 
                                      FROM Cart cr 
                                      INNER JOIN Products p ON cr.ProductID = p.ProductID 
                                      WHERE cr.CartID=@CartID";
                SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                checkCmd.Parameters.AddWithValue("@CartID", cartId);

                SqlDataReader dr = checkCmd.ExecuteReader();
                if (dr.Read())
                {
                    int currentQty = Convert.ToInt32(dr["Quantity"]);
                    int maxStock = Convert.ToInt32(dr["StockQuantity"]);
                    dr.Close();

                    if (currentQty < maxStock)
                    {
                        string updateQuery = "UPDATE Cart SET Quantity=@Quantity WHERE CartID=@CartID";
                        SqlCommand updateCmd = new SqlCommand(updateQuery, con);
                        updateCmd.Parameters.AddWithValue("@Quantity", currentQty + 1);
                        updateCmd.Parameters.AddWithValue("@CartID", cartId);
                        updateCmd.ExecuteNonQuery();
                    }
                }
                else
                {
                    dr.Close();
                }
            }
            finally
            {
                con.Close();
            }

            Response.Redirect("Cart.aspx");
        }

        protected void btnRemoveItem_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int cartId = int.Parse(btn.CommandArgument);

            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                string query = "DELETE FROM Cart WHERE CartID=@CartID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@CartID", cartId);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                con.Close();
            }

            Response.Redirect("Cart.aspx");
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            Response.Redirect("Checkout.aspx");
        }
    }
}