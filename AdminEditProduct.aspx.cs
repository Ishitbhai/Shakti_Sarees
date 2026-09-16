using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shakti_Sarees
{
    public partial class AdminEditProduct : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void cvMainImage_ServerValidate(object source, ServerValidateEventArgs args)
        {
            // Valid if hidden field has existing path or new upload is supplied
            args.IsValid = !string.IsNullOrEmpty(hfMainImage.Value);
        }

        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                Response.Redirect("AdminProducts.aspx");
            }
        }
    }
}