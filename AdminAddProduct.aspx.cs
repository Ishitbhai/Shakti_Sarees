using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shakti_Sarees
{
    public partial class AdminAddProduct : Page
    {
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategoriesDropdown();
            }
        }

        private void LoadCategoriesDropdown()
        {
            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                string query = "SELECT CategoryID, CategoryName FROM Categories WHERE Status='Active' ORDER BY CategoryName ASC";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlCategory.DataSource = dt;
                ddlCategory.DataBind();
            }
            finally
            {
                con.Close();
            }
        }

        protected void cvMainImage_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = fuMainImage.HasFile;
        }

        private string SaveUploadedImage(FileUpload uploader)
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
            return "";
        }

        protected void btnPublish_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                SqlConnection con = new SqlConnection(connectionstring);
                try
                {
                    con.Open();

                    int categoryId = Convert.ToInt32(ddlCategory.SelectedValue);
                    string productName = txtProductName.Text.Trim();
                    string description = txtDescription.Text.Trim();
                    decimal price = Convert.ToDecimal(txtPrice.Text.Trim());
                    int stock = Convert.ToInt32(txtStock.Text.Trim());

                    string mainImage = SaveUploadedImage(fuMainImage);
                    string extra1 = SaveUploadedImage(fuGallery1);
                    string extra2 = SaveUploadedImage(fuGallery2);
                    string extra3 = SaveUploadedImage(fuGallery3);
                    string extra4 = SaveUploadedImage(fuGallery4);

                    string status = rbDraft.Checked ? "Inactive" : "Active";
                    int newArrival = rbNewArrivalYes.Checked ? 1 : 0;

                    string query = @"INSERT INTO Products 
                                     (CategoryID, ProductName, ProductDescription, Price, StockQuantity, MainImage, ExtraImage1, ExtraImage2, ExtraImage3, ExtraImage4, Status, NewArrival) 
                                     VALUES 
                                     (@CategoryID, @ProductName, @ProductDescription, @Price, @StockQuantity, @MainImage, @Extra1, @Extra2, @Extra3, @Extra4, @Status, @NewArrival)";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@CategoryID", categoryId);
                    cmd.Parameters.AddWithValue("@ProductName", productName);
                    cmd.Parameters.AddWithValue("@ProductDescription", description);
                    cmd.Parameters.AddWithValue("@Price", price);
                    cmd.Parameters.AddWithValue("@StockQuantity", stock);
                    cmd.Parameters.AddWithValue("@MainImage", mainImage);
                    cmd.Parameters.AddWithValue("@Extra1", extra1);
                    cmd.Parameters.AddWithValue("@Extra2", extra2);
                    cmd.Parameters.AddWithValue("@Extra3", extra3);
                    cmd.Parameters.AddWithValue("@Extra4", extra4);
                    cmd.Parameters.AddWithValue("@Status", status);
                    cmd.Parameters.AddWithValue("@NewArrival", newArrival);

                    cmd.ExecuteNonQuery();

                    Response.Redirect("AdminProducts.aspx");
                }
                finally
                {
                    con.Close();
                }
            }
        }
    }
}