using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shakti_Sarees
{
    public partial class AdminCategories : Page
    {
        // Your exact connection string
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
            }
        }

        // Syllabus Topic (Unit 7): ADO.NET Disconnected Model (SqlDataAdapter & DataTable)
        private void LoadCategories()
        {
            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                string query = "SELECT CategoryID, CategoryName, Status FROM Categories ORDER BY CategoryID ASC";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptCategories.DataSource = dt;
                rptCategories.DataBind();
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
            int categoryId = int.Parse(btn.CommandArgument);

            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                // Check if any products exist under this category
                string checkQuery = "SELECT COUNT(*) FROM Products WHERE CategoryID=@id";
                SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                checkCmd.Parameters.AddWithValue("@id", categoryId);
                int productCount = (int)checkCmd.ExecuteScalar();

                if (productCount == 0)
                {
                    // Safe to permanently delete from Categories table
                    string deleteQuery = "delete from Categories where CategoryID=@id";
                    SqlCommand cmd = new SqlCommand(deleteQuery, con);
                    cmd.Parameters.AddWithValue("@id", categoryId);
                    cmd.ExecuteNonQuery();
                }
                else
                {
                    // If products are linked to this category, mark Category and its Products as Inactive
                    string deactivateProducts = "UPDATE Products SET Status='Inactive' WHERE CategoryID=@id";
                    SqlCommand prodCmd = new SqlCommand(deactivateProducts, con);
                    prodCmd.Parameters.AddWithValue("@id", categoryId);
                    prodCmd.ExecuteNonQuery();

                    string deactivateCategory = "UPDATE Categories SET Status='Inactive' WHERE CategoryID=@id";
                    SqlCommand catCmd = new SqlCommand(deactivateCategory, con);
                    catCmd.Parameters.AddWithValue("@id", categoryId);
                    catCmd.ExecuteNonQuery();
                }
            }
            finally
            {
                con.Close();
            }

            LoadCategories();
        }
    }
}