using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shakti_Sarees
{
    public partial class AdminAbout : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void cvAboutImage_ServerValidate(object source, ServerValidateEventArgs args)
        {
            bool hasExistingPath = !string.IsNullOrEmpty(hfAboutImage.Value);
            bool hasUploadedNewFile = fuAboutImage.HasFile;

            args.IsValid = hasExistingPath || hasUploadedNewFile;
        }

        protected void btnPublishUpdates_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                Response.Redirect("AdminAbout.aspx");
            }
        }
    }
}