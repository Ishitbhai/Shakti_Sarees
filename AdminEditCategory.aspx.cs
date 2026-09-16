using System;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class AdminEditCategory : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSaveCategory_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // In Phase 2: Update category record in database
                Response.Redirect("AdminCategories.aspx");
            }
        }
    }
}