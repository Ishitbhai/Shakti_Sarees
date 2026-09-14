using System;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class ProductDetail : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // In DB integration phase: load details matching Request.QueryString["id"]
                ViewState["Quantity"] = 1;
                txtQuantity.Text = "1";
            }
        }

        protected void btnQtyMinus_Click(object sender, EventArgs e)
        {
            int qty = ViewState["Quantity"] != null ? (int)ViewState["Quantity"] : 1;
            if (qty > 1)
            {
                qty--;
                ViewState["Quantity"] = qty;
                txtQuantity.Text = qty.ToString();
            }
        }

        protected void btnQtyPlus_Click(object sender, EventArgs e)
        {
            int qty = ViewState["Quantity"] != null ? (int)ViewState["Quantity"] : 1;
            if (qty < 10)
            {
                qty++;
                ViewState["Quantity"] = qty;
                txtQuantity.Text = qty.ToString();
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            // Wire to session cart or database in CIE-II Phase 2
        }

        protected void btnBuyNow_Click(object sender, EventArgs e)
        {
            // Direct checkout flow
            Response.Redirect("Cart.aspx");
        }
    }
}