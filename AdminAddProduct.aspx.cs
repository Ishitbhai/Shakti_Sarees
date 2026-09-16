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

        // Standard syllabus validation: Verify FileUpload control has a file selected on postback
        protected void cvMainImage_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = fuMainImage.HasFile;
        }

        protected void btnPublish_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // In Phase 2: Save uploaded image or set default: "/images/home_main.png"
                Response.Redirect("AdminProducts.aspx");
            }
        }
    }
}