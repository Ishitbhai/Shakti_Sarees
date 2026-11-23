using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class AdminProfile : Page
    {
        // Your exact connection string
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadAdminProfile();
            }
        }

        // Syllabus Topic (Unit 7): Connected ADO.NET (SqlDataReader) to fetch Admin profile details
        private void LoadAdminProfile()
        {
            int adminId = Convert.ToInt32(Session["UserID"]);
            SqlConnection con = new SqlConnection(connectionstring);

            try
            {
                con.Open();

                string query = "SELECT FullName, Email, MobileNumber, LocalAddress, City, PinCode FROM Users WHERE UserID=@UserID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserID", adminId);

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    litAdminName.Text = dr["FullName"].ToString();
                    litAdminEmail.Text = dr["Email"].ToString();
                    litAdminMobile.Text = "+91 " + dr["MobileNumber"].ToString();
                    litAdminAddress.Text = dr["City"].ToString() + ", " + dr["PinCode"].ToString();
                }
                dr.Close();
            }
            finally
            {
                con.Close();
            }
        }
    }
}