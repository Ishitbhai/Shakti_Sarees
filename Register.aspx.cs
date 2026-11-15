using System;
using System.Web.UI;
using System.Data.SqlClient;
using System.Threading;

namespace Shakti_Sarees
{
    // Syllabus Topic (Unit 3): Custom Exception for duplicate email registration
    public class DuplicateEmailException : Exception
    {
        public DuplicateEmailException(string message) : base(message)
        {
        }
    }

    // Syllabus Topic (Unit 3): Delegate declaration for registration notification
    public delegate void UserRegistrationHandler(string fullName, string email);

    public partial class Register : Page
    {
        // Your exact connection string
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        // Syllabus Topic (Unit 3 & Unit 6): Event and synchronization lock object
        public event UserRegistrationHandler OnUserRegistered;
        private static readonly object threadLock = new object();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] != null)
            {
                Response.Redirect("Default.aspx");
                return;
            }

            // Syllabus Topic (Unit 3): Subscribing to Event using a Lambda Expression
            OnUserRegistered += (name, mail) =>
            {
                Thread bgThread = new Thread(() =>
                {
                    lock (threadLock)
                    {
                        string logMessage = "New Customer Registered: " + name + " (" + mail + ")";
                    }
                });
                bgThread.IsBackground = true;
                bgThread.Start();
            };
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            // Validates all syllabus Validation Controls
            if (Page.IsValid)
            {
                SqlConnection con = new SqlConnection(connectionstring);

                // Syllabus Topic (Unit 3): Exception Handling (try-catch-finally)
                try
                {
                    con.Open();

                    // Syllabus Topic (Unit 1): String Operations (.Trim(), .ToLower())
                    string fullName = txtFullName.Text.Trim();
                    string email = txtEmail.Text.Trim().ToLower();
                    string mobile = txtMobile.Text.Trim();
                    string address = txtAddress.Text.Trim();
                    string city = txtCity.Text.Trim();
                    string pincode = txtPincode.Text.Trim();
                    string password = txtPassword.Text;

                    // Default values for a normal customer registration
                    string role = "Customer";
                    string status = "Active";

                    // 1. Check if email already exists in Users table
                    string checkQuery = "SELECT COUNT(*) FROM Users WHERE Email=@Email";
                    SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                    checkCmd.Parameters.AddWithValue("@Email", email);

                    int existingCount = (int)checkCmd.ExecuteScalar();
                    if (existingCount > 0)
                    {
                        // Throw Custom Exception if email is already registered
                        throw new DuplicateEmailException("This email address is already registered!");
                    }

                    // 2. Insert new customer into Users table using your exact SQL pattern
                    string query = "INSERT INTO Users values('" + fullName + "','" + email + "','" + mobile + "','" + address + "','" + city + "','" + pincode + "','" + password + "','" + role + "','" + status + "')";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.ExecuteNonQuery();

                    // Trigger the registration event (runs background thread)
                    if (OnUserRegistered != null)
                    {
                        OnUserRegistered(fullName, email);
                    }

                    // Show success message on UI
                    lblMessage.Text = "Account Created Successfully!";
                    lblMessage.CssClass = "ss-auth-msg ss-auth-msg-success";
                    lblMessage.Visible = true;

                    // Clear fields after successful database insert
                    txtFullName.Text = string.Empty;
                    txtMobile.Text = string.Empty;
                    txtEmail.Text = string.Empty;
                    txtAddress.Text = string.Empty;
                    txtCity.Text = string.Empty;
                    txtPincode.Text = string.Empty;
                }
                catch (DuplicateEmailException ex)
                {
                    lblMessage.Text = ex.Message;
                    lblMessage.CssClass = "ss-auth-msg";
                    lblMessage.Visible = true;
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error: " + ex.Message;
                    lblMessage.CssClass = "ss-auth-msg";
                    lblMessage.Visible = true;
                }
                finally
                {
                    // Always close connection in finally block
                    con.Close();
                }
            }
        }
    }
}