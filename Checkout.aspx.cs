using System;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class Checkout : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // In DB integration phase: load user profile details and cart totals into labels/boxes
            }
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            // Inserts records into Orders & OrderItems tables in Phase 2
            Response.Redirect("Orders.aspx");
        }
    }
}