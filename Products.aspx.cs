using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shakti_Sarees
{
    public partial class Products : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Handle redirection from Category selection
                if (Request.QueryString["category"] != null)
                {
                    string cat = Request.QueryString["category"].Trim();
                    litPageTitle.Text = cat + " Collection";

                    // Select the matching checkbox in sidebar
                    foreach (ListItem item in cblCategories.Items)
                    {
                        item.Selected = item.Value.Equals(cat, StringComparison.OrdinalIgnoreCase);
                    }
                }
                // Handle redirection from Search Bar
                else if (Request.QueryString["search"] != null)
                {
                    string query = Request.QueryString["search"].Trim();
                    litPageTitle.Text = "Search Results for \"" + Server.HtmlEncode(query) + "\"";
                }
                else
                {
                    litPageTitle.Text = "Search Results";
                }
            }
        }

        protected void btnApplyFilters_Click(object sender, EventArgs e)
        {
            // Filter postback handling
        }

        protected void btnClearAll_Click(object sender, EventArgs e)
        {
            cblCategories.ClearSelection();
            txtMinPrice.Text = "0";
            txtMaxPrice.Text = "50000";
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string productId = btn.CommandArgument;
            // Cart management integration in CIE-II DB Phase
        }
    }
}