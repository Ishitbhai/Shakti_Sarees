using System;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class AdminEditUser : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnUpdateUser_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // In database phase: UPDATE user record in Users table
                Response.Redirect("AdminUsers.aspx");
            }
        }
    }
}