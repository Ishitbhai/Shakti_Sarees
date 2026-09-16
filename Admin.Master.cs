using System;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class Admin : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogoutAdmin_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}