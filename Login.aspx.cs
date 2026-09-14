using System;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string identifier = txtIdentifier.Text.Trim().ToLower();

                // Mock login logic for CIE-II UI testing:
                // Test Admin: enter "admin@shaktisarees.com" or "9999999999"
                if (identifier == "admin@shaktisarees.com" || identifier == "9999999999")
                {
                    Session["UserRole"] = "admin";
                    Session["UserName"] = "Admin";
                    Response.Redirect("~/Admin/Dashboard.aspx");
                }
                else
                {
                    // Regular customer login
                    Session["UserRole"] = "customer";
                    Session["UserName"] = identifier;
                    Response.Redirect("~/Default.aspx");
                }
            }
        }
    }
}