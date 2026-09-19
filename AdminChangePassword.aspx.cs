using System;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class AdminChangePassword : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnUpdatePassword_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // In database phase: verify current password & update new password in Users table
                Response.Redirect("AdminProfile.aspx");
            }
        }
    }
}