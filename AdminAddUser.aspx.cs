using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class AdminAddUser : Page
    {
        // Your exact connection string
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        // Syllabus Topics: Unit 3 (Exception Handling & Custom Exception), Unit 7 (Connected ADO.NET INSERT)
        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string fullName = txtFullName.Text.Trim();
                string email = txtEmail.Text.Trim().ToLower();
                string mobile = txtContactNumber.Text.Trim();
                string localAddress = txtLocalAddress.Text.Trim();
                string city = txtCity.Text.Trim();
                string pinCode = txtPinCode.Text.Trim();
                string password = txtPassword.Text;
                string role = ddlRole.SelectedValue;
                string status = rbInactive.Checked ? "Inactive" : "Active";

                SqlConnection con = new SqlConnection(connectionstring);
                try
                {
                    con.Open();

                    // 1. Check if Email is already registered in Users table
                    string checkQuery = "SELECT COUNT(*) FROM Users WHERE LOWER(Email) = LOWER(@Email)";
                    SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                    checkCmd.Parameters.AddWithValue("@Email", email);

                    int existingCount = (int)checkCmd.ExecuteScalar();
                    if (existingCount > 0)
                    {
                        throw new DuplicateEmailException("A user with this email address already exists!");
                    }

                    // 2. Insert new user into Users table
                    string insertQuery = @"INSERT INTO Users 
                                           (FullName, Email, MobileNumber, LocalAddress, City, PinCode, Password, Role, Status) 
                                           VALUES 
                                           (@FullName, @Email, @MobileNumber, @LocalAddress, @City, @PinCode, @Password, @Role, @Status)";

                    SqlCommand cmd = new SqlCommand(insertQuery, con);
                    cmd.Parameters.AddWithValue("@FullName", fullName);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@MobileNumber", mobile);
                    cmd.Parameters.AddWithValue("@LocalAddress", localAddress);
                    cmd.Parameters.AddWithValue("@City", city);
                    cmd.Parameters.AddWithValue("@PinCode", pinCode);
                    cmd.Parameters.AddWithValue("@Password", password);
                    cmd.Parameters.AddWithValue("@Role", role);
                    cmd.Parameters.AddWithValue("@Status", status);

                    cmd.ExecuteNonQuery();

                    Response.Redirect("AdminUsers.aspx");
                }
                catch (DuplicateEmailException ex)
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