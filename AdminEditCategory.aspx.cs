using System;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class AdminEditCategory : Page
    {
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] == null || !int.TryParse(Request.QueryString["id"], out int categoryId))
                {
                    Response.Redirect("AdminCategories.aspx");
                    return;
                }

                LoadCategoryDetails(categoryId);
            }
        }

        private void LoadCategoryDetails(int categoryId)
        {
            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                string query = "SELECT CategoryName, CategoryImage, Status FROM Categories WHERE CategoryID=@CategoryID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@CategoryID", categoryId);

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtCategoryName.Text = dr["CategoryName"].ToString();
                    string catImg = dr["CategoryImage"] != DBNull.Value && !string.IsNullOrEmpty(dr["CategoryImage"].ToString())
                        ? dr["CategoryImage"].ToString()
                        : "/images/home_main.png";

                    hfCategoryImage.Value = catImg;
                    imgCategoryPreview.ImageUrl = catImg;

                    string status = dr["Status"].ToString();
                    if (status == "Inactive")
                    {
                        rbInactiveEdit.Checked = true;
                        rbActiveEdit.Checked = false;
                    }
                    else
                    {
                        rbActiveEdit.Checked = true;
                        rbInactiveEdit.Checked = false;
                    }
                }
                else
                {
                    dr.Close();
                    Response.Redirect("AdminCategories.aspx");
                    return;
                }
                dr.Close();
            }
            finally
            {
                con.Close();
            }
        }

        protected void btnSaveCategory_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                int categoryId = int.Parse(Request.QueryString["id"]);
                string categoryName = txtCategoryName.Text.Trim();
                string status = rbInactiveEdit.Checked ? "Inactive" : "Active";
                string categoryImage = hfCategoryImage.Value;

                if (fuCategoryImage.HasFile)
                {
                    string folderPath = Server.MapPath("~/images/");
                    if (!Directory.Exists(folderPath))
                    {
                        Directory.CreateDirectory(folderPath);
                    }

                    string fileName = Path.GetFileName(fuCategoryImage.FileName);
                    string fullSavePath = Path.Combine(folderPath, fileName);
                    fuCategoryImage.SaveAs(fullSavePath);
                    categoryImage = "/images/" + fileName;
                }

                SqlConnection con = new SqlConnection(connectionstring);
                try
                {
                    con.Open();

                    string checkQuery = "SELECT COUNT(*) FROM Categories WHERE LOWER(CategoryName) = LOWER(@CategoryName) AND CategoryID <> @CategoryID";
                    SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                    checkCmd.Parameters.AddWithValue("@CategoryName", categoryName);
                    checkCmd.Parameters.AddWithValue("@CategoryID", categoryId);

                    int existingCount = (int)checkCmd.ExecuteScalar();
                    if (existingCount > 0)
                    {
                        throw new DuplicateCategoryException("Another category with this name already exists!");
                    }

                    string updateQuery = "UPDATE Categories SET CategoryName=@CategoryName, CategoryImage=@CategoryImage, Status=@Status WHERE CategoryID=@CategoryID";
                    SqlCommand cmd = new SqlCommand(updateQuery, con);
                    cmd.Parameters.AddWithValue("@CategoryName", categoryName);
                    cmd.Parameters.AddWithValue("@CategoryImage", categoryImage);
                    cmd.Parameters.AddWithValue("@Status", status);
                    cmd.Parameters.AddWithValue("@CategoryID", categoryId);
                    cmd.ExecuteNonQuery();

                    Response.Redirect("AdminCategories.aspx");
                }
                catch (DuplicateCategoryException ex)
                {
                    lblMsg.Text = ex.Message;
                    lblMsg.Visible = true;
                }
                catch (Exception ex)
                {
                    lblMsg.Text = "Error: " + ex.Message;
                    lblMsg.Visible = true;
                }
                finally
                {
                    con.Close();
                }
            }
        }
    }
}