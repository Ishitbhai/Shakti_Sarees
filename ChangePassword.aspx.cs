using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace Shakti_Sarees
{
    // Syllabus Topic (Unit 3): Custom Exception for incorrect current password attempt
    public class IncorrectPasswordException : Exception
    {
        public IncorrectPasswordException(string message) : base(message)
        {
        }
    }

    public partial class ChangePassword : Page
    {
        // Your exact connection string
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Syllabus Topic (Unit 10): Require active Session state
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }
        }

        // Syllabus Topics: Unit 3 (Custom Exception), Unit 7 (Connected ADO.NET UPDATE Query)
        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                string currentPass = txtCurrentPassword.Text;
                string newPass = txtNewPassword.Text;

                SqlConnection con = new SqlConnection(connectionstring);
                try
                {
                    con.Open();

                    // 1. Verify current password in database
                    string verifyQuery = "SELECT COUNT(*) FROM Users WHERE UserID=@UserID AND Password=@CurrentPassword";
                    SqlCommand verifyCmd = new SqlCommand(verifyQuery, con);
                    verifyCmd.Parameters.AddWithValue("@UserID", userId);
                    verifyCmd.Parameters.AddWithValue("@CurrentPassword", currentPass);

                    int count = (int)verifyCmd.ExecuteScalar();
                    if (count == 0)
                    {
                        throw new IncorrectPasswordException("The current password you entered is incorrect!");
                    }

                    // 2. Update to new password
                    string updateQuery = "UPDATE Users SET Password=@NewPassword WHERE UserID=@UserID";
                    SqlCommand updateCmd = new SqlCommand(updateQuery, con);
                    updateCmd.Parameters.AddWithValue("@NewPassword", newPass);
                    updateCmd.Parameters.AddWithValue("@UserID", userId);
                    updateCmd.ExecuteNonQuery();

                    // Redirect to profile upon success
                    Response.Redirect("Profile.aspx");
                }
                catch (IncorrectPasswordException ex)
                {
                    // Dynamically inject error message into page if label exists, or register client script alert
                    ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", "alert('" + ex.Message + "');", true);
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", "alert('Error: " + ex.Message + "');", true);
                }
                finally
                {
                    con.Close();
                }
            }
        }
    }
}