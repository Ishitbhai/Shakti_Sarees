using System;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class Register : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            // Validates all syllabus Validation Controls
            if (Page.IsValid)
            {
                // In CIE-II Design phase: confirm successful validation
                lblMessage.Text = "Account Created Successfully!";
                lblMessage.CssClass = "ss-auth-msg ss-auth-msg-success";
                lblMessage.Visible = true;

                // Clears fields after successful design validation
                txtFullName.Text = string.Empty;
                txtMobile.Text = string.Empty;
                txtEmail.Text = string.Empty;
                txtAddress.Text = string.Empty;
                txtCity.Text = string.Empty;
                txtPincode.Text = string.Empty;
            }
        }
    }
}