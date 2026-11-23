using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class Profile : Page
    {
        // Your exact connection string
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Syllabus Topic (Unit 10): Require active Session state to view Profile
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadUserProfile();
            }
        }

        // Syllabus Topic (Unit 7): Connected Model (SqlDataReader) to fetch user record
        private void LoadUserProfile()
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
                    litFullName.Text = dr["FullName"].ToString();
                    litEmail.Text = dr["Email"].ToString();
                    litMobile.Text = "+91 " + dr["MobileNumber"].ToString();
                    litAddress.Text = dr["City"].ToString() + ", " + dr["PinCode"].ToString();
                }
                dr.Close();
            }
            finally
            {
                con.Close();
            }
        }

        // Syllabus Topic (Unit 10): Server-Side State Management (Clearing and Abandoning Session on Logout)
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}