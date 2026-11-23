<%@ Page Title="Dashboard Overview" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="Shakti_Sarees.AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHead" runat="server">
    <link href="<%= ResolveUrl("~/Content/AdminDashboard.css?v=1") %>" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="ss-ov-container">
        
        <!-- Heading -->
        <h1 class="ss-ov-heading">Overview</h1>

        <!-- Top Stat Cards (5 Columns - 100% Dynamic from Database) -->
        <div class="ss-stat-grid">
            
            <div class="ss-stat-card">
                <span class="ss-stat-lbl">TOTAL<br />USERS</span>
                <span class="ss-stat-num"><asp:Literal ID="litTotalUsers" runat="server" Text="0"></asp:Literal></span>
            </div>

            <div class="ss-stat-card">
                <span class="ss-stat-lbl">PRODUCTS</span>
                <span class="ss-stat-num"><asp:Literal ID="litTotalProducts" runat="server" Text="0"></asp:Literal></span>
            </div>

            <div class="ss-stat-card">
                <span class="ss-stat-lbl">TOTAL<br />ORDERS</span>
                <span class="ss-stat-num"><asp:Literal ID="litTotalOrders" runat="server" Text="0"></asp:Literal></span>
            </div>

            <div class="ss-stat-card">
                <span class="ss-stat-lbl">CATEGORIES</span>
                <span class="ss-stat-num"><asp:Literal ID="litTotalCategories" runat="server" Text="0"></asp:Literal></span>
            </div>

            <div class="ss-stat-card">
                <span class="ss-stat-lbl">PENDING<br />ORDERS</span>
                <span class="ss-stat-num"><asp:Literal ID="litPendingOrders" runat="server" Text="0"></asp:Literal></span>
            </div>

        </div>

        <!-- Recent Orders Section (100% Dynamic from Orders & Users Tables) -->
        <div class="ss-recent-orders-card">
            
            <div class="ss-ro-header">
                <h2 class="ss-ro-title">Recent Orders</h2>
                <a href="AdminOrders.aspx" class="ss-ro-view-all">VIEW ALL &rarr;</a>
            </div>

            <!-- Table Header -->
            <div class="ss-ro-table-head">
                <span class="ss-col-oid">ORDER ID</span>
                <span class="ss-col-cust">CUSTOMER</span>
                <span class="ss-col-date">DATE</span>
                <span class="ss-col-amt">AMOUNT</span>
                <span class="ss-col-stat">STATUS</span>
            </div>

            <asp:Repeater ID="rptRecentOrders" runat="server">
                <ItemTemplate>
                    <div class="ss-ro-row">
                        <span class="ss-col-oid ss-oid-val">#<%# Eval("OrderID") %></span>
                        <span class="ss-col-cust"><%# Eval("FullName") %></span>
                        <span class="ss-col-date"><%# Convert.ToDateTime(Eval("OrderDate")).ToString("MMM dd, yyyy") %></span>
                        <span class="ss-col-amt ss-bold">&#8377;<%# Eval("TotalAmount") %></span>
                        <span class="ss-col-stat">
                            <span class="ss-badge-proc"><%# Eval("OrderStatus").ToString().ToUpper() %></span>
                        </span>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

        </div>

    </div>
</asp:Content>