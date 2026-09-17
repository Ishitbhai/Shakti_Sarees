using System;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class AdminEditOrder : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnEditOrder_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // In database phase: UPDATE order record
                Response.Redirect("AdminOrders.aspx");
            }
        }
    }
}