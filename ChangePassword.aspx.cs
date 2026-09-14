using System;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class ChangePassword : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // Navigates back to Profile on successful validation
                Response.Redirect("Profile.aspx");
            }
        }
    }
}