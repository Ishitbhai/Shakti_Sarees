using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shakti_Sarees
{
    // Syllabus Topic (Unit 3): Custom Exception for Out of Stock handling
    public class OutOfStockException : Exception
    {
        public OutOfStockException(string message) : base(message)
        {
        }
    }

    public partial class ProductDetail : Page
    {
        // Your exact connection string
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] == null || !int.TryParse(Request.QueryString["id"], out int productId))
                {
                    Response.Redirect("Products.aspx");
                    return;
                }

                ViewState["Quantity"] = 1;
                txtQuantity.Text = "1";

                TrackRecentlyViewed(productId);
                LoadProductDetails(productId);
                LoadRecommendations(productId);
            }
        }

        // Syllabus Topic (Unit 4): Using Stack<int> in Session to track recently viewed product IDs
        private void TrackRecentlyViewed(int productId)
        {
            Stack<int> viewedStack;
            if (Session["RecentlyViewed"] == null)
            {
                viewedStack = new Stack<int>();
            }
            else
            {
                viewedStack = (Stack<int>)Session["RecentlyViewed"];
            }

            if (!viewedStack.Contains(productId))
            {
                viewedStack.Push(productId);
            }
            Session["RecentlyViewed"] = viewedStack;
        }

        // Syllabus Topics: Unit 1 (Arrays), Unit 4 (ArrayList), Unit 7 (SqlDataReader)
        private void LoadProductDetails(int productId)
        {
            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                string query = "SELECT * FROM Products WHERE ProductID=@ProductID AND Status='Active'";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ProductID", productId);

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    litTitle.Text = dr["ProductName"].ToString();
                    litPrice.Text = "&#8377;" + dr["Price"].ToString();
                    litDescription.Text = dr["ProductDescription"].ToString();

                    ViewState["MaxStock"] = Convert.ToInt32(dr["StockQuantity"]);

                    string mainImg = dr["MainImage"].ToString();
                    imgMainPreview.ImageUrl = mainImg;

                    // Syllabus Topic (Unit 1 & Unit 4): Using a String Array and ArrayList for product gallery images
                    string[] rawImages = new string[]
                    {
                        dr["ExtraImage1"].ToString(),
                        dr["ExtraImage2"].ToString(),
                        dr["ExtraImage3"].ToString(),
                        dr["ExtraImage4"].ToString()
                    };

                    ArrayList validThumbnails = new ArrayList();
                    foreach (string imgPath in rawImages)
                    {
                        if (!string.IsNullOrWhiteSpace(imgPath))
                        {
                            validThumbnails.Add(imgPath);
                        }
                    }

                    rptThumbnails.DataSource = validThumbnails;
                    rptThumbnails.DataBind();
                }
                else
                {
                    dr.Close();
                    Response.Redirect("Products.aspx");
                    return;
                }
                dr.Close();
            }
            finally
            {
                con.Close();
            }
        }

        private void LoadRecommendations(int currentProductId)
        {
            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                con.Open();

                string query = @"SELECT TOP 4 p.ProductID, p.ProductName, p.ProductDescription, p.Price, p.MainImage, c.CategoryName 
                                 FROM Products p 
                                 INNER JOIN Categories c ON p.CategoryID = c.CategoryID 
                                 WHERE p.Status = 'Active' AND c.Status = 'Active' AND p.ProductID <> @CurrentID 
                                 ORDER BY p.ProductID DESC";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@CurrentID", currentProductId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptRecommendations.DataSource = dt;
                rptRecommendations.DataBind();
            }
            finally
            {
                con.Close();
            }
        }

        // Clicking a thumbnail switches the main preview image
        protected void btnThumb_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            imgMainPreview.ImageUrl = btn.CommandArgument;
        }

        // Syllabus Topic (Unit 1): Pass by Reference ('ref' parameter) to adjust quantity
        private void AdjustQuantity(ref int currentQty, int delta, int maxAllowed)
        {
            int updated = currentQty + delta;
            if (updated >= 1 && updated <= maxAllowed)
            {
                currentQty = updated;
            }
        }

        protected void btnQtyMinus_Click(object sender, EventArgs e)
        {
            int qty = ViewState["Quantity"] != null ? (int)ViewState["Quantity"] : 1;
            int maxStock = ViewState["MaxStock"] != null ? (int)ViewState["MaxStock"] : 10;

            AdjustQuantity(ref qty, -1, maxStock);

            ViewState["Quantity"] = qty;
            txtQuantity.Text = qty.ToString();
            lblStockMsg.Visible = false;
        }

        protected void btnQtyPlus_Click(object sender, EventArgs e)
        {
            int qty = ViewState["Quantity"] != null ? (int)ViewState["Quantity"] : 1;
            int maxStock = ViewState["MaxStock"] != null ? (int)ViewState["MaxStock"] : 10;

            AdjustQuantity(ref qty, 1, maxStock);

            ViewState["Quantity"] = qty;
            txtQuantity.Text = qty.ToString();
        }

        private bool SaveProductToCart(out string errorMessage)
        {
            errorMessage = "";

            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return false;
            }

            int productId = int.Parse(Request.QueryString["id"]);
            int userId = Convert.ToInt32(Session["UserID"]);
            int selectedQty = int.Parse(txtQuantity.Text);
            int availableStock = ViewState["MaxStock"] != null ? (int)ViewState["MaxStock"] : 0;

            SqlConnection con = new SqlConnection(connectionstring);
            try
            {
                if (selectedQty > availableStock || availableStock <= 0)
                {
                    throw new OutOfStockException("Requested quantity is currently out of stock!");
                }

                con.Open();

                string checkQuery = "SELECT CartID, Quantity FROM Cart WHERE UserID=@UserID AND ProductID=@ProductID";
                SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                checkCmd.Parameters.AddWithValue("@UserID", userId);
                checkCmd.Parameters.AddWithValue("@ProductID", productId);

                SqlDataReader dr = checkCmd.ExecuteReader();
                if (dr.Read())
                {
                    int cartId = Convert.ToInt32(dr["CartID"]);
                    int existingQty = Convert.ToInt32(dr["Quantity"]);
                    dr.Close();

                    int newTotalQty = existingQty + selectedQty;
                    if (newTotalQty > availableStock)
                    {
                        throw new OutOfStockException("Cannot add more than available stock (" + availableStock + ")!");
                    }

                    string updateQuery = "UPDATE Cart SET Quantity=@Quantity WHERE CartID=@CartID";
                    SqlCommand updateCmd = new SqlCommand(updateQuery, con);
                    updateCmd.Parameters.AddWithValue("@Quantity", newTotalQty);
                    updateCmd.Parameters.AddWithValue("@CartID", cartId);
                    updateCmd.ExecuteNonQuery();
                }
                else
                {
                    dr.Close();

                    string insertQuery = "INSERT INTO Cart values('" + userId + "','" + productId + "','" + selectedQty + "')";
                    SqlCommand insertCmd = new SqlCommand(insertQuery, con);
                    insertCmd.ExecuteNonQuery();
                }

                return true;
            }
            catch (OutOfStockException ex)
            {
                errorMessage = ex.Message;
                return false;
            }
            catch (Exception ex)
            {
                errorMessage = "Error: " + ex.Message;
                return false;
            }
            finally
            {
                con.Close();
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            if (SaveProductToCart(out string err))
            {
                Response.Redirect(Request.RawUrl);
            }
            else if (!string.IsNullOrEmpty(err))
            {
                lblStockMsg.Text = err;
                lblStockMsg.Visible = true;
            }
        }

        protected void btnBuyNow_Click(object sender, EventArgs e)
        {
            if (SaveProductToCart(out string err))
            {
                Response.Redirect("Cart.aspx");
            }
            else if (!string.IsNullOrEmpty(err))
            {
                lblStockMsg.Text = err;
                lblStockMsg.Visible = true;
            }
        }
    }
}