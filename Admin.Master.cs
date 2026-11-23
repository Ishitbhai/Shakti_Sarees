using System;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class Admin : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Syllabus Topic (Unit 10): Strict Admin Role & Session Security Enforcement
            if (Session["UserID"] == null || Session["Role"] == null || Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void btnLogoutAdmin_Click(object sender, EventArgs e)
        {
            // Syllabus Topic (Unit 10): Clear and Abandon Session on Admin Logout
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}