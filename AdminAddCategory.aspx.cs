using System;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class AdminAddCategory : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSaveCategory_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // In database phase: INSERT into Categories table
                Response.Redirect("AdminCategories.aspx");
            }
        }
    }
}