<%@ Page Title="Order Details" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderDetails.aspx.cs" Inherits="Shakti_Sarees.OrderDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="<%= ResolveUrl("~/Content/OrderDetails.css?v=1") %>" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="ss-od-viewport">
        <div class="ss-od-layout">
            
            <!-- ================= LEFT: DELIVERY STATUS CARD ================= -->
            <div class="ss-od-status-col">
                <div class="ss-od-card ss-status-card">
                    <h2 class="ss-od-card-heading">Delivery Status</h2>

                    <div class="ss-timeline">
                        <!-- Step 1: Completed -->
                        <div class="ss-step ss-step-active">
                            <h4 class="ss-step-title">Order Confirmed</h4>
                            <p class="ss-step-desc">We have received your order.</p>
                        </div>

                        <!-- Step 2: Completed -->
                        <div class="ss-step ss-step-active">
                            <h4 class="ss-step-title">Shipped / Dispatched</h4>
                            <p class="ss-step-desc">Your item has been handed over to our delivery partner.</p>
                        </div>

                        <!-- Step 3: Pending -->
                        <div class="ss-step ss-step-pending">
                            <h4 class="ss-step-title">Out for Delivery</h4>
                            <p class="ss-step-desc">Pending delivery to final destination.</p>
                        </div>

                        <!-- Step 4: Pending -->
                        <div class="ss-step ss-step-pending">
                            <h4 class="ss-step-title">Delivered</h4>
                            <p class="ss-step-desc">Order arrives at your address.</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ================= RIGHT: ITEM DETAILS & ADDRESS ================= -->
            <div class="ss-od-sidebar-col">
                
                <!-- 1. Item Details Card -->
                <div class="ss-od-card ss-bar-card">
                    <div class="ss-card-topbar">
                        <h3 class="ss-topbar-title">Item Details</h3>
                    </div>
                    <div class="ss-card-inner">
                        <div class="ss-item-snippet">
                            <div class="ss-item-preview">
                                <img src="/images/order_detail.png" alt="Crimson Kanjeevaram Bridal Saree" />
                            </div>
                            <div class="ss-item-info">
                                <span class="ss-tag-silk">SILK</span>
                                <h4 class="ss-item-name">Crimson Kanjeevaram Bridal Saree</h4>
                                <span class="ss-item-qty">Qty: 1</span>
                                <span class="ss-item-cost">&#8377; 24,500</span>
                            </div>
                        </div>
                    </div>
                    <div class="ss-item-total-strip">
                        <span class="ss-tot-label">Total</span>
                        <span class="ss-tot-value">&#8377; 24,500</span>
                    </div>
                </div>

                <!-- 2. Delivery Address Card -->
                <div class="ss-od-card ss-bar-card">
                    <div class="ss-card-topbar">
                        <h3 class="ss-topbar-title">
                            <i class="fa-solid fa-location-dot ss-pin-icon"></i> Delivery Address
                        </h3>
                    </div>
                    <div class="ss-card-inner ss-addr-inner">
                        <p class="ss-addr-name">Ishit Vadhavana</p>
                        <p class="ss-addr-line">Samras Boys Hostel</p>
                        <p class="ss-addr-line">Rajkot, 360005</p>
                        <p class="ss-addr-line">India</p>
                        <p class="ss-addr-phone">Phone: +91 84600 65647</p>
                    </div>
                </div>

            </div>

        </div>
    </div>
</asp:Content>