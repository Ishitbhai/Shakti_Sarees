using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class EditProfile : Page
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
                LoadUserData();
            }
        }

        // Syllabus Topic (Unit 7): Connected ADO.NET (SqlDataReader) to load profile data
        private void LoadUserData()
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
                    txtFullName.Text = dr["FullName"].ToString();
                    txtEmail.Text = dr["Email"].ToString();
                    txtMobile.Text = dr["MobileNumber"].ToString();
                    txtAddress.Text = dr["LocalAddress"].ToString();
                    txtCity.Text = dr["City"].ToString();
                    txtPincode.Text = dr["PinCode"].ToString();
                }
                dr.Close();
            }
            finally
            {
                con.Close();
            }
        }

        // Syllabus Topics: Unit 3 (Custom Exception), Unit 7 (UPDATE Query)
        protected void btnSaveProfile_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                string fullName = txtFullName.Text.Trim();
                string email = txtEmail.Text.Trim().ToLower();
                string mobile = txtMobile.Text.Trim();
                string address = txtAddress.Text.Trim();
                string city = txtCity.Text.Trim();
                string pincode = txtPincode.Text.Trim();

                SqlConnection con = new SqlConnection(connectionstring);
                try
                {
                    con.Open();

                    // Check if updated email is already taken by another user
                    string checkQuery = "SELECT COUNT(*) FROM Users WHERE Email=@Email AND UserID <> @UserID";
                    SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                    checkCmd.Parameters.AddWithValue("@Email", email);
                    checkCmd.Parameters.AddWithValue("@UserID", userId);

                    int existingCount = (int)checkCmd.ExecuteScalar();
                    if (existingCount > 0)
                    {
                        throw new DuplicateEmailException("This email address is already in use by another account!");
                    }

                    // Update Users table
                    string updateQuery = @"UPDATE Users 
                                           SET FullName=@FullName, Email=@Email, MobileNumber=@MobileNumber, 
                                               LocalAddress=@LocalAddress, City=@City, PinCode=@PinCode 
                                           WHERE UserID=@UserID";

                    SqlCommand cmd = new SqlCommand(updateQuery, con);
                    cmd.Parameters.AddWithValue("@FullName", fullName);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@MobileNumber", mobile);
                    cmd.Parameters.AddWithValue("@LocalAddress", address);
                    cmd.Parameters.AddWithValue("@City", city);
                    cmd.Parameters.AddWithValue("@PinCode", pincode);
                    cmd.Parameters.AddWithValue("@UserID", userId);

                    cmd.ExecuteNonQuery();

                    // Update Session values
                    Session["FullName"] = fullName;
                    Session["Email"] = email;

                    Response.Redirect("Profile.aspx");
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