using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shakti_Sarees
{
    public partial class Products : Page
    {
        // Your exact connection string
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategoryCheckboxes();

                // Handle redirection from Category selection (supports both CategoryID or CategoryName)
                if (Request.QueryString["category"] != null)
                {
                    string catParam = Request.QueryString["category"].Trim();

                    foreach (ListItem item in cblCategories.Items)
                    {
                        if (item.Value.Equals(catParam, StringComparison.OrdinalIgnoreCase) ||
                            item.Text.IndexOf(catParam, StringComparison.OrdinalIgnoreCase) >= 0)
                        {
                            item.Selected = true;
                            litPageTitle.Text = item.Text + " Collection";
                        }
                    }
                }
                // Handle redirection from Search Bar
                else if (Request.QueryString["search"] != null)
                {
                    string query = Request.QueryString["search"].Trim();
                    litPageTitle.Text = "Search Results for \"" + Server.HtmlEncode(query) + "\"";
                }
                else
                {
                    litPageTitle.Text = "All Sarees";
                }

                LoadProducts();
            }
        }

        // Syllabus Topic (Unit 7): ADO.NET DataView & DataTable
        private void LoadCategoryCheckboxes()
        {
            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();
                string query = "SELECT CategoryID, CategoryName FROM Categories WHERE Status='Active'";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Syllabus Topic (Unit 7): Using DataView to sort categories alphabetically
                DataView dv = new DataView(dt);
                dv.Sort = "CategoryName ASC";

                cblCategories.DataSource = dv;
                cblCategories.DataBind();
            }
            finally
            {
                con.Close();
            }
        }

        // Syllabus Topics: Unit 4 (List<int>), Unit 5 (LINQ Method Syntax & Lambda Expressions), Unit 7 (DataTable)
        private void LoadProducts()
        {
            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                string query = @"SELECT p.ProductID, p.CategoryID, p.ProductName, p.ProductDescription, p.Price, p.MainImage, c.CategoryName 
                                 FROM Products p 
                                 INNER JOIN Categories c ON p.CategoryID = c.CategoryID 
                                 WHERE p.Status = 'Active' AND c.Status = 'Active' 
                                 ORDER BY p.ProductID DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Convert DataTable rows into an enumerable collection for LINQ filtering
                var productRows = dt.AsEnumerable();

                // 1. Filter by selected Category Checkboxes using LINQ & Lambda
                List<int> selectedCategoryIds = new List<int>();
                foreach (ListItem item in cblCategories.Items)
                {
                    if (item.Selected)
                    {
                        selectedCategoryIds.Add(Convert.ToInt32(item.Value));
                    }
                }

                if (selectedCategoryIds.Count > 0)
                {
                    productRows = productRows.Where(row => selectedCategoryIds.Contains(Convert.ToInt32(row["CategoryID"])));
                }

                // 2. Filter by Price Range (Min & Max)
                decimal minPrice = 0;
                decimal maxPrice = decimal.MaxValue;

                if (decimal.TryParse(txtMinPrice.Text.Trim(), out decimal parsedMin))
                {
                    minPrice = parsedMin;
                }
                if (decimal.TryParse(txtMaxPrice.Text.Trim(), out decimal parsedMax) && parsedMax > 0)
                {
                    maxPrice = parsedMax;
                }

                productRows = productRows.Where(row =>
                    Convert.ToDecimal(row["Price"]) >= minPrice &&
                    Convert.ToDecimal(row["Price"]) <= maxPrice);

                // 3. Filter by Search QueryString if present
                if (Request.QueryString["search"] != null)
                {
                    string searchKeyword = Request.QueryString["search"].Trim().ToLower();
                    if (!string.IsNullOrEmpty(searchKeyword))
                    {
                        productRows = productRows.Where(row =>
                            row["ProductName"].ToString().ToLower().Contains(searchKeyword) ||
                            row["ProductDescription"].ToString().ToLower().Contains(searchKeyword) ||
                            row["CategoryName"].ToString().ToLower().Contains(searchKeyword));
                    }
                }

                // Bind filtered results to Repeater (or empty table if no matches)
                if (productRows.Any())
                {
                    rptProducts.DataSource = productRows.CopyToDataTable();
                }
                else
                {
                    rptProducts.DataSource = null;
                }
                rptProducts.DataBind();
            }
            finally
            {
                con.Close();
            }
        }

        protected void btnApplyFilters_Click(object sender, EventArgs e)
        {
            LoadProducts();
        }

        protected void btnClearAll_Click(object sender, EventArgs e)
        {
            cblCategories.ClearSelection();
            txtMinPrice.Text = "0";
            txtMaxPrice.Text = "50000";
            litPageTitle.Text = "All Sarees";
            LoadProducts();
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            // Require login before adding to Cart
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            LinkButton btn = (LinkButton)sender;
            int productId = int.Parse(btn.CommandArgument);
            int userId = Convert.ToInt32(Session["UserID"]);

            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                // Check if this product is already in the user's Cart
                string checkQuery = "SELECT CartID, Quantity FROM Cart WHERE UserID=@UserID AND ProductID=@ProductID";
                SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                checkCmd.Parameters.AddWithValue("@UserID", userId);
                checkCmd.Parameters.AddWithValue("@ProductID", productId);

                SqlDataReader dr = checkCmd.ExecuteReader();
                if (dr.Read())
                {
                    int cartId = Convert.ToInt32(dr["CartID"]);
                    int currentQty = Convert.ToInt32(dr["Quantity"]);
                    dr.Close();

                    // Update existing cart item quantity (+1)
                    string updateQuery = "UPDATE Cart SET Quantity=@Quantity WHERE CartID=@CartID";
                    SqlCommand updateCmd = new SqlCommand(updateQuery, con);
                    updateCmd.Parameters.AddWithValue("@Quantity", currentQty + 1);
                    updateCmd.Parameters.AddWithValue("@CartID", cartId);
                    updateCmd.ExecuteNonQuery();
                }
                else
                {
                    dr.Close();

                    // Insert new cart item with Quantity = 1
                    string insertQuery = "INSERT INTO Cart values('" + userId + "','" + productId + "','1')";
                    SqlCommand insertCmd = new SqlCommand(insertQuery, con);
                    insertCmd.ExecuteNonQuery();
                }
            }
            finally
            {
                con.Close();
            }

            // Redirect to refresh header cart badge count cleanly
            Response.Redirect(Request.RawUrl);
        }
    }
}