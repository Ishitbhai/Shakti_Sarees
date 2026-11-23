using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shakti_Sarees
{
    public partial class AdminEditOrder : Page
    {
        // Your exact connection string
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] == null || !int.TryParse(Request.QueryString["id"], out int orderId))
                {
                    Response.Redirect("AdminOrders.aspx");
                    return;
                }

                LoadCustomerEmailSuggestions();
                LoadOrderForEdit(orderId);
            }
        }

        // Loads customer emails into the <datalist> dropdown suggestion list
        private void LoadCustomerEmailSuggestions()
        {
            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();
                string query = "SELECT Email, FullName, Role FROM Users ORDER BY gitFullName ASC";
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

        // Returns effective available stock = Current StockQuantity in Products + Quantity already in this Order
        private int GetEffectiveAvailableStock(int orderId, int productId, out decimal price, out string productName)
        {
            price = 0;
            productName = "";
            int currentStock = -1;

            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                string prodQuery = "SELECT ProductName, Price, StockQuantity FROM Products WHERE ProductID=@ProductID";
                SqlCommand cmdProd = new SqlCommand(prodQuery, con);
                cmdProd.Parameters.AddWithValue("@ProductID", productId);

                SqlDataReader dr = cmdProd.ExecuteReader();
                if (dr.Read())
                {
                    productName = dr["ProductName"].ToString();
                    price = Convert.ToDecimal(dr["Price"]);
                    currentStock = Convert.ToInt32(dr["StockQuantity"]);
                }
                dr.Close();

                if (currentStock == -1)
                {
                    return -1; // Product does not exist
                }

                // Add back any quantity already reserved by this specific order
                string existingQtyQuery = "SELECT ISNULL(SUM(Quantity), 0) FROM OrderItems WHERE OrderID=@OrderID AND ProductID=@ProductID";
                SqlCommand cmdExisting = new SqlCommand(existingQtyQuery, con);
                cmdExisting.Parameters.AddWithValue("@OrderID", orderId);
                cmdExisting.Parameters.AddWithValue("@ProductID", productId);

                int reservedInOrder = Convert.ToInt32(cmdExisting.ExecuteScalar());
                return currentStock + reservedInOrder;
            }
            finally
            {
                con.Close();
            }
        }

        private void LoadOrderForEdit(int orderId)
        {
            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                // 1. Load Order Header Details
                string orderQuery = "SELECT CustomerEmail, OrderDate, TotalAmount, OrderStatus FROM Orders WHERE OrderID=@OrderID";
                SqlCommand cmdOrder = new SqlCommand(orderQuery, con);
                cmdOrder.Parameters.AddWithValue("@OrderID", orderId);

                SqlDataReader dr = cmdOrder.ExecuteReader();
                if (dr.Read())
                {
                    txtCustomerEmail.Text = dr["CustomerEmail"].ToString();
                    txtOrderDate.Text = Convert.ToDateTime(dr["OrderDate"]).ToString("yyyy-MM-dd");
                    txtTotalAmount.Text = Convert.ToDecimal(dr["TotalAmount"]).ToString("0.00");

                    string status = dr["OrderStatus"].ToString();
                    if (ddlOrderStatus.Items.FindByValue(status) != null)
                    {
                        ddlOrderStatus.SelectedValue = status;
                    }
                }
                else
                {
                    dr.Close();
                    Response.Redirect("AdminOrders.aspx");
                    return;
                }
                dr.Close();

                // 2. Load Order Line Items into DataTable
                string itemsQuery = "SELECT CAST(ProductID AS VARCHAR(20)) AS ProductID, CAST(Quantity AS VARCHAR(20)) AS Quantity, CAST(Price AS VARCHAR(20)) AS Price FROM OrderItems WHERE OrderID=@OrderID";
                SqlCommand cmdItems = new SqlCommand(itemsQuery, con);
                cmdItems.Parameters.AddWithValue("@OrderID", orderId);

                SqlDataAdapter da = new SqlDataAdapter(cmdItems);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    dt.Columns.Add("ProductID", typeof(string));
                    dt.Columns.Add("Quantity", typeof(string));
                    dt.Columns.Add("Price", typeof(string));
                    dt.Rows.Add("", "1", "");
                }

                ViewState["EditOrderItemsTable"] = dt;
                BindItemsRepeater();
            }
            finally
            {
                con.Close();
            }
        }

        private void BindItemsRepeater()
        {
            DataTable dt = (DataTable)ViewState["EditOrderItemsTable"];
            rptOrderItems.DataSource = dt;
            rptOrderItems.DataBind();
            RecalculateTotalAmount(dt);
        }

        private DataTable SyncRepeaterToDataTable()
        {
            DataTable dt = (DataTable)ViewState["EditOrderItemsTable"];
            for (int i = 0; i < rptOrderItems.Items.Count; i++)
            {
                RepeaterItem item = rptOrderItems.Items[i];
                TextBox txtPid = (TextBox)item.FindControl("txtProductId");
                TextBox txtQty = (TextBox)item.FindControl("txtQuantity");
                TextBox txtPrice = (TextBox)item.FindControl("txtItemPrice");

                dt.Rows[i]["ProductID"] = txtPid.Text.Trim();
                dt.Rows[i]["Quantity"] = txtQty.Text.Trim();
                dt.Rows[i]["Price"] = txtPrice.Text.Trim();
            }
            ViewState["EditOrderItemsTable"] = dt;
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

        protected void txtProductId_TextChanged(object sender, EventArgs e)
        {
            lblMsg.Visible = false;
            int orderId = int.Parse(Request.QueryString["id"]);
            DataTable dt = SyncRepeaterToDataTable();
            TextBox currentTxt = (TextBox)sender;
            RepeaterItem currentItem = (RepeaterItem)currentTxt.NamingContainer;
            int rowIndex = currentItem.ItemIndex;

            if (int.TryParse(currentTxt.Text.Trim(), out int productId))
            {
                int maxAvailable = GetEffectiveAvailableStock(orderId, productId, out decimal unitPrice, out string prodName);

                if (maxAvailable == -1)
                {
                    lblMsg.Text = "Product ID #" + productId + " does not exist!";
                    lblMsg.Visible = true;
                    dt.Rows[rowIndex]["Price"] = "";
                }
                else if (maxAvailable == 0)
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

                    if (reqQty > maxAvailable)
                    {
                        dt.Rows[rowIndex]["Quantity"] = maxAvailable.ToString();
                        lblMsg.Text = "Maximum available stock for Product #" + productId + " (" + prodName + ") is " + maxAvailable + ". Quantity has been limited to " + maxAvailable + ".";
                        lblMsg.Visible = true;
                    }
                }
            }

            ViewState["EditOrderItemsTable"] = dt;
            BindItemsRepeater();
        }

        protected void txtItemField_TextChanged(object sender, EventArgs e)
        {
            lblMsg.Visible = false;
            int orderId = int.Parse(Request.QueryString["id"]);
            DataTable dt = SyncRepeaterToDataTable();

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (int.TryParse(dt.Rows[i]["ProductID"].ToString(), out int productId) &&
                    int.TryParse(dt.Rows[i]["Quantity"].ToString(), out int reqQty))
                {
                    int maxAvailable = GetEffectiveAvailableStock(orderId, productId, out _, out string prodName);
                    if (maxAvailable > 0 && reqQty > maxAvailable)
                    {
                        dt.Rows[i]["Quantity"] = maxAvailable.ToString();
                        lblMsg.Text = "Only " + maxAvailable + " unit(s) available for Product #" + productId + " (" + prodName + "). Quantity has been capped at " + maxAvailable + ".";
                        lblMsg.Visible = true;
                    }
                    else if (maxAvailable == 0)
                    {
                        dt.Rows[i]["Quantity"] = "0";
                        lblMsg.Text = "Product #" + productId + " (" + prodName + ") is out of stock!";
                        lblMsg.Visible = true;
                    }
                }
            }

            ViewState["EditOrderItemsTable"] = dt;
            BindItemsRepeater();
        }

        protected void btnAddRow_Click(object sender, EventArgs e)
        {
            DataTable dt = SyncRepeaterToDataTable();
            dt.Rows.Add("", "1", "");
            ViewState["EditOrderItemsTable"] = dt;
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
                ViewState["EditOrderItemsTable"] = dt;
                BindItemsRepeater();
            }
        }

        protected void btnEditOrder_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                int orderId = int.Parse(Request.QueryString["id"]);
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

                    // 1. Verify Customer Email exists in Users table
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

                    // 2. Aggregate requested quantities per ProductID and validate against Effective Stock
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

                        int maxAvailable = GetEffectiveAvailableStock(orderId, pid, out _, out string prodName);
                        if (maxAvailable == -1)
                        {
                            lblMsg.Text = "Product ID #" + pid + " does not exist in Products table!";
                            lblMsg.Visible = true;
                            return;
                        }

                        if (totalRequestedQty > maxAvailable)
                        {
                            lblMsg.Text = "Insufficient stock for Product #" + pid + " (" + prodName + "). Maximum available: " + maxAvailable + ", Requested: " + totalRequestedQty + ".";
                            lblMsg.Visible = true;
                            return;
                        }
                    }

                    // 3. Restore stock from previous OrderItems of this Order before replacing them
                    string oldItemsQuery = "SELECT ProductID, Quantity FROM OrderItems WHERE OrderID=@OrderID";
                    SqlCommand cmdOld = new SqlCommand(oldItemsQuery, con);
                    cmdOld.Parameters.AddWithValue("@OrderID", orderId);
                    DataTable dtOld = new DataTable();
                    SqlDataAdapter daOld = new SqlDataAdapter(cmdOld);
                    daOld.Fill(dtOld);

                    foreach (DataRow oldRow in dtOld.Rows)
                    {
                        int oldPid = Convert.ToInt32(oldRow["ProductID"]);
                        int oldQty = Convert.ToInt32(oldRow["Quantity"]);

                        SqlCommand restoreStock = new SqlCommand("UPDATE Products SET StockQuantity = StockQuantity + @Qty WHERE ProductID=@ProductID", con);
                        restoreStock.Parameters.AddWithValue("@Qty", oldQty);
                        restoreStock.Parameters.AddWithValue("@ProductID", oldPid);
                        restoreStock.ExecuteNonQuery();
                    }

                    // 4. Update Orders table
                    string updateOrderQuery = @"UPDATE Orders 
                                                SET UserID=@UserID, CustomerEmail=@CustomerEmail, OrderDate=@OrderDate, 
                                                    TotalAmount=@TotalAmount, OrderStatus=@OrderStatus 
                                                WHERE OrderID=@OrderID";
                    SqlCommand orderCmd = new SqlCommand(updateOrderQuery, con);
                    orderCmd.Parameters.AddWithValue("@UserID", userId);
                    orderCmd.Parameters.AddWithValue("@CustomerEmail", customerEmail);
                    orderCmd.Parameters.AddWithValue("@OrderDate", orderDate);
                    orderCmd.Parameters.AddWithValue("@TotalAmount", totalAmount);
                    orderCmd.Parameters.AddWithValue("@OrderStatus", orderStatus);
                    orderCmd.Parameters.AddWithValue("@OrderID", orderId);
                    orderCmd.ExecuteNonQuery();

                    // 5. Replace OrderItems and deduct the newly updated Quantities from StockQuantity
                    SqlCommand delItems = new SqlCommand("DELETE FROM OrderItems WHERE OrderID=@OrderID", con);
                    delItems.Parameters.AddWithValue("@OrderID", orderId);
                    delItems.ExecuteNonQuery();

                    foreach (DataRow row in dt.Rows)
                    {
                        int pid = Convert.ToInt32(row["ProductID"]);
                        int qty = Convert.ToInt32(row["Quantity"]);
                        decimal price = Convert.ToDecimal(row["Price"]);

                        string insertItemQuery = "INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES (@OrderID, @ProductID, @Qty, @Price)";
                        SqlCommand itemCmd = new SqlCommand(insertItemQuery, con);
                        itemCmd.Parameters.AddWithValue("@OrderID", orderId);
                        itemCmd.Parameters.AddWithValue("@ProductID", pid);
                        itemCmd.Parameters.AddWithValue("@Qty", qty);
                        itemCmd.Parameters.AddWithValue("@Price", price);
                        itemCmd.ExecuteNonQuery();

                        SqlCommand deductStock = new SqlCommand("UPDATE Products SET StockQuantity = CASE WHEN StockQuantity >= @Qty THEN StockQuantity - @Qty ELSE 0 END WHERE ProductID=@ProductID", con);
                        deductStock.Parameters.AddWithValue("@Qty", qty);
                        deductStock.Parameters.AddWithValue("@ProductID", pid);
                        deductStock.ExecuteNonQuery();
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