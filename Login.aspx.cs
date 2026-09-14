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

                Response.Redirect("~/Default.aspx");
               
            }
        }
    }
}