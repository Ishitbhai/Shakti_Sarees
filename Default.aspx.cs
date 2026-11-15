using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shakti_Sarees
{
    // Explicitly inherit from System.Web.UI.Page
    public partial class Default : System.Web.UI.Page
    {
        // Your exact connection string
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadHomeCategories();
                LoadNewArrivals();
            }
        }

        // 1. Loads Active Categories with their dynamic CategoryImage
        private void LoadHomeCategories()
        {
            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                string query = "SELECT CategoryID, CategoryName, CategoryImage FROM Categories WHERE Status='Active' ORDER BY CategoryID ASC";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptCategories.DataSource = dt;
                rptCategories.DataBind();
            }
            finally
            {
                con.Close();
            }
        }

        // 2. Loads ONLY Products where NewArrival = 1 and Status = 'Active'
        private void LoadNewArrivals()
        {
            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                string query = @"SELECT p.ProductID, p.ProductName, p.ProductDescription, p.Price, p.MainImage, c.CategoryName 
                                 FROM Products p 
                                 INNER JOIN Categories c ON p.CategoryID = c.CategoryID 
                                 WHERE p.Status = 'Active' AND c.Status = 'Active' AND p.NewArrival = 1 
                                 ORDER BY p.ProductID DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptNewArrivals.DataSource = dt;
                rptNewArrivals.DataBind();
            }
            finally
            {
                con.Close();
            }
        }
    }
}