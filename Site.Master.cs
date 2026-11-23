using System;
using System.Web.UI;
using System.Data.SqlClient;

namespace Shakti_Sarees
{
    public partial class Site : MasterPage
    {
        // Your exact connection string
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            ApplyHeaderState();
            LoadCartCount();
        }

        private void ApplyHeaderState()
        {
            // Reset all header placeholders first
            phGuestActions.Visible = false;
            phCustomerActions.Visible = false;
            phAdminActions.Visible = false;

            // Syllabus Topic (Unit 10 & Unit 1): Check Session State with Conditional Statements
            if (Session["Role"] != null)
            {
                string userRole = Session["Role"].ToString();

                if (userRole == "Admin")
                {
                    phAdminActions.Visible = true;
                }
                else
                {
                    phCustomerActions.Visible = true;
                }
            }
            else
            {
                phGuestActions.Visible = true;
            }
        }

        private void LoadCartCount()
        {
            if (Session["UserID"] != null)
            {
                SqlConnection con = new SqlConnection(connectionstring);
                try
                {
                    con.Open();

                    // Sum total quantity of items in Cart for the logged-in user
                    string query = "SELECT ISNULL(SUM(Quantity), 0) FROM Cart WHERE UserID=@UserID";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@UserID", Convert.ToInt32(Session["UserID"]));

                    int totalItems = Convert.ToInt32(cmd.ExecuteScalar());
                    litCartCount.Text = totalItems.ToString();
                }
                catch
                {
                    litCartCount.Text = "0";
                }
                finally
                {
                    con.Close();
                }
            }
            else
            {
                litCartCount.Text = "0";
            }
        }

        protected void btnSearchHidden_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtSearch.Text))
            {
                Response.Redirect("~/Products.aspx?search=" + Server.UrlEncode(txtSearch.Text.Trim()));
            }
        }
    }
}