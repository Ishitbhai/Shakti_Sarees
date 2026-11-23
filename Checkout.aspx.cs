using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading;
using System.Web.UI;

namespace Shakti_Sarees
{
    // Syllabus Topic (Unit 3): Custom Delegate for order placement event
    public delegate void OrderPlacedHandler(int orderId, string customerEmail, decimal totalAmount);

    public partial class Checkout : Page
    {
        // Your exact connection string
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        private const decimal TaxRate = 0.05m;

        // Syllabus Topic (Unit 3 & Unit 6): Event declaration and Thread Synchronization lock object
        public event OrderPlacedHandler OnOrderPlaced;
        private static readonly object orderLock = new object();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Require login to access Checkout
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // Syllabus Topic (Unit 3 & Unit 6): Subscribe to Event with Lambda Expression & Background Thread
            OnOrderPlaced += (ordId, email, amt) =>
            {
                Thread orderThread = new Thread(() =>
                {
                    lock (orderLock)
                    {
                        string auditLog = "Order #" + ordId + " placed by " + email + " for Rs. " + amt;
                    }
                });
                orderThread.IsBackground = true;
                orderThread.Start();
            };

            if (!IsPostBack)
            {
                LoadCustomerDetails();
                LoadCheckoutSummary();
            }
        }

        // Syllabus Topic (Unit 7): Connected Model (SqlDataReader) to load readonly user details
        private void LoadCustomerDetails()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            SqlConnection con = new SqlConnection(connectionstring);

