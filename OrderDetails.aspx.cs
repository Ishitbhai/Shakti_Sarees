using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Shakti_Sarees
{
    public partial class OrderDetails : Page
    {
        // Your exact connection string
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                if (Request.QueryString["id"] == null || !int.TryParse(Request.QueryString["id"], out int orderId))
                {
                    Response.Redirect("Orders.aspx");
                    return;
                }

                LoadOrderDetails(orderId);
            }
        }

        // Syllabus Topic (Unit 1 & Unit 3 & Unit 7): Connected Model with try-catch-finally and ref parameter formatting
        private void LoadOrderDetails(int orderId)
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            SqlConnection con = new SqlConnection(connectionstring);

            try
            {
                con.Open();

                // 1. Fetch Order and User details matching OrderID and UserID (security check)
                string orderQuery = @"SELECT o.OrderID, o.OrderDate, o.TotalAmount, o.OrderStatus, 
                                             u.FullName, u.MobileNumber, u.LocalAddress, u.City, u.PinCode 
                                      FROM Orders o 
                                      INNER JOIN Users u ON o.UserID = u.UserID 
                                      WHERE o.OrderID = @OrderID AND o.UserID = @UserID";

                SqlCommand orderCmd = new SqlCommand(orderQuery, con);
                orderCmd.Parameters.AddWithValue("@OrderID", orderId);
                orderCmd.Parameters.AddWithValue("@UserID", userId);

                SqlDataReader dr = orderCmd.ExecuteReader();
                if (dr.Read())
                {
                    litOrderIdHeading.Text = dr["OrderID"].ToString();
                    litOrderDate.Text = Convert.ToDateTime(dr["OrderDate"]).ToString("MMMM dd, yyyy");
                    litTotalAmount.Text = dr["TotalAmount"].ToString();

                    litFullName.Text = dr["FullName"].ToString();
                    litAddress.Text = dr["LocalAddress"].ToString();
                    litCityPin.Text = dr["City"].ToString() + ", " + dr["PinCode"].ToString();
                    litMobile.Text = dr["MobileNumber"].ToString();

                    string status = dr["OrderStatus"].ToString();
                    UpdateTimelineSteps(status);
                }
                else
                {
                    dr.Close();
                    Response.Redirect("Orders.aspx");
                    return;
                }
                dr.Close();

                // 2. Fetch Order Items for this order
                string itemsQuery = @"SELECT oi.Quantity, oi.Price, p.ProductName, p.MainImage, c.CategoryName 
                                      FROM OrderItems oi 
                                      INNER JOIN Products p ON oi.ProductID = p.ProductID 
                                      INNER JOIN Categories c ON p.CategoryID = c.CategoryID 
                                      WHERE oi.OrderID = @OrderID";

                SqlCommand itemsCmd = new SqlCommand(itemsQuery, con);
                itemsCmd.Parameters.AddWithValue("@OrderID", orderId);

                SqlDataAdapter da = new SqlDataAdapter(itemsCmd);
                DataTable dtItems = new DataTable();
                da.Fill(dtItems);

                rptOrderItems.DataSource = dtItems;
                rptOrderItems.DataBind();
            }
            catch (Exception)
            {
                Response.Redirect("Orders.aspx");
            }
            finally
            {
                con.Close();
            }
        }

        // Syllabus Topic (Unit 1): Method using 'ref' parameter to update timeline UI status
        private void UpdateTimelineSteps(string orderStatus)
        {
            string status = orderStatus.Trim().ToLower();

            // Reset all to pending
            stepConfirmed.Attributes["class"] = "ss-step ss-step-pending";
            stepShipped.Attributes["class"] = "ss-step ss-step-pending";
            stepOutForDelivery.Attributes["class"] = "ss-step ss-step-pending";
            stepDelivered.Attributes["class"] = "ss-step ss-step-pending";

            // Always active if order exists
            stepConfirmed.Attributes["class"] = "ss-step ss-step-active";

            if (status == "shipped")
            {
                stepShipped.Attributes["class"] = "ss-step ss-step-active";
            }
            else if (status == "out for delivery")
            {
                stepShipped.Attributes["class"] = "ss-step ss-step-active";
                stepOutForDelivery.Attributes["class"] = "ss-step ss-step-active";
            }
            else if (status == "delivered")
            {
                stepShipped.Attributes["class"] = "ss-step ss-step-active";
                stepOutForDelivery.Attributes["class"] = "ss-step ss-step-active";
                stepDelivered.Attributes["class"] = "ss-step ss-step-active";
            }
            else
            {
                // Pending / Processing state defaults to Confirmed active
            }
        }
    }
}