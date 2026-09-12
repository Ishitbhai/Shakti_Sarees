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
            // Reset to guest state by default
            phGuestActions.Visible = true;
            phCustomerActions.Visible = false;
            phAdminActions.Visible = false;

            if (Session["UserRole"] != null)
            {
                string role = Session["UserRole"].ToString().Trim().ToLower();

                if (role == "admin")
                {
                    phGuestActions.Visible = false;
            phCustomerActions.Visible = false;
            phAdminActions.Visible = true;
        }
            else if (role == "customer" || role == "user")
            {
                phGuestActions.Visible = false;
            phCustomerActions.Visible = true;
            phAdminActions.Visible = false;
        }
    }
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