using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class Contact : Page
    {
        // Your exact connection string
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadContactPageContent();
            }
        }

        // Syllabus Topics: Unit 4 (Dictionary<TKey, TValue>), Unit 1 (String Operations & Arrays), Unit 7 (SqlDataReader)
        private void LoadContactPageContent()
        {
            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                string query = "SELECT TOP 1 * FROM PageContact ORDER BY ContactID DESC";
                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    // Syllabus Topic (Unit 4): Generic Collection Dictionary<string, string>
                    Dictionary<string, string> contactDict = new Dictionary<string, string>();
                    contactDict.Add("PageTitle", dr["PageTitle"].ToString());
                    contactDict.Add("MainStory", dr["MainStory"].ToString());
                    contactDict.Add("Address", dr["Address"].ToString());
                    contactDict.Add("Phone", dr["Phone"].ToString());
                    contactDict.Add("Email", dr["Email"].ToString());
                    contactDict.Add("BusinessHours", dr["BusinessHours"].ToString());

                    pnlContactWrapper.Visible = true;

                    litPageTitle.Text = contactDict["PageTitle"];
                    litMainStory.Text = contactDict["MainStory"];

                    // Format Address lines into <p> tags
                    string rawAddress = contactDict["Address"].Trim();
                    string[] addressLines = rawAddress.Split(new string[] { "\r\n", "\n", "," }, StringSplitOptions.RemoveEmptyEntries);
                    string addressHtml = "";
                    foreach (string line in addressLines)
                    {
                        addressHtml += "<p>" + line.Trim() + "</p>";
                    }
                    litAddress.Text = addressHtml;

                    // Bind Phone & Email HyperLinks
                    string phone = contactDict["Phone"].Trim();
                    hlPhone.Text = phone;
                    hlPhone.NavigateUrl = "tel:" + phone;

                    string email = contactDict["Email"].Trim();
                    hlEmail.Text = email;
                    hlEmail.NavigateUrl = "mailto:" + email;

                    // Format Business Hours
                    string rawHours = contactDict["BusinessHours"].Trim();
                    string[] hourLines = rawHours.Split(new string[] { "\r\n", "\n", "|" }, StringSplitOptions.RemoveEmptyEntries);
                    string hoursHtml = "";
                    for (int i = 0; i < hourLines.Length; i++)
                    {
                        if (i == 0)
                        {
                            hoursHtml += "<span class=\"ss-channel-val\">" + hourLines[i].Trim() + "</span>";
                        }
                        else
                        {
                            hoursHtml += "<span class=\"ss-channel-sub\">" + hourLines[i].Trim() + "</span>";
                        }
                    }
                    litBusinessHours.Text = hoursHtml;
                }
                else
                {
                    pnlContactWrapper.Visible = false;
                }

                dr.Close();
            }
            finally
            {
                con.Close();
            }
        }
    }
}