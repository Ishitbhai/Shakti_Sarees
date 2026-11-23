using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class AdminEditUser : Page
    {
        // Your exact connection string
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] == null || !int.TryParse(Request.QueryString["id"], out int userId))
                {
                    Response.Redirect("AdminUsers.aspx");
                    return;
                }

                LoadUserForEdit(userId);
            }
        }

        // Syllabus Topic (Unit 7): Connected ADO.NET (SqlDataReader) to load user details
        private void LoadUserForEdit(int userId)
        {
            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                string query = "SELECT FullName, Email, MobileNumber, LocalAddress, City, PinCode, Role, Status FROM Users WHERE UserID=@UserID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserID", userId);

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtFullName.Text = dr["FullName"].ToString();
                    txtEmail.Text = dr["Email"].ToString();
                    txtContactNumber.Text = dr["MobileNumber"].ToString();
                    txtLocalAddress.Text = dr["LocalAddress"].ToString();
                    txtCity.Text = dr["City"].ToString();
                    txtPinCode.Text = dr["PinCode"].ToString();

                    string role = dr["Role"].ToString();
                    if (ddlRole.Items.FindByValue(role) != null)
                    {
                        ddlRole.SelectedValue = role;
                    }

                    string status = dr["Status"].ToString();
                    if (status == "Inactive")
                    {
                        rbInactive.Checked = true;
                        rbActive.Checked = false;
                    }
                    else
                    {
                        rbActive.Checked = true;
                        rbInactive.Checked = false;
                    }
                }
                else
                {
                    dr.Close();
                    Response.Redirect("AdminUsers.aspx");
                    return;
                }
                dr.Close();
            }
            finally
            {
                con.Close();
            }
        }

        // Syllabus Topics: Unit 3 (Exception Handling & Custom Exception), Unit 7 (Connected ADO.NET UPDATE)
        protected void btnUpdateUser_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                int userId = int.Parse(Request.QueryString["id"]);
                string fullName = txtFullName.Text.Trim();
                string email = txtEmail.Text.Trim().ToLower();
                string mobile = txtContactNumber.Text.Replace(" ", "").Trim();
                string localAddress = txtLocalAddress.Text.Trim();
                string city = txtCity.Text.Trim();
                string pinCode = txtPinCode.Text.Trim();
                string newPassword = txtPassword.Text;
                string role = ddlRole.SelectedValue;
                string status = rbInactive.Checked ? "Inactive" : "Active";

                SqlConnection con = new SqlConnection(connectionstring);
                try
                {
                    con.Open();

                    // 1. Check if another user already uses this email
                    string checkQuery = "SELECT COUNT(*) FROM Users WHERE LOWER(Email) = LOWER(@Email) AND UserID <> @UserID";
                    SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                    checkCmd.Parameters.AddWithValue("@Email", email);
                    checkCmd.Parameters.AddWithValue("@UserID", userId);

                    int existingCount = (int)checkCmd.ExecuteScalar();
                    if (existingCount > 0)
                    {
                        throw new DuplicateEmailException("Another user account is already registered with this email!");
                    }

                    // 2. Update Users record (update Password only if admin entered a new password)
                    string updateQuery;
                    if (!string.IsNullOrEmpty(newPassword))
                    {
                        updateQuery = @"UPDATE Users 
                                        SET FullName=@FullName, Email=@Email, MobileNumber=@MobileNumber, 
                                            LocalAddress=@LocalAddress, City=@City, PinCode=@PinCode, 
                                            Password=@Password, Role=@Role, Status=@Status 
                                        WHERE UserID=@UserID";
                    }
                    else
                    {
                        updateQuery = @"UPDATE Users 
                                        SET FullName=@FullName, Email=@Email, MobileNumber=@MobileNumber, 
                                            LocalAddress=@LocalAddress, City=@City, PinCode=@PinCode, 
                                            Role=@Role, Status=@Status 
                                        WHERE UserID=@UserID";
                    }

                    SqlCommand cmd = new SqlCommand(updateQuery, con);
                    cmd.Parameters.AddWithValue("@FullName", fullName);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@MobileNumber", mobile);
                    cmd.Parameters.AddWithValue("@LocalAddress", localAddress);
                    cmd.Parameters.AddWithValue("@City", city);
                    cmd.Parameters.AddWithValue("@PinCode", pinCode);
                    cmd.Parameters.AddWithValue("@Role", role);
                    cmd.Parameters.AddWithValue("@Status", status);
                    cmd.Parameters.AddWithValue("@UserID", userId);

                    if (!string.IsNullOrEmpty(newPassword))
                    {
                        cmd.Parameters.AddWithValue("@Password", newPassword);
                    }

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