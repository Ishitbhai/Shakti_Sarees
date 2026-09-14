using System;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class Profile : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                // In DB phase: pull user details via ADO.NET using Session["UserId"]
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}