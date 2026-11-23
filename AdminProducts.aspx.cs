using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shakti_Sarees
{
    public partial class AdminProducts : Page
    {
        // Your exact connection string
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadInventoryProducts();
            }
        }

        // Syllabus Topic (Unit 7): ADO.NET Disconnected Model (SqlDataAdapter & DataTable)
        private void LoadInventoryProducts()
        {
            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                string query = @"SELECT p.ProductID, p.ProductName, p.Price, p.StockQuantity, p.MainImage, p.Status, c.CategoryName 
                                 FROM Products p 
                                 INNER JOIN Categories c ON p.CategoryID = c.CategoryID 
                                 ORDER BY p.ProductID DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptProducts.DataSource = dt;
                rptProducts.DataBind();
            }
            finally
            {
                con.Close();
            }
        }

        // Syllabus Topic (Unit 7): ADO.NET Connected Model (DELETE / UPDATE Queries)
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int productId = int.Parse(btn.CommandArgument);

            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                // 1. Remove product from any active customer Cart first
                string deleteCartQuery = "DELETE FROM Cart WHERE ProductID=@id";
                SqlCommand cartCmd = new SqlCommand(deleteCartQuery, con);
                cartCmd.Parameters.AddWithValue("@id", productId);
                cartCmd.ExecuteNonQuery();

                // 2. Check if product is referenced in historical OrderItems
                string checkOrderQuery = "SELECT COUNT(*) FROM OrderItems WHERE ProductID=@id";
                SqlCommand checkCmd = new SqlCommand(checkOrderQuery, con);
                checkCmd.Parameters.AddWithValue("@id", productId);
                int orderCount = (int)checkCmd.ExecuteScalar();

                if (orderCount == 0)
                {
                    // Safe to permanently delete from Products table
                    string deleteQuery = "delete from Products where ProductID=@id";
                    SqlCommand cmd = new SqlCommand(deleteQuery, con);
                    cmd.Parameters.AddWithValue("@id", productId);
                    cmd.ExecuteNonQuery();
                }
                else
                {
                    // If already ordered in the past, mark as Inactive and Stock = 0 to preserve Order History
                    string archiveQuery = "UPDATE Products SET Status='Inactive', StockQuantity=0 WHERE ProductID=@id";
                    SqlCommand archiveCmd = new SqlCommand(archiveQuery, con);
                    archiveCmd.Parameters.AddWithValue("@id", productId);
                    archiveCmd.ExecuteNonQuery();
                }
            }
            finally
            {
                con.Close();
            }

            LoadInventoryProducts();
        }
    }
}