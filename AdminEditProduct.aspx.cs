using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shakti_Sarees
{
    public partial class AdminEditProduct : Page
    {
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] == null || !int.TryParse(Request.QueryString["id"], out int productId))
                {
                    Response.Redirect("AdminProducts.aspx");
                    return;
                }

                LoadCategoriesDropdown();
                LoadProductForEdit(productId);
            }
        }

        private void LoadCategoriesDropdown()
        {
            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                string query = "SELECT CategoryID, CategoryName FROM Categories ORDER BY CategoryName ASC";
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

        private void LoadProductForEdit(int productId)
        {
            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                string query = "SELECT * FROM Products WHERE ProductID=@ProductID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ProductID", productId);

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtProductName.Text = dr["ProductName"].ToString();
                    txtDescription.Text = dr["ProductDescription"].ToString();
                    txtPrice.Text = dr["Price"].ToString();
                    txtStock.Text = dr["StockQuantity"].ToString();

                    string catId = dr["CategoryID"].ToString();
                    if (ddlCategory.Items.FindByValue(catId) != null)
                    {
                        ddlCategory.SelectedValue = catId;
                    }

                    string status = dr["Status"].ToString();
                    if (status == "Inactive")
                    {
                        rbDraft.Checked = true;
                        rbPublished.Checked = false;
                    }
                    else
                    {
                        rbPublished.Checked = true;
                        rbDraft.Checked = false;
                    }

                    // Bind NewArrival (0 or 1)
                    int newArrivalVal = dr["NewArrival"] != DBNull.Value ? Convert.ToInt32(dr["NewArrival"]) : 0;
                    if (newArrivalVal == 1)
                    {
                        rbNewArrivalYes.Checked = true;
                        rbNewArrivalNo.Checked = false;
                    }
                    else
                    {
                        rbNewArrivalNo.Checked = true;
                        rbNewArrivalYes.Checked = false;
                    }

                    // Bind Main & Extra Images
                    BindImageSlot(dr["MainImage"].ToString(), hfMainImage, imgMainPreview, pnlMainPreview, pnlMainUpload);
                    BindImageSlot(dr["ExtraImage1"].ToString(), hfExtra1, imgPreview1, pnlPreview1, pnlUpload1);
                    BindImageSlot(dr["ExtraImage2"].ToString(), hfExtra2, imgPreview2, pnlPreview2, pnlUpload2);
                    BindImageSlot(dr["ExtraImage3"].ToString(), hfExtra3, imgPreview3, pnlPreview3, pnlUpload3);
                    BindImageSlot(dr["ExtraImage4"].ToString(), hfExtra4, imgPreview4, pnlPreview4, pnlUpload4);
                }
                else
                {
                    dr.Close();
                    Response.Redirect("AdminProducts.aspx");
                    return;
                }
                dr.Close();
            }
            finally
            {
                con.Close();
            }
        }

        private void BindImageSlot(string imagePath, HiddenField hf, Image imgControl, Panel pnlPreview, Panel pnlUpload)
        {
            hf.Value = imagePath;
            if (!string.IsNullOrWhiteSpace(imagePath))
            {
                imgControl.ImageUrl = imagePath;
                pnlPreview.Visible = true;
                pnlUpload.Visible = false;
            }
            else
            {
                pnlPreview.Visible = false;
                pnlUpload.Visible = true;
            }
        }

        protected void btnRemoveImage_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string slot = btn.CommandArgument;

            if (slot == "Main")
            {
                BindImageSlot("", hfMainImage, imgMainPreview, pnlMainPreview, pnlMainUpload);
            }
            else if (slot == "Extra1")
            {
                BindImageSlot("", hfExtra1, imgPreview1, pnlPreview1, pnlUpload1);
            }
            else if (slot == "Extra2")
            {
                BindImageSlot("", hfExtra2, imgPreview2, pnlPreview2, pnlUpload2);
            }
            else if (slot == "Extra3")
            {
                BindImageSlot("", hfExtra3, imgPreview3, pnlPreview3, pnlUpload3);
            }
            else if (slot == "Extra4")
            {
                BindImageSlot("", hfExtra4, imgPreview4, pnlPreview4, pnlUpload4);
            }
        }

        protected void cvMainImage_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = !string.IsNullOrEmpty(hfMainImage.Value) || fuMainImage.HasFile;
        }

        private string ResolveSlotImage(HiddenField hfExisting, FileUpload uploader)
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

            return hfExisting.Value;
        }

        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                int productId = int.Parse(Request.QueryString["id"]);

                SqlConnection con = new SqlConnection(connectionstring);
                try
                {
                    con.Open();

                    int categoryId = Convert.ToInt32(ddlCategory.SelectedValue);
                    string productName = txtProductName.Text.Trim();
                    string description = txtDescription.Text.Trim();
                    decimal price = Convert.ToDecimal(txtPrice.Text.Trim());
                    int stock = Convert.ToInt32(txtStock.Text.Trim());
                    string status = rbDraft.Checked ? "Inactive" : "Active";
                    int newArrival = rbNewArrivalYes.Checked ? 1 : 0;

                    string mainImage = ResolveSlotImage(hfMainImage, fuMainImage);
                    string extra1 = ResolveSlotImage(hfExtra1, fuGallery1);
                    string extra2 = ResolveSlotImage(hfExtra2, fuGallery2);
                    string extra3 = ResolveSlotImage(hfExtra3, fuGallery3);
                    string extra4 = ResolveSlotImage(hfExtra4, fuGallery4);

                    string updateQuery = @"UPDATE Products 
                                           SET CategoryID=@CategoryID, ProductName=@ProductName, ProductDescription=@ProductDescription, 
                                               Price=@Price, StockQuantity=@StockQuantity, MainImage=@MainImage, 
                                               ExtraImage1=@Extra1, ExtraImage2=@Extra2, ExtraImage3=@Extra3, ExtraImage4=@Extra4, 
                                               Status=@Status, NewArrival=@NewArrival 
                                           WHERE ProductID=@ProductID";

                    SqlCommand cmd = new SqlCommand(updateQuery, con);
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
                    cmd.Parameters.AddWithValue("@ProductID", productId);

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