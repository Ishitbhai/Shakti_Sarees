using System;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class AdminAddUser : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // In database phase: INSERT user record into Users table
                Response.Redirect("AdminUsers.aspx");
            }
        }
    }
}