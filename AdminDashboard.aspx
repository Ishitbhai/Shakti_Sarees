<%@ Page Title="Dashboard Overview" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="Shakti_Sarees.AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHead" runat="server">
    <link href="<%= ResolveUrl("~/Content/AdminDashboard.css?v=1") %>" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="ss-ov-container">
        
        <!-- Heading -->
        <h1 class="ss-ov-heading">Overview</h1>

        <!-- Top Stat Cards (5 Columns) -->
        <div class="ss-stat-grid">
            
            <div class="ss-stat-card">
                <span class="ss-stat-lbl">TOTAL<br />USERS</span>
                <span class="ss-stat-num">1,248</span>
            </div>

            <div class="ss-stat-card">
                <span class="ss-stat-lbl">PRODUCTS</span>
                <span class="ss-stat-num">342</span>
            </div>

            <div class="ss-stat-card">
                <span class="ss-stat-lbl">TOTAL<br />ORDERS</span>
                <span class="ss-stat-num">8,902</span>
            </div>

            <div class="ss-stat-card">
                <span class="ss-stat-lbl">CATEGORIES</span>
                <span class="ss-stat-num">16</span>
            </div>

            <div class="ss-stat-card">
                <span class="ss-stat-lbl">PENDING<br />ORDERS</span>
                <span class="ss-stat-num">47</span>
            </div>

        </div>

        <!-- Recent Orders Section -->
        <div class="ss-recent-orders-card">
            
            <div class="ss-ro-header">
                <h2 class="ss-ro-title">Recent Orders</h2>
                <a href="ManageOrders.aspx" class="ss-ro-view-all">VIEW ALL &rarr;</a>
            </div>

            <!-- Table Header -->
            <div class="ss-ro-table-head">
                <span class="ss-col-oid">ORDER ID</span>
                <span class="ss-col-cust">CUSTOMER</span>
                <span class="ss-col-date">DATE</span>
                <span class="ss-col-amt">AMOUNT</span>
                <span class="ss-col-stat">STATUS</span>
            </div>

            <!-- Row 1 -->
            <div class="ss-ro-row">
                <span class="ss-col-oid ss-oid-val">#ORD-092</span>
                <span class="ss-col-cust">Smit Vadhavana</span>
                <span class="ss-col-date">Oct 24, 2023</span>
                <span class="ss-col-amt ss-bold">&#8377;12,450</span>
                <span class="ss-col-stat"><span class="ss-badge-proc">PROCESSING</span></span>
            </div>

            <!-- Row 2 -->
            <div class="ss-ro-row">
                <span class="ss-col-oid ss-oid-val">#ORD-093</span>
                <span class="ss-col-cust">Raj Patel</span>
                <span class="ss-col-date">Oct 23, 2023</span>
                <span class="ss-col-amt ss-bold">&#8377;4,570</span>
                <span class="ss-col-stat"><span class="ss-badge-proc">PROCESSING</span></span>
            </div>

            <!-- Row 3 -->
            <div class="ss-ro-row">
                <span class="ss-col-oid ss-oid-val">#ORD-094</span>
                <span class="ss-col-cust">Aayush Suyani</span>
                <span class="ss-col-date">Oct 23, 2023</span>
                <span class="ss-col-amt ss-bold">&#8377;55,657</span>
                <span class="ss-col-stat"><span class="ss-badge-proc">PROCESSING</span></span>
            </div>

            <!-- Row 4 -->
            <div class="ss-ro-row">
                <span class="ss-col-oid ss-oid-val">#ORD-095</span>
                <span class="ss-col-cust">Amit Shah</span>
                <span class="ss-col-date">Oct 21, 2023</span>
                <span class="ss-col-amt ss-bold">&#8377;96,127</span>
                <span class="ss-col-stat"><span class="ss-badge-proc">PROCESSING</span></span>
            </div>

        </div>

    </div>
</asp:Content>