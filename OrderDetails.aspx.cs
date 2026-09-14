using System;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class OrderDetails : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // In DB integration phase: fetch order using Request.QueryString["id"]
            }
        }
    }
}