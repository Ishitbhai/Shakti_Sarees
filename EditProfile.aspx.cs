using System;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class EditProfile : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSaveProfile_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // Navigate directly back to Profile
                Response.Redirect("Profile.aspx");
            }
        }
    }
}