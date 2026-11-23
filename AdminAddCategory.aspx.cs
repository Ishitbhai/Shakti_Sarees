using System;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shakti_Sarees
{
    public class DuplicateCategoryException : Exception
    {
        public DuplicateCategoryException(string message) : base(message)
        {
        }
    }

    public partial class AdminAddCategory : Page
    {
        // Your exact connection string
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        // Server-side validation for category image upload
        protected void cvCategoryImage_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = fuCategoryImage.HasFile;
        }

        private string SaveCategoryImage(FileUpload uploader)
        {
            if (uploader != null && uploader.HasFile)
            {
                string folderPath = Server.MapPath("~/images/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string fileName = Path.GetFileName(uploader.FileName);
                string fullSavePath = Path.Combine(folderPath, fileName);
                uploader.SaveAs(fullSavePath);

                return "/images/" + fileName;
            }
            return "/images/home_main.png";
        }

        protected void btnSaveCategory_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string categoryName = txtCategoryName.Text.Trim();
                string status = rbInactive.Checked ? "Inactive" : "Active";
                string categoryImage = SaveCategoryImage(fuCategoryImage);

                SqlConnection con = new SqlConnection(connectionstring);
                try
                {
                    con.Open();

                    string checkQuery = "SELECT COUNT(*) FROM Categories WHERE LOWER(CategoryName) = LOWER(@CategoryName)";
                    SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                    checkCmd.Parameters.AddWithValue("@CategoryName", categoryName);

                    int existingCount = (int)checkCmd.ExecuteScalar();
                    if (existingCount > 0)
                    {
                        throw new DuplicateCategoryException("A category with this name already exists!");
                    }

                    string insertQuery = "INSERT INTO Categories (CategoryName, CategoryImage, Status) VALUES (@CategoryName, @CategoryImage, @Status)";
                    SqlCommand cmd = new SqlCommand(insertQuery, con);
                    cmd.Parameters.AddWithValue("@CategoryName", categoryName);
                    cmd.Parameters.AddWithValue("@CategoryImage", categoryImage);
                    cmd.Parameters.AddWithValue("@Status", status);
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