            try
            {
                con.Open();

                string query = "SELECT FullName, Email, MobileNumber, LocalAddress, City, PinCode FROM Users WHERE UserID=@UserID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserID", userId);

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtFullName.Text = dr["FullName"].ToString();
                    txtEmail.Text = dr["Email"].ToString();
                    txtMobile.Text = dr["MobileNumber"].ToString();
                    txtAddress.Text = dr["LocalAddress"].ToString();
                    txtCity.Text = dr["City"].ToString();
                    txtPincode.Text = dr["PinCode"].ToString();
                }
                dr.Close();
            }
            finally
            {
                con.Close();
            }
        }

        // Syllabus Topic (Unit 7 & Unit 5): Disconnected Model (DataTable) and LINQ Sum
        private void LoadCheckoutSummary()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            SqlConnection con = new SqlConnection(connectionstring);

            try
            {
                con.Open();

                string query = @"SELECT cr.CartID, cr.ProductID, cr.Quantity, p.ProductName, p.Price, p.MainImage 
                                 FROM Cart cr 
                                 INNER JOIN Products p ON cr.ProductID = p.ProductID 
                                 WHERE cr.UserID = @UserID";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserID", userId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // If cart is empty, redirect back to Cart.aspx
                if (dt.Rows.Count == 0)
                {
                    Response.Redirect("Cart.aspx");
                    return;
                }

                DataColumn itemTotalCol = new DataColumn("ItemTotal", typeof(decimal));
                dt.Columns.Add(itemTotalCol);

                foreach (DataRow row in dt.Rows)
                {
                    row["ItemTotal"] = Convert.ToDecimal(row["Price"]) * Convert.ToInt32(row["Quantity"]);
                }

                rptCheckoutItems.DataSource = dt;
                rptCheckoutItems.DataBind();

                decimal subtotal = dt.AsEnumerable().Sum(r => Convert.ToDecimal(r["ItemTotal"]));
                decimal taxes = Math.Round(subtotal * TaxRate, 2);
                decimal finalTotal = subtotal + taxes;

                litSubtotal.Text = subtotal.ToString("0.00");
                litTaxes.Text = taxes.ToString("0.00");
                litTotal.Text = finalTotal.ToString("0.00");

                ViewState["FinalOrderTotal"] = finalTotal;
            }
            finally
            {
                con.Close();
            }
        }

        // Syllabus Topics: Unit 4 (Queue<T> FIFO Collection), Unit 7 (INSERT Orders, INSERT OrderItems, UPDATE Products, DELETE Cart)
        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);
            string customerEmail = txtEmail.Text.Trim();
            decimal totalAmount = ViewState["FinalOrderTotal"] != null ? Convert.ToDecimal(ViewState["FinalOrderTotal"]) : 0;

            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                // 1. Fetch current Cart items into a DataTable
                string cartQuery = @"SELECT cr.ProductID, cr.Quantity, p.Price 
                                     FROM Cart cr 
                                     INNER JOIN Products p ON cr.ProductID = p.ProductID 
                                     WHERE cr.UserID = @UserID";
                SqlCommand cartCmd = new SqlCommand(cartQuery, con);
                cartCmd.Parameters.AddWithValue("@UserID", userId);

                SqlDataAdapter da = new SqlDataAdapter(cartCmd);
                DataTable dtCart = new DataTable();
                da.Fill(dtCart);

                if (dtCart.Rows.Count == 0)
                {
                    Response.Redirect("Cart.aspx");
                    return;
                }

                // 2. Insert record into Orders table and get generated OrderID
                string orderDate = DateTime.Now.ToString("yyyy-MM-dd");
                string orderStatus = "Pending";

                string insertOrderQuery = "INSERT INTO Orders (UserID, CustomerEmail, OrderDate, TotalAmount, OrderStatus) VALUES (@UserID, @CustomerEmail, @OrderDate, @TotalAmount, @OrderStatus); SELECT SCOPE_IDENTITY();";
                SqlCommand orderCmd = new SqlCommand(insertOrderQuery, con);
                orderCmd.Parameters.AddWithValue("@UserID", userId);
                orderCmd.Parameters.AddWithValue("@CustomerEmail", customerEmail);
                orderCmd.Parameters.AddWithValue("@OrderDate", orderDate);
                orderCmd.Parameters.AddWithValue("@TotalAmount", totalAmount);
                orderCmd.Parameters.AddWithValue("@OrderStatus", orderStatus);

                int newOrderId = Convert.ToInt32(orderCmd.ExecuteScalar());

                // Syllabus Topic (Unit 4): Using Queue<DataRow> to process order items in FIFO sequence
                Queue<DataRow> itemQueue = new Queue<DataRow>();
                foreach (DataRow row in dtCart.Rows)
                {
                    itemQueue.Enqueue(row);
                }

                // 3. Dequeue each item, insert into OrderItems, and deduct StockQuantity in Products
                while (itemQueue.Count > 0)
                {
                    DataRow item = itemQueue.Dequeue();
                    int productId = Convert.ToInt32(item["ProductID"]);
                    int qty = Convert.ToInt32(item["Quantity"]);
                    decimal price = Convert.ToDecimal(item["Price"]);

                    // Insert into OrderItems
                    string insertItemQuery = "INSERT INTO OrderItems values('" + newOrderId + "','" + productId + "','" + qty + "','" + price + "')";
                    SqlCommand itemCmd = new SqlCommand(insertItemQuery, con);
                    itemCmd.ExecuteNonQuery();

                    // Deduct StockQuantity from Products table
                    string updateStockQuery = "UPDATE Products SET StockQuantity = StockQuantity - @Qty WHERE ProductID = @ProductID";
                    SqlCommand stockCmd = new SqlCommand(updateStockQuery, con);
                    stockCmd.Parameters.AddWithValue("@Qty", qty);
                    stockCmd.Parameters.AddWithValue("@ProductID", productId);
                    stockCmd.ExecuteNonQuery();
                }

                // 4. Clear user's Cart after order is placed
                string clearCartQuery = "DELETE FROM Cart WHERE UserID=@UserID";
                SqlCommand clearCmd = new SqlCommand(clearCartQuery, con);
                clearCmd.Parameters.AddWithValue("@UserID", userId);
                clearCmd.ExecuteNonQuery();

                // 5. Fire OnOrderPlaced Event (runs background thread)
                if (OnOrderPlaced != null)
                {
                    OnOrderPlaced(newOrderId, customerEmail, totalAmount);
                }
            }
            finally
            {
                con.Close();
            }

            Response.Redirect("Orders.aspx");
        }
    }
}