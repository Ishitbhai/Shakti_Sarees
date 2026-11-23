using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shakti_Sarees
{
    public partial class AdminUsers : Page
    {
        // Your exact connection string
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAllUsers();
            }
        }

        // Syllabus Topic (Unit 7): ADO.NET Disconnected Model (SqlDataAdapter & DataTable)
        private void LoadAllUsers()
        {
            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                string query = "SELECT UserID, FullName, Email, MobileNumber, Role, Status FROM Users ORDER BY UserID DESC";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptUsers.DataSource = dt;
                rptUsers.DataBind();
            }
            finally
            {
                con.Close();
            }
        }

        // Syllabus Topic (Unit 7): ADO.NET Connected Model (DELETE / UPDATE Queries)
        protected void btnDeleteUser_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int targetUserId = int.Parse(btn.CommandArgument);

            // Prevent currently logged-in Admin from deleting their own active session account
            if (Session["UserID"] != null && Convert.ToInt32(Session["UserID"]) == targetUserId)
            {
                return;
            }

            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                // 1. Delete any items in Cart belonging to this user
                string delCartQuery = "DELETE FROM Cart WHERE UserID=@id";
                SqlCommand cmdCart = new SqlCommand(delCartQuery, con);
                cmdCart.Parameters.AddWithValue("@id", targetUserId);
                cmdCart.ExecuteNonQuery();

                // 2. Check if user has historical orders in Orders table
                string checkOrdersQuery = "SELECT COUNT(*) FROM Orders WHERE UserID=@id";
                SqlCommand checkCmd = new SqlCommand(checkOrdersQuery, con);
                checkCmd.Parameters.AddWithValue("@id", targetUserId);
                int orderCount = (int)checkCmd.ExecuteScalar();

                if (orderCount == 0)
                {
                    // Safe to permanently delete user from Users table
                    string delUserQuery = "DELETE FROM Users WHERE UserID=@id";
                    SqlCommand cmdDel = new SqlCommand(delUserQuery, con);
                    cmdDel.Parameters.AddWithValue("@id", targetUserId);
                    cmdDel.ExecuteNonQuery();
                }
                else
                {
                    // If user has past orders, mark Status = 'Inactive' to preserve Order History
                    string deactivateQuery = "UPDATE Users SET Status='Inactive' WHERE UserID=@id";
                    SqlCommand cmdDeactivate = new SqlCommand(deactivateQuery, con);
                    cmdDeactivate.Parameters.AddWithValue("@id", targetUserId);
                    cmdDeactivate.ExecuteNonQuery();
                }
            }
            finally
            {
                con.Close();
            }

            LoadAllUsers();
        }
    }
}