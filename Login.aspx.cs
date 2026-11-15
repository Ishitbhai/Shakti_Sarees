using System;
using System.Web.UI;
using System.Data.SqlClient;

namespace Shakti_Sarees
{
    public partial class Login : Page
    {
        // Your exact connection string
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] != null)
            {
                Response.Redirect("Default.aspx");
            }
        }

        // Syllabus Topic (Unit 1 & Unit 7): Method with 'out' parameters and ADO.NET Connected Model (SqlDataReader)
        private bool VerifyUserCredentials(string email, string password, out int userId, out string fullName, out string role, out string status)
        {
            userId = 0;
            fullName = "";
            role = "";
            status = "";
            bool isAuthenticated = false;

            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                // Matches strictly by Email and Password only
                string query = "SELECT UserID, FullName, Role, Status FROM Users WHERE Email=@Email AND Password=@Password";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", password);

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    userId = Convert.ToInt32(dr["UserID"]);
                    fullName = dr["FullName"].ToString();
                    role = dr["Role"].ToString();
                    status = dr["Status"].ToString();
                    isAuthenticated = true;
                }
                dr.Close();
            }
            finally
            {
                con.Close();
            }

            return isAuthenticated;
        }

        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    string email = txtIdentifier.Text.Trim().ToLower();
                    string password = txtPassword.Text;

                    int userId;
                    string fullName;
                    string role;
                    string status;

                    // Call authentication method using 'out' parameters
                    if (VerifyUserCredentials(email, password, out userId, out fullName, out role, out status))
                    {
                        // Check if account is Active
                        if (status == "Inactive")
                        {
                            lblLoginMsg.Text = "Your account is currently inactive. Please contact support.";
                            lblLoginMsg.CssClass = "ss-auth-msg";
                            lblLoginMsg.Visible = true;
                            return;
                        }

                        // Syllabus Topic (Unit 10): Server-Side State Management (Session)
                        Session["UserID"] = userId;
                        Session["FullName"] = fullName;
                        Session["Email"] = email;
                        Session["Role"] = role;

                        // Both Admin and Customer redirect to Default.aspx (Admin link is handled in Site.Master)
                        Response.Redirect("Default.aspx");
                    }
                    else
                    {
                        lblLoginMsg.Text = "Invalid email or password!";
                        lblLoginMsg.CssClass = "ss-auth-msg";
                        lblLoginMsg.Visible = true;
                    }
                }
                catch (Exception ex)
                {
                    lblLoginMsg.Text = "Error: " + ex.Message;
                    lblLoginMsg.CssClass = "ss-auth-msg";
                    lblLoginMsg.Visible = true;
                }
            }
        }
    }
}