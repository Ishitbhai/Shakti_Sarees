using System;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class AdminAddOrder : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnCreateOrder_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // In database phase: INSERT order record and line items
                Response.Redirect("AdminOrders.aspx");
            }
        }
    }
}