using System;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class Site : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ApplyHeaderState();
            }
        }

        private void ApplyHeaderState()
        {

            phGuestActions.Visible = true;
            phCustomerActions.Visible = false;
            phAdminActions.Visible = false;
    
        }

        protected void btnSearchHidden_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtSearch.Text))
            {
                Response.Redirect("~/Products.aspx?search=" + Server.UrlEncode(txtSearch.Text.Trim()));
            }
        }
    }
}