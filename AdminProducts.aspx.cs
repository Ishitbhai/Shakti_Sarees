using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shakti_Sarees
{
    public partial class AdminProducts : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string productId = btn.CommandArgument;
        }
    }
}