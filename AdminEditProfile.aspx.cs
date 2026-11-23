using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class AdminEditProfile : Page
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
                LoadAdminData();
            }
        }

        // Syllabus Topic (Unit 7): Connected ADO.NET (SqlDataReader) to load Admin profile details
        private void LoadAdminData()
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
                    txtFullName.Text = dr["FullName"].ToString();
                    txtEmail.Text = dr["Email"].ToString();

                    // Ensure 10-digit format for validator
                    string rawMobile = dr["MobileNumber"].ToString().Replace("+91", "").Replace(" ", "").Trim();
                    txtMobile.Text = rawMobile;

                    txtLocalAddress.Text = dr["LocalAddress"].ToString();
                    txtCity.Text = dr["City"].ToString();
                    txtPinCode.Text = dr["PinCode"].ToString();
                }
                dr.Close();
            }
            finally
            {
                con.Close();
            }
        }

        // Syllabus Topics: Unit 3 (Custom Exception & try-catch-finally), Unit 7 (Connected ADO.NET UPDATE)
        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                int adminId = Convert.ToInt32(Session["UserID"]);
                string fullName = txtFullName.Text.Trim();
                string email = txtEmail.Text.Trim().ToLower();
                string mobile = txtMobile.Text.Trim();
                string localAddress = txtLocalAddress.Text.Trim();
                string city = txtCity.Text.Trim();
                string pinCode = txtPinCode.Text.Trim();

                SqlConnection con = new SqlConnection(connectionstring);
                try
                {
                    con.Open();

                    // 1. Check if updated email is already taken by another account
                    string checkQuery = "SELECT COUNT(*) FROM Users WHERE LOWER(Email) = LOWER(@Email) AND UserID <> @UserID";
                    SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                    checkCmd.Parameters.AddWithValue("@Email", email);
                    checkCmd.Parameters.AddWithValue("@UserID", adminId);

                    int existingCount = (int)checkCmd.ExecuteScalar();
                    if (existingCount > 0)
                    {
                        throw new DuplicateEmailException("This email address is already in use by another account!");
                    }

                    // 2. Update Admin profile record in Users table
                    string updateQuery = @"UPDATE Users 
                                           SET FullName=@FullName, Email=@Email, MobileNumber=@MobileNumber, 
                                               LocalAddress=@LocalAddress, City=@City, PinCode=@PinCode 
                                           WHERE UserID=@UserID";

                    SqlCommand cmd = new SqlCommand(updateQuery, con);
                    cmd.Parameters.AddWithValue("@FullName", fullName);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@MobileNumber", mobile);
                    cmd.Parameters.AddWithValue("@LocalAddress", localAddress);
                    cmd.Parameters.AddWithValue("@City", city);
                    cmd.Parameters.AddWithValue("@PinCode", pinCode);
                    cmd.Parameters.AddWithValue("@UserID", adminId);

                    cmd.ExecuteNonQuery();

                    // Update active Session values
                    Session["FullName"] = fullName;
                    Session["Email"] = email;

                    Response.Redirect("AdminProfile.aspx");
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