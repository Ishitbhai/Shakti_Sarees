using System;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shakti_Sarees
{
    public partial class AdminAbout : Page
    {
        // Your exact connection string
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAboutSettings();
            }
        }

        // Syllabus Topic (Unit 7): Connected ADO.NET (SqlDataReader) to load PageAbout configuration
        private void LoadAboutSettings()
        {
            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                string query = "SELECT TOP 1 * FROM PageAbout ORDER BY AboutID DESC";
                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    txtPageTitle.Text = dr["PageTitle"].ToString();
                    txtMainStory.Text = dr["MainStory"].ToString();

                    txtFeature1Heading.Text = dr["Feature1Heading"].ToString();
                    txtFeature1Desc.Text = dr["Feature1Desc"].ToString();
                    hfFeatureIcon1.Value = dr["Feature1Icon"].ToString();

                    txtFeature2Heading.Text = dr["Feature2Heading"].ToString();
                    txtFeature2Desc.Text = dr["Feature2Desc"].ToString();
                    hfFeatureIcon2.Value = dr["Feature2Icon"].ToString();

                    string heroImg = dr["HeroImage"].ToString();
                    hfAboutImage.Value = heroImg;

                    if (!string.IsNullOrWhiteSpace(heroImg))
                    {
                        imgHeroPreview.ImageUrl = heroImg;
                        imgHeroPreview.Visible = true;
                        icoPlaceholder.Visible = false;
                    }
                }
                dr.Close();
            }
            finally
            {
                con.Close();
            }
        }

        protected void cvAboutImage_ServerValidate(object source, ServerValidateEventArgs args)
        {
            bool hasExistingPath = !string.IsNullOrEmpty(hfAboutImage.Value);
            bool hasUploadedNewFile = fuAboutImage.HasFile;

            args.IsValid = hasExistingPath || hasUploadedNewFile;
        }

        private string ResolveUploadedFile(FileUpload uploader, string existingValue, string defaultFallback)
        {
            if (uploader != null && uploader.HasFile)
            {
                string folderPath = Server.MapPath("~/images/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string fileName = Path.GetFileName(uploader.FileName);
                string fullPath = Path.Combine(folderPath, fileName);
                uploader.SaveAs(fullPath);

                return "/images/" + fileName;
            }

            if (!string.IsNullOrWhiteSpace(existingValue))
            {
                return existingValue;
            }

            return defaultFallback;
        }

        // Syllabus Topic (Unit 7): Connected ADO.NET Upsert (UPDATE if exists, INSERT if empty)
        protected void btnPublishUpdates_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string pageTitle = txtPageTitle.Text.Trim();
                string mainStory = txtMainStory.Text.Trim();

                string f1Heading = txtFeature1Heading.Text.Trim();
                string f1Desc = txtFeature1Desc.Text.Trim();
                string f1Icon = ResolveUploadedFile(fuFeatureIcon1, hfFeatureIcon1.Value, "fa-regular fa-gem");

                string f2Heading = txtFeature2Heading.Text.Trim();
                string f2Desc = txtFeature2Desc.Text.Trim();
                string f2Icon = ResolveUploadedFile(fuFeatureIcon2, hfFeatureIcon2.Value, "fa-solid fa-truck");

                string heroImage = ResolveUploadedFile(fuAboutImage, hfAboutImage.Value, "");

                SqlConnection con = new SqlConnection(connectionstring);
                try
                {
                    con.Open();

                    SqlCommand checkCmd = new SqlCommand("SELECT COUNT(*) FROM PageAbout", con);
                    int count = (int)checkCmd.ExecuteScalar();

                    string query;
                    if (count > 0)
                    {
                        query = @"UPDATE PageAbout 
                                  SET PageTitle=@PageTitle, MainStory=@MainStory, 
                                      Feature1Heading=@F1Heading, Feature1Desc=@F1Desc, Feature1Icon=@F1Icon, 
                                      Feature2Heading=@F2Heading, Feature2Desc=@F2Desc, Feature2Icon=@F2Icon, 
                                      HeroImage=@HeroImage";
                    }
                    else
                    {
                        query = @"INSERT INTO PageAbout 
                                  (PageTitle, MainStory, Feature1Heading, Feature1Desc, Feature1Icon, Feature2Heading, Feature2Desc, Feature2Icon, HeroImage) 
                                  VALUES 
                                  (@PageTitle, @MainStory, @F1Heading, @F1Desc, @F1Icon, @F2Heading, @F2Desc, @F2Icon, @HeroImage)";
                    }

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@PageTitle", pageTitle);
                    cmd.Parameters.AddWithValue("@MainStory", mainStory);
                    cmd.Parameters.AddWithValue("@F1Heading", f1Heading);
                    cmd.Parameters.AddWithValue("@F1Desc", f1Desc);
                    cmd.Parameters.AddWithValue("@F1Icon", f1Icon);
                    cmd.Parameters.AddWithValue("@F2Heading", f2Heading);
                    cmd.Parameters.AddWithValue("@F2Desc", f2Desc);
                    cmd.Parameters.AddWithValue("@F2Icon", f2Icon);
                    cmd.Parameters.AddWithValue("@HeroImage", heroImage);

                    cmd.ExecuteNonQuery();

                    Response.Redirect("AdminAbout.aspx");
                }
                finally
                {
                    con.Close();
                }
            }
        }
    }
}