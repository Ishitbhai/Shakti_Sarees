using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shakti_Sarees
{
    public partial class AdminAddOrder : Page
    {
        // Your exact connection string
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtOrderDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                LoadCustomerEmailSuggestions();
                InitializeItemsTable();
            }
        }

        // Loads active customer emails into the <datalist> dropdown suggestion list
        private void LoadCustomerEmailSuggestions()
        {
            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();
                string query = "SELECT Email, FullName, Role FROM Users WHERE Status='Active' ORDER BY FullName ASC";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptCustomerEmails.DataSource = dt;
                rptCustomerEmails.DataBind();
            }
            finally
            {
                con.Close();
            }
        }

        // Helper to check available stock for a ProductID
        private int GetProductAvailableStock(int productId, out decimal price, out string productName)
        {
            price = 0;
            productName = "";
            int stock = -1; // -1 means ProductID not found

            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();
                string query = "SELECT ProductName, Price, StockQuantity FROM Products WHERE ProductID=@ProductID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ProductID", productId);

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    productName = dr["ProductName"].ToString();
                    price = Convert.ToDecimal(dr["Price"]);
                    stock = Convert.ToInt32(dr["StockQuantity"]);
                }
                dr.Close();
            }
            finally
            {
                con.Close();
            }
            return stock;
        }

        private void InitializeItemsTable()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("ProductID", typeof(string));
            dt.Columns.Add("Quantity", typeof(string));
            dt.Columns.Add("Price", typeof(string));

            dt.Rows.Add("", "1", "");

            ViewState["OrderItemsTable"] = dt;
            BindItemsRepeater();
        }

        private void BindItemsRepeater()
        {
            DataTable dt = (DataTable)ViewState["OrderItemsTable"];
            rptOrderItems.DataSource = dt;
            rptOrderItems.DataBind();
            RecalculateTotalAmount(dt);
        }

        private DataTable SyncRepeaterToDataTable()
        {
            DataTable dt = (DataTable)ViewState["OrderItemsTable"];
            for (int i = 0; i < rptOrderItems.Items.Count; i++)
            {
                RepeaterItem item = rptOrderItems.Items[i];
                TextBox txtPid = (TextBox)item.FindControl("txtProductID");
                TextBox txtQty = (TextBox)item.FindControl("txtQuantity");
                TextBox txtPrice = (TextBox)item.FindControl("txtItemPrice");

                dt.Rows[i]["ProductID"] = txtPid.Text.Trim();
                dt.Rows[i]["Quantity"] = txtQty.Text.Trim();
                dt.Rows[i]["Price"] = txtPrice.Text.Trim();
            }
            ViewState["OrderItemsTable"] = dt;
            return dt;
        }

        private void RecalculateTotalAmount(DataTable dt)
        {
            decimal grandTotal = 0;
            foreach (DataRow row in dt.Rows)
            {
                if (int.TryParse(row["Quantity"].ToString(), out int qty) &&
                    decimal.TryParse(row["Price"].ToString(), out decimal price))
                {
                    grandTotal += (qty * price);
                }
            }
            txtTotalAmount.Text = grandTotal.ToString("0.00");
        }

        // Auto-populates Product Price AND enforces StockQuantity limit when Product ID changes
        protected void txtProductID_TextChanged(object sender, EventArgs e)
        {
            lblMsg.Visible = false;
            DataTable dt = SyncRepeaterToDataTable();
            TextBox currentTxt = (TextBox)sender;
            RepeaterItem currentItem = (RepeaterItem)currentTxt.NamingContainer;
            int rowIndex = currentItem.ItemIndex;

            if (int.TryParse(currentTxt.Text.Trim(), out int productId))
            {
                int availableStock = GetProductAvailableStock(productId, out decimal unitPrice, out string prodName);

                if (availableStock == -1)
                {
                    lblMsg.Text = "Product ID #" + productId + " does not exist!";
                    lblMsg.Visible = true;
                    dt.Rows[rowIndex]["Price"] = "";
                }
                else if (availableStock == 0)
                {
                    lblMsg.Text = "Product #" + productId + " (" + prodName + ") is currently OUT OF STOCK (Available: 0)!";
                    lblMsg.Visible = true;
                    dt.Rows[rowIndex]["ProductID"] = "";
                    dt.Rows[rowIndex]["Quantity"] = "1";
                    dt.Rows[rowIndex]["Price"] = "";
                }
                else
                {
                    dt.Rows[rowIndex]["Price"] = unitPrice.ToString("0.00");

                    if (!int.TryParse(dt.Rows[rowIndex]["Quantity"].ToString(), out int reqQty) || reqQty < 1)
                    {
                        reqQty = 1;
                    }

                    if (reqQty > availableStock)
                    {
                        dt.Rows[rowIndex]["Quantity"] = availableStock.ToString();
                        lblMsg.Text = "Only " + availableStock + " unit(s) available for Product #" + productId + " (" + prodName + "). Quantity has been limited to " + availableStock + ".";
                        lblMsg.Visible = true;
                    }
                }
            }

            ViewState["OrderItemsTable"] = dt;
            BindItemsRepeater();
        }

        // Enforces StockQuantity limit immediately when Quantity or Price changes
        protected void txtItemField_TextChanged(object sender, EventArgs e)
        {
            lblMsg.Visible = false;
            DataTable dt = SyncRepeaterToDataTable();

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (int.TryParse(dt.Rows[i]["ProductID"].ToString(), out int productId) &&
                    int.TryParse(dt.Rows[i]["Quantity"].ToString(), out int reqQty))
                {
                    int availableStock = GetProductAvailableStock(productId, out _, out string prodName);
                    if (availableStock > 0 && reqQty > availableStock)
                    {
                        dt.Rows[i]["Quantity"] = availableStock.ToString();
                        lblMsg.Text = "Only " + availableStock + " unit(s) available for Product #" + productId + " (" + prodName + "). Quantity has been capped at " + availableStock + ".";
                        lblMsg.Visible = true;
                    }
                    else if (availableStock == 0)
                    {
                        dt.Rows[i]["Quantity"] = "0";
                        lblMsg.Text = "Product #" + productId + " (" + prodName + ") is out of stock!";
                        lblMsg.Visible = true;
                    }
                }
            }

            ViewState["OrderItemsTable"] = dt;
            BindItemsRepeater();
        }

        protected void btnAddRow_Click(object sender, EventArgs e)
        {
            DataTable dt = SyncRepeaterToDataTable();
            dt.Rows.Add("", "1", "");
            ViewState["OrderItemsTable"] = dt;
            BindItemsRepeater();
        }

        protected void btnRemoveRow_Click(object sender, EventArgs e)
        {
            DataTable dt = SyncRepeaterToDataTable();
            if (dt.Rows.Count > 1)
            {
                LinkButton btn = (LinkButton)sender;
                int rowIndex = int.Parse(btn.CommandArgument);
                dt.Rows.RemoveAt(rowIndex);
                ViewState["OrderItemsTable"] = dt;
                BindItemsRepeater();
            }
        }

        protected void btnCreateOrder_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                DataTable dt = SyncRepeaterToDataTable();
                RecalculateTotalAmount(dt);

                string customerEmail = txtCustomerEmail.Text.Trim();
                string orderDate = txtOrderDate.Text.Trim();
                string orderStatus = ddlOrderStatus.SelectedValue;
                decimal totalAmount = Convert.ToDecimal(txtTotalAmount.Text);

                SqlConnection con = new SqlConnection(connectionstring);
                try
                {
                    con.Open();

                    // 1. Verify Customer Email exists in Users table to get UserID
                    string userQuery = "SELECT UserID FROM Users WHERE LOWER(Email) = LOWER(@Email)";
                    SqlCommand userCmd = new SqlCommand(userQuery, con);
                    userCmd.Parameters.AddWithValue("@Email", customerEmail);
                    object userIdObj = userCmd.ExecuteScalar();

                    if (userIdObj == null || userIdObj == DBNull.Value)
                    {
                        lblMsg.Text = "No registered customer found with email: " + customerEmail;
                        lblMsg.Visible = true;
                        return;
                    }
                    int userId = Convert.ToInt32(userIdObj);

                    // 2. Aggregate requested quantities per ProductID and validate against StockQuantity
                    Dictionary<int, int> requestedTotals = new Dictionary<int, int>();
                    foreach (DataRow row in dt.Rows)
                    {
                        int pid = Convert.ToInt32(row["ProductID"]);
                        int qty = Convert.ToInt32(row["Quantity"]);

                        if (requestedTotals.ContainsKey(pid))
                            requestedTotals[pid] += qty;
                        else
                            requestedTotals[pid] = qty;
                    }

                    foreach (var kvp in requestedTotals)
                    {
                        int pid = kvp.Key;
                        int totalRequestedQty = kvp.Value;

                        SqlCommand checkProd = new SqlCommand("SELECT ProductName, StockQuantity FROM Products WHERE ProductID=@ProductID", con);
                        checkProd.Parameters.AddWithValue("@ProductID", pid);
                        SqlDataReader dr = checkProd.ExecuteReader();

                        if (!dr.Read())
                        {
                            dr.Close();
                            lblMsg.Text = "Product ID #" + pid + " does not exist in Products table!";
                            lblMsg.Visible = true;
                            return;
                        }

                        string prodName = dr["ProductName"].ToString();
                        int currentStock = Convert.ToInt32(dr["StockQuantity"]);
                        dr.Close();

                        if (totalRequestedQty > currentStock)
                        {
                            lblMsg.Text = "Insufficient stock for Product #" + pid + " (" + prodName + "). Available: " + currentStock + ", Requested: " + totalRequestedQty + ".";
                            lblMsg.Visible = true;
                            return;
                        }
                    }

                    // 3. Insert into Orders table
                    string insertOrderQuery = @"INSERT INTO Orders (UserID, CustomerEmail, OrderDate, TotalAmount, OrderStatus) 
                                                VALUES (@UserID, @CustomerEmail, @OrderDate, @TotalAmount, @OrderStatus); 
                                                SELECT SCOPE_IDENTITY();";
                    SqlCommand orderCmd = new SqlCommand(insertOrderQuery, con);
                    orderCmd.Parameters.AddWithValue("@UserID", userId);
                    orderCmd.Parameters.AddWithValue("@CustomerEmail", customerEmail);
                    orderCmd.Parameters.AddWithValue("@OrderDate", orderDate);
                    orderCmd.Parameters.AddWithValue("@TotalAmount", totalAmount);
                    orderCmd.Parameters.AddWithValue("@OrderStatus", orderStatus);

                    int newOrderId = Convert.ToInt32(orderCmd.ExecuteScalar());

                    // 4. Insert each row into OrderItems and deduct StockQuantity
                    foreach (DataRow row in dt.Rows)
                    {
                        int pid = Convert.ToInt32(row["ProductID"]);
                        int qty = Convert.ToInt32(row["Quantity"]);
                        decimal price = Convert.ToDecimal(row["Price"]);

                        string insertItemQuery = "INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (@OrderID, @ProductID, @Qty, @Price)";
                        SqlCommand itemCmd = new SqlCommand(insertItemQuery, con);
                        itemCmd.Parameters.AddWithValue("@OrderID", newOrderId);
                        itemCmd.Parameters.AddWithValue("@ProductID", pid);
                        itemCmd.Parameters.AddWithValue("@Qty", qty);
                        itemCmd.Parameters.AddWithValue("@Price", price);
                        itemCmd.ExecuteNonQuery();

                        string stockQuery = "UPDATE Products SET StockQuantity = StockQuantity - @Qty WHERE ProductID = @ProductID";
                        SqlCommand stockCmd = new SqlCommand(stockQuery, con);
                        stockCmd.Parameters.AddWithValue("@Qty", qty);
                        stockCmd.Parameters.AddWithValue("@ProductID", pid);
                        stockCmd.ExecuteNonQuery();
                    }

                    Response.Redirect("AdminOrders.aspx");
                }
                catch (Exception ex)
                {
                    lblMsg.Text = "Error: " + ex.Message;
                    lblMsg.Visible = true;
                }
                finally
                {
                    con.Close();
                }
            }
        }
    }
}