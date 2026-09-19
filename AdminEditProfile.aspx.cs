using System;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class AdminEditProfile : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // In database phase: UPDATE admin profile details
                Response.Redirect("AdminProfile.aspx");
            }
        }
    }
}