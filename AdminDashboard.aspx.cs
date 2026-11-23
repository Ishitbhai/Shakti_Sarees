using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Shakti_Sarees
{
    // Syllabus Topic (Unit 2): OOP Interface for Dashboard Analytics
    public interface IDashboardMetrics
    {
        void LoadOverviewStatistics();
        void LoadRecentOrders();
    }

    public partial class AdminDashboard : Page, IDashboardMetrics
    {
        // Your exact connection string
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOverviewStatistics();
                LoadRecentOrders();
            }
        }

        // Syllabus Topic (Unit 2 & Unit 7): Interface implementation & ADO.NET ExecuteScalar
        public void LoadOverviewStatistics()
        {
            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                // 1. Total Users
                SqlCommand cmdUsers = new SqlCommand("SELECT COUNT(*) FROM Users", con);
                litTotalUsers.Text = Convert.ToInt32(cmdUsers.ExecuteScalar()).ToString("N0");

                // 2. Total Products
                SqlCommand cmdProducts = new SqlCommand("SELECT COUNT(*) FROM Products", con);
                litTotalProducts.Text = Convert.ToInt32(cmdProducts.ExecuteScalar()).ToString("N0");

                // 3. Total Orders
                SqlCommand cmdOrders = new SqlCommand("SELECT COUNT(*) FROM Orders", con);
                litTotalOrders.Text = Convert.ToInt32(cmdOrders.ExecuteScalar()).ToString("N0");

                // 4. Total Categories
                SqlCommand cmdCategories = new SqlCommand("SELECT COUNT(*) FROM Categories", con);
                litTotalCategories.Text = Convert.ToInt32(cmdCategories.ExecuteScalar()).ToString("N0");

                // 5. Pending / Processing Orders
                SqlCommand cmdPending = new SqlCommand("SELECT COUNT(*) FROM Orders WHERE OrderStatus IN ('Pending', 'Processing')", con);
                litPendingOrders.Text = Convert.ToInt32(cmdPending.ExecuteScalar()).ToString("N0");
            }
            finally
            {
                con.Close();
            }
        }

        // Syllabus Topic (Unit 7): ADO.NET Disconnected Model (SqlDataAdapter & DataTable)
        public void LoadRecentOrders()
        {
            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                string query = @"SELECT TOP 5 o.OrderID, u.FullName, o.OrderDate, o.TotalAmount, o.OrderStatus 
                                 FROM Orders o 
                                 INNER JOIN Users u ON o.UserID = u.UserID 
                                 ORDER BY o.OrderID DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptRecentOrders.DataSource = dt;
                rptRecentOrders.DataBind();
            }
            finally
            {
                con.Close();
            }
        }
    }
}