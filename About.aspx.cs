using System;
using System.Collections;
using System.Data.SqlClient;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class About : Page
    {
        // Your exact connection string
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAboutPageContent();
            }
        }

        // Syllabus Topics: Unit 4 (Hashtable Collection), Unit 1 (String Operations & Arrays), Unit 7 (SqlDataReader)
        private void LoadAboutPageContent()
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
                    // Syllabus Topic (Unit 4): Non-Generic Collection (Hashtable)
                    Hashtable aboutData = new Hashtable();
                    aboutData.Add("PageTitle", dr["PageTitle"].ToString());
                    aboutData.Add("MainStory", dr["MainStory"].ToString());
                    aboutData.Add("Feature1Heading", dr["Feature1Heading"].ToString());
                    aboutData.Add("Feature1Desc", dr["Feature1Desc"].ToString());
                    aboutData.Add("Feature1Icon", dr["Feature1Icon"].ToString());
                    aboutData.Add("Feature2Heading", dr["Feature2Heading"].ToString());
                    aboutData.Add("Feature2Desc", dr["Feature2Desc"].ToString());
                    aboutData.Add("Feature2Icon", dr["Feature2Icon"].ToString());
                    aboutData.Add("HeroImage", dr["HeroImage"].ToString());

                    pnlAboutWrapper.Visible = true;

                    litPageTitle.Text = aboutData["PageTitle"].ToString();
                    imgHero.ImageUrl = aboutData["HeroImage"].ToString();

                    // Format MainStory with drop-cap on the first paragraph using String Operations (Unit 1)
                    string rawStory = aboutData["MainStory"].ToString().Trim();
                    if (!string.IsNullOrEmpty(rawStory))
                    {
                        string[] paragraphs = rawStory.Split(new string[] { "\r\n", "\n" }, StringSplitOptions.RemoveEmptyEntries);
                        string formattedHtml = "";

                        for (int i = 0; i < paragraphs.Length; i++)
                        {
                            string para = paragraphs[i].Trim();
                            if (i == 0 && para.Length > 1)
                            {
                                string firstLetter = para.Substring(0, 1);
                                string restOfPara = para.Substring(1);
                                formattedHtml += "<p class=\"ss-story-lead\"><span class=\"ss-drop-cap\">" + firstLetter + "</span>" + restOfPara + "</p>";
                            }
                            else
                            {
                                formattedHtml += "<p>" + para + "</p>";
                            }
                        }
                        litMainStory.Text = formattedHtml;
                    }

                    // Bind Feature 1 & Feature 2
                    litFeature1Heading.Text = aboutData["Feature1Heading"].ToString();
                    litFeature1Desc.Text = aboutData["Feature1Desc"].ToString();
                    litFeature1Icon.Text = RenderFeatureIcon(aboutData["Feature1Icon"].ToString(), "fa-regular fa-gem");

                    litFeature2Heading.Text = aboutData["Feature2Heading"].ToString();
                    litFeature2Desc.Text = aboutData["Feature2Desc"].ToString();
                    litFeature2Icon.Text = RenderFeatureIcon(aboutData["Feature2Icon"].ToString(), "fa-solid fa-truck");
                }
                else
                {
                    pnlAboutWrapper.Visible = false;
                }

                dr.Close();
            }
            finally
            {
                con.Close();
            }
        }

        // Supports either a FontAwesome class name or an uploaded icon image path from AdminAbout.aspx
        private string RenderFeatureIcon(string iconValue, string defaultFaClass)
        {
            if (string.IsNullOrWhiteSpace(iconValue))
            {
                return "<i class=\"" + defaultFaClass + "\"></i>";
            }

            if (iconValue.Contains("/") || iconValue.Contains("."))
            {
                return "<img src=\"" + iconValue + "\" alt=\"Feature Icon\" style=\"width:24px; height:24px; object-fit:contain;\" />";
            }

            return "<i class=\"" + iconValue + "\"></i>";
        }
    }
}