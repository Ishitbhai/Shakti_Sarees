<%@ Page Title="Order History" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="Shakti_Sarees.Orders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="<%= ResolveUrl("~/Content/Orders.css?v=1") %>" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="ss-orders-viewport">
        
        <!-- Header -->
        <header class="ss-orders-header">
            <h1 class="ss-orders-title">Order History</h1>
            <p class="ss-orders-subtitle">View your recent purchases.</p>
        </header>

        <!-- Orders List Container -->
        <div class="ss-orders-list">

            <!-- Order Card 1: Processing -->
            <div class="ss-order-card">
                <div class="ss-order-media">
                    <img src="/images/order_history_1.png" alt="Order 1 Thumbnail" />
                </div>
                <div class="ss-order-content">
                    <div class="ss-order-top">
                        <h3 class="ss-order-num">Order 1</h3>
                        <span class="ss-status-badge ss-badge-processing">PROCESSING</span>
                    </div>
                    <div class="ss-order-date">Placed on October 15, 2024</div>
                    
                    <div class="ss-order-items-summary">
                        <span class="ss-items-count">Items: 2</span>
                        <p class="ss-items-names">Kanjeevaram Silk Saree (Maroon), Cotton Handloom Saree (Indigo)</p>
                    </div>

                    <div class="ss-order-bottom">
                        <div class="ss-order-price">&#8377;51,434</div>
                        <a href="OrderDetails.aspx?id=1" class="ss-btn-view-details">View Details</a>
                    </div>
                </div>
            </div>

            <!-- Order Card 2: Shipped -->
            <div class="ss-order-card">
                <div class="ss-order-media">
                    <img src="/images/order_history_2.png" alt="Order 2 Thumbnail" />
                </div>
                <div class="ss-order-content">
                    <div class="ss-order-top">
                        <h3 class="ss-order-num">Order 2</h3>
                        <span class="ss-status-badge ss-badge-shipped">SHIPPED</span>
                    </div>
                    <div class="ss-order-date">Placed on October 28, 2024</div>
                    
                    <div class="ss-order-items-summary">
                        <span class="ss-items-count">Items: 1</span>
                        <p class="ss-items-names">Mangalagiri Cotton Saree (Mustard)</p>
                    </div>

                    <div class="ss-order-bottom">
                        <div class="ss-order-price">&#8377;36,309</div>
                        <a href="OrderDetails.aspx?id=2" class="ss-btn-view-details">View Details</a>
                    </div>
                </div>
            </div>

            <!-- Order Card 3: Delivered -->
            <div class="ss-order-card">
                <div class="ss-order-media">
                    <img src="/images/order_history_3.png" alt="Order 3 Thumbnail" />
                </div>
                <div class="ss-order-content">
                    <div class="ss-order-top">
                        <h3 class="ss-order-num">Order 3</h3>
                        <span class="ss-status-badge ss-badge-delivered">DELIVERED</span>
                    </div>
                    <div class="ss-order-date">Placed on November 02, 2024</div>
                    
                    <div class="ss-order-items-summary">
                        <span class="ss-items-count">Items: 3</span>
                        <p class="ss-items-names">Banarasi Silk Saree (Emerald), 2x Silk Blouse Pieces</p>
                    </div>

                    <div class="ss-order-bottom">
                        <div class="ss-order-price">&#8377;37,900</div>
                        <a href="OrderDetails.aspx?id=3" class="ss-btn-view-details">View Details</a>
                    </div>
                </div>
            </div>

        </div>
    </div>
</asp:Content>