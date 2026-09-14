using System;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class Orders : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // In DB integration phase: bind customer's past orders via ADO.NET
            }
        }
    }
}