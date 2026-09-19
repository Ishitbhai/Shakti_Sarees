using System;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class AdminContact : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // In database phase: UPDATE contact settings table
                Response.Redirect("AdminContact.aspx");
            }
        }
    }
}