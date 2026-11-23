using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shakti_Sarees
{
    public partial class AdminOrders : Page
    {
        // Your exact connection string
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAllOrders();
            }
        }

        // Syllabus Topics: Unit 7 (DataSet, DataTable, DataRelation) & Unit 4 (List<string>)
        private void LoadAllOrders()
        {
            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                DataSet ds = new DataSet();

                // 1. Fetch all Orders joined with Users
                string ordersQuery = @"SELECT o.OrderID, o.UserID, o.CustomerEmail, o.OrderDate, o.TotalAmount, o.OrderStatus, u.FullName 
                                       FROM Orders o 
                                       LEFT JOIN Users u ON o.UserID = u.UserID 
                                       ORDER BY o.OrderID DESC";
                SqlDataAdapter daOrders = new SqlDataAdapter(ordersQuery, con);
                daOrders.Fill(ds, "Orders");

                if (ds.Tables["Orders"].Rows.Count == 0)
                {
                    rptOrders.DataSource = null;
                    rptOrders.DataBind();
                    return;
                }

                // 2. Fetch all OrderItems joined with Products and Categories
                string itemsQuery = @"SELECT oi.OrderID, oi.Quantity, p.ProductName, c.CategoryName 
                                      FROM OrderItems oi 
                                      INNER JOIN Products p ON oi.ProductID = p.ProductID 
                                      INNER JOIN Categories c ON p.CategoryID = c.CategoryID";
                SqlDataAdapter daItems = new SqlDataAdapter(itemsQuery, con);
                daItems.Fill(ds, "OrderItems");

                // 3. Link Orders and OrderItems via DataRelation
                DataRelation rel = new DataRelation(
                    "OrderToItemsRel",
                    ds.Tables["Orders"].Columns["OrderID"],
                    ds.Tables["OrderItems"].Columns["OrderID"],
                    false
                );
                ds.Relations.Add(rel);

                // Add computed columns for CategoryName and ProductSummary
                ds.Tables["Orders"].Columns.Add("CategoryName", typeof(string));
                ds.Tables["Orders"].Columns.Add("ProductSummary", typeof(string));

                foreach (DataRow orderRow in ds.Tables["Orders"].Rows)
                {
                    if (orderRow["FullName"] == DBNull.Value || string.IsNullOrWhiteSpace(orderRow["FullName"].ToString()))
                    {
                        orderRow["FullName"] = "Customer";
                    }

                    DataRow[] itemRows = orderRow.GetChildRows("OrderToItemsRel");
                    string firstCategory = "";
                    List<string> productNames = new List<string>();

                    foreach (DataRow item in itemRows)
                    {
                        if (string.IsNullOrEmpty(firstCategory))
                        {
                            firstCategory = item["CategoryName"].ToString();
                        }

                        int qty = Convert.ToInt32(item["Quantity"]);
                        string pName = item["ProductName"].ToString();
                        productNames.Add(qty > 1 ? qty + "x " + pName : pName);
                    }

                    orderRow["CategoryName"] = firstCategory;
                    orderRow["ProductSummary"] = string.Join(", ", productNames.ToArray());
                }

                rptOrders.DataSource = ds.Tables["Orders"];
                rptOrders.DataBind();
            }
            finally
            {
                con.Close();
            }
        }

        // Maps OrderStatus to the exact CSS classes in AdminOrders.css
        protected string GetStatusBadgeClass(string status)
        {
            string s = status.Trim().ToLower();
            if (s == "processing")
            {
                return "ss-badge-yellow";
            }
            else if (s == "shipped" || s == "out for delivery")
            {
                return "ss-badge-blue";
            }
            else if (s == "delivered")
            {
                return "ss-badge-green";
            }
            else
            {
                return "ss-badge-grey";
            }
        }

        // Syllabus Topic (Unit 7): Connected ADO.NET DELETE for OrderItems and Orders
        protected void btnDeleteOrder_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int orderId = int.Parse(btn.CommandArgument);

            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                // 1. Delete associated line items from OrderItems first (Foreign Key constraint)
                string delItemsQuery = "DELETE FROM OrderItems WHERE OrderID=@id";
                SqlCommand cmdItems = new SqlCommand(delItemsQuery, con);
                cmdItems.Parameters.AddWithValue("@id", orderId);
                cmdItems.ExecuteNonQuery();

                // 2. Delete the order from Orders table
                string delOrderQuery = "DELETE FROM Orders WHERE OrderID=@id";
                SqlCommand cmdOrder = new SqlCommand(delOrderQuery, con);
                cmdOrder.Parameters.AddWithValue("@id", orderId);
                cmdOrder.ExecuteNonQuery();
            }
            finally
            {
                con.Close();
            }

            LoadAllOrders();
        }
    }
}