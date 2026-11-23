using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class AdminContact : Page
    {
        // Your exact connection string
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadContactSettings();
            }
        }

        // Syllabus Topic (Unit 7): Connected ADO.NET (SqlDataReader) to load PageContact details
        private void LoadContactSettings()
        {
            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                string query = "SELECT TOP 1 * FROM PageContact ORDER BY ContactID DESC";
                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    txtPageTitle.Text = dr["PageTitle"].ToString();
                    txtMainStory.Text = dr["MainStory"].ToString();
                    txtAddress.Text = dr["Address"].ToString();

                    // Strip +91 or spaces so the 10-digit validator works seamlessly
                    string rawPhone = dr["Phone"].ToString().Replace("+91", "").Replace(" ", "").Trim();
                    txtPhone.Text = rawPhone;

                    txtEmail.Text = dr["Email"].ToString();
                    txtBusinessHours.Text = dr["BusinessHours"].ToString();
                }
                dr.Close();
            }
            finally
            {
                con.Close();
            }
        }

        // Syllabus Topic (Unit 7): Connected ADO.NET Upsert (UPDATE if exists, INSERT if empty)
        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string pageTitle = txtPageTitle.Text.Trim();
                string mainStory = txtMainStory.Text.Trim();
                string address = txtAddress.Text.Trim();
                string phone = txtPhone.Text.Trim();
                string email = txtEmail.Text.Trim();
                string businessHours = txtBusinessHours.Text.Trim();

                SqlConnection con = new SqlConnection(connectionstring);
                try
                {
                    con.Open();

                    SqlCommand checkCmd = new SqlCommand("SELECT COUNT(*) FROM PageContact", con);
                    int count = (int)checkCmd.ExecuteScalar();

                    string query;
                    if (count > 0)
                    {
                        query = @"UPDATE PageContact 
                                  SET PageTitle=@PageTitle, MainStory=@MainStory, Address=@Address, 
                                      Phone=@Phone, Email=@Email, BusinessHours=@BusinessHours";
                    }
                    else
                    {
                        query = @"INSERT INTO PageContact 
                                  (PageTitle, MainStory, Address, Phone, Email, BusinessHours) 
                                  VALUES 
                                  (@PageTitle, @MainStory, @Address, @Phone, @Email, @BusinessHours)";
                    }

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@PageTitle", pageTitle);
                    cmd.Parameters.AddWithValue("@MainStory", mainStory);
                    cmd.Parameters.AddWithValue("@Address", address);
                    cmd.Parameters.AddWithValue("@Phone", phone);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@BusinessHours", businessHours);

                    cmd.ExecuteNonQuery();

                    Response.Redirect("AdminContact.aspx");
                }
                finally
                {
                    con.Close();
                }
            }
        }
    }
}