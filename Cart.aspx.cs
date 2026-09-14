using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shakti_Sarees
{
    public partial class Cart : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Future ADO.NET query to bind items from Cart table
            }
        }

        protected void btnMinus_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string itemId = btn.CommandArgument;
            // Handle decrement
        }

        protected void btnPlus_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string itemId = btn.CommandArgument;
            // Handle increment
        }

        protected void btnRemoveItem_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string itemId = btn.CommandArgument;
            // Remove item logic
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            Response.Redirect("Checkout.aspx");
        }
    }
}