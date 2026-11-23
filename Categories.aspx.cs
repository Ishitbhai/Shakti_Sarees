using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;

namespace Shakti_Sarees
{
    // Syllabus Topic (Unit 2): OOP Class, Encapsulation (Get/Set Properties), Constructor
    public class CategoryShowcaseItem
    {
        public int CategoryID { get; set; }
        public string CategoryName { get; set; }
        public string CategoryImage { get; set; }

        public CategoryShowcaseItem(int id, string catName, string catImg)
        {
            this.CategoryID = id;
            this.CategoryName = catName;
            this.CategoryImage = catImg;
        }
    }

    public partial class Categories : Page
    {
        // Your exact connection string
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCollectionCategories();
            }
        }

        // Syllabus Topics: Unit 4 (List<T>), Unit 5 (LINQ), Unit 7 (Connected ADO.NET SqlDataAdapter & DataTable)
        private void LoadCollectionCategories()
        {
            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                // Select Category details directly including CategoryImage
                string catQuery = "SELECT CategoryID, CategoryName, CategoryImage FROM Categories WHERE Status='Active' ORDER BY CategoryID ASC";
                SqlDataAdapter da = new SqlDataAdapter(catQuery, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Syllabus Topic (Unit 4): Generic Collection List<T>
                List<CategoryShowcaseItem> showcaseList = new List<CategoryShowcaseItem>();

                foreach (DataRow row in dt.Rows)
                {
                    int catId = Convert.ToInt32(row["CategoryID"]);
                    string catName = row["CategoryName"].ToString();
                    string catImg = row["CategoryImage"] != DBNull.Value && !string.IsNullOrEmpty(row["CategoryImage"].ToString())
                        ? row["CategoryImage"].ToString()
                        : "/images/home_main.png";

                    showcaseList.Add(new CategoryShowcaseItem(catId, catName, catImg));
                }

                // Syllabus Topic (Unit 5): LINQ Query Syntax to sort categories
                var sortedCategories = from item in showcaseList
                                       orderby item.CategoryID ascending
                                       select item;

                rptCategories.DataSource = sortedCategories.ToList();
                rptCategories.DataBind();
            }
            finally
            {
                con.Close();
            }
        }
    }
}