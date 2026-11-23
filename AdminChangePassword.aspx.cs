using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class AdminChangePassword : Page
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
        }

        // Syllabus Topics: Unit 3 (Custom Exception & try-catch-finally), Unit 7 (Connected ADO.NET UPDATE)
        protected void btnUpdatePassword_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                int adminId = Convert.ToInt32(Session["UserID"]);
                string currentPass = txtCurrentPassword.Text;
                string newPass = txtNewPassword.Text;

                SqlConnection con = new SqlConnection(connectionstring);
                try
                {
                    con.Open();

                    // 1. Verify current password in Users table
                    string verifyQuery = "SELECT COUNT(*) FROM Users WHERE UserID=@UserID AND Password=@CurrentPassword";
                    SqlCommand verifyCmd = new SqlCommand(verifyQuery, con);
                    verifyCmd.Parameters.AddWithValue("@UserID", adminId);
                    verifyCmd.Parameters.AddWithValue("@CurrentPassword", currentPass);

                    int matchCount = (int)verifyCmd.ExecuteScalar();
                    if (matchCount == 0)
                    {
                        throw new IncorrectPasswordException("The current password you entered is incorrect!");
                    }

                    // 2. Update new password in Users table
                    string updateQuery = "UPDATE Users SET Password=@NewPassword WHERE UserID=@UserID";
                    SqlCommand updateCmd = new SqlCommand(updateQuery, con);
                    updateCmd.Parameters.AddWithValue("@NewPassword", newPass);
                    updateCmd.Parameters.AddWithValue("@UserID", adminId);

                    updateCmd.ExecuteNonQuery();

                    Response.Redirect("AdminProfile.aspx");
                }
                catch (IncorrectPasswordException ex)
                {
                    lblMsg.Text = ex.Message;
                    lblMsg.Visible = true;
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