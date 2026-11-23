using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;

namespace Shakti_Sarees
{
    // Syllabus Topic (Unit 2): Abstract Class, Encapsulation, 'abstract' and 'this' keywords
    public abstract class OrderSummaryBase
    {
        public int OrderID { get; set; }
        public DateTime OrderDate { get; set; }
        public decimal TotalAmount { get; set; }
        public string RawStatus { get; set; }

        public OrderSummaryBase(int orderId, DateTime orderDate, decimal totalAmount, string status)
        {
            this.OrderID = orderId;
            this.OrderDate = orderDate;
            this.TotalAmount = totalAmount;
            this.RawStatus = status;
        }

        public abstract string GetBadgeCssClass();
    }

    // Syllabus Topic (Unit 2): Inheritance, 'sealed' class, 'base' constructor call, and Method Overriding ('override')
    public sealed class CustomerOrderViewModel : OrderSummaryBase
    {
        public string ThumbnailImage { get; set; }
        public int TotalItems { get; set; }
        public string ItemNamesSummary { get; set; }

        public string FormattedDate
        {
            get { return this.OrderDate.ToString("MMMM dd, yyyy"); }
        }

        public string StatusText
        {
            get { return this.RawStatus.ToUpper(); }
        }

        public string BadgeCssClass
        {
            get { return this.GetBadgeCssClass(); }
        }

        public CustomerOrderViewModel(int orderId, DateTime orderDate, decimal totalAmount, string status, string thumb, int totalItems, string itemNames)
            : base(orderId, orderDate, totalAmount, status)
        {
            this.ThumbnailImage = thumb;
            this.TotalItems = totalItems;
            this.ItemNamesSummary = itemNames;
        }

        public override string GetBadgeCssClass()
        {
            string statusLower = this.RawStatus.ToLower();
            if (statusLower == "shipped")
            {
                return "ss-status-badge ss-badge-shipped";
            }
            else if (statusLower == "delivered")
            {
                return "ss-status-badge ss-badge-delivered";
            }
            else
            {
                return "ss-status-badge ss-badge-processing";
            }
        }
    }

    public partial class Orders : Page
    {
        // Your exact connection string
        string connectionstring = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\RKU\\ASP\\Shakti_Sarees\\App_Data\\Shakti_Sarees.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Require login to view Order History
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadCustomerOrders();
            }
        }

        // Syllabus Topics: Unit 4 (List<T>), Unit 5 (LINQ), Unit 7 (DataSet, DataTable, DataRelation)
        private void LoadCustomerOrders()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            SqlConnection con = new SqlConnection(connectionstring);

            try
            {
                con.Open();

                DataSet ds = new DataSet();

                // 1. Fetch Orders for the logged-in customer
                string ordersQuery = "SELECT OrderID, UserID, OrderDate, TotalAmount, OrderStatus FROM Orders WHERE UserID=@UserID";
                SqlCommand cmdOrders = new SqlCommand(ordersQuery, con);
                cmdOrders.Parameters.AddWithValue("@UserID", userId);

                SqlDataAdapter daOrders = new SqlDataAdapter(cmdOrders);
                daOrders.Fill(ds, "Orders");

                if (ds.Tables["Orders"].Rows.Count == 0)
                {
                    rptOrders.DataSource = null;
                    rptOrders.DataBind();
                    return;
                }

                // 2. Fetch OrderItems joined with Products for this customer's orders
                string itemsQuery = @"SELECT oi.OrderItemID, oi.OrderID, oi.ProductID, oi.Quantity, oi.Price, 
                                             p.ProductName, p.MainImage 
                                      FROM OrderItems oi 
                                      INNER JOIN Products p ON oi.ProductID = p.ProductID 
                                      INNER JOIN Orders o ON oi.OrderID = o.OrderID 
                                      WHERE o.UserID = @UserID";
                SqlCommand cmdItems = new SqlCommand(itemsQuery, con);
                cmdItems.Parameters.AddWithValue("@UserID", userId);

                SqlDataAdapter daItems = new SqlDataAdapter(cmdItems);
                daItems.Fill(ds, "OrderItems");

                // 3. Create DataRelation linking Orders -> OrderItems
                DataRelation orderRel = new DataRelation(
                    "OrderToItems",
                    ds.Tables["Orders"].Columns["OrderID"],
                    ds.Tables["OrderItems"].Columns["OrderID"],
                    false
                );
                ds.Relations.Add(orderRel);

                List<CustomerOrderViewModel> orderList = new List<CustomerOrderViewModel>();

                foreach (DataRow orderRow in ds.Tables["Orders"].Rows)
                {
                    int orderId = Convert.ToInt32(orderRow["OrderID"]);
                    DateTime orderDate = Convert.ToDateTime(orderRow["OrderDate"]);
                    decimal totalAmt = Convert.ToDecimal(orderRow["TotalAmount"]);
                    string status = orderRow["OrderStatus"].ToString();

                    DataRow[] childItems = orderRow.GetChildRows("OrderToItems");

                    string firstThumb = "";
                    int totalQty = 0;
                    List<string> itemDescriptions = new List<string>();

                    foreach (DataRow itemRow in childItems)
                    {
                        if (string.IsNullOrEmpty(firstThumb))
                        {
                            firstThumb = itemRow["MainImage"].ToString();
                        }

                        int qty = Convert.ToInt32(itemRow["Quantity"]);
                        string prodName = itemRow["ProductName"].ToString();
                        totalQty += qty;

                        if (qty > 1)
                        {
                            itemDescriptions.Add(qty + "x " + prodName);
                        }
                        else
                        {
                            itemDescriptions.Add(prodName);
                        }
                    }

                    string summaryNames = string.Join(", ", itemDescriptions.ToArray());

                    orderList.Add(new CustomerOrderViewModel(orderId, orderDate, totalAmt, status, firstThumb, totalQty, summaryNames));
                }

                // Syllabus Topic (Unit 5): LINQ Query Syntax to sort orders newest first
                var sortedOrders = from ord in orderList
                                   orderby ord.OrderID descending
                                   select ord;

                rptOrders.DataSource = sortedOrders.ToList();
                rptOrders.DataBind();
            }
            finally
            {
                con.Close();
            }
        }
    }
}