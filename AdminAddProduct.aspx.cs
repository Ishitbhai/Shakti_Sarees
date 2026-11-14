using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shakti_Sarees
{
    public partial class AdminAddProduct : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void cvMainImage_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = fuMainImage.HasFile;
        }

        protected void btnPublish_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                Response.Redirect("AdminProducts.aspx");
            }
        }
    }
}