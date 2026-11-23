<%@ Page Title="Order Details" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderDetails.aspx.cs" Inherits="Shakti_Sarees.OrderDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="<%= ResolveUrl("~/Content/OrderDetails.css?v=1") %>" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="ss-od-viewport">
        <div class="ss-od-layout">
            
            <!-- ================= LEFT: DELIVERY STATUS CARD (100% DYNAMIC) ================= -->
            <div class="ss-od-status-col">
                <div class="ss-od-card ss-status-card">
                    <h2 class="ss-od-card-heading">
                        Order #<asp:Literal ID="litOrderIdHeading" runat="server"></asp:Literal> 
                        <span style="font-size:12px; font-weight:normal; color:#72081B; float:right;">Placed on <asp:Literal ID="litOrderDate" runat="server"></asp:Literal></span>
                    </h2>

                    <div class="ss-timeline">
                        <!-- Step 1: Confirmed -->
                        <div id="stepConfirmed" runat="server" class="ss-step ss-step-pending">
                            <h4 class="ss-step-title">Order Confirmed</h4>
                            <p class="ss-step-desc">We have received your order.</p>
                        </div>

                        <!-- Step 2: Shipped -->
                        <div id="stepShipped" runat="server" class="ss-step ss-step-pending">
                            <h4 class="ss-step-title">Shipped / Dispatched</h4>
                            <p class="ss-step-desc">Your item has been handed over to our delivery partner.</p>
                        </div>

                        <!-- Step 3: Out for Delivery -->
                        <div id="stepOutForDelivery" runat="server" class="ss-step ss-step-pending">
                            <h4 class="ss-step-title">Out for Delivery</h4>
                            <p class="ss-step-desc">Pending delivery to final destination.</p>
                        </div>

                        <!-- Step 4: Delivered -->
                        <div id="stepDelivered" runat="server" class="ss-step ss-step-pending">
                            <h4 class="ss-step-title">Delivered</h4>
                            <p class="ss-step-desc">Order arrives at your address.</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ================= RIGHT: ITEM DETAILS & ADDRESS (100% DYNAMIC) ================= -->
            <div class="ss-od-sidebar-col">
                
                <!-- 1. Item Details Card -->
                <div class="ss-od-card ss-bar-card">
                    <div class="ss-card-topbar">
                        <h3 class="ss-topbar-title">Item Details</h3>
                    </div>
                    <div class="ss-card-inner">
                        <asp:Repeater ID="rptOrderItems" runat="server">
                            <ItemTemplate>
                                <div class="ss-item-snippet" style="margin-bottom: 15px; border-bottom: 1px solid #ECE7E1; padding-bottom: 12px;">
                                    <div class="ss-item-preview">
                                        <img src='<%# Eval("MainImage") %>' alt='<%# Eval("ProductName") %>' />
                                    </div>
                                    <div class="ss-item-info">
                                        <span class="ss-tag-silk"><%# Eval("CategoryName").ToString().ToUpper() %></span>
                                        <h4 class="ss-item-name"><%# Eval("ProductName") %></h4>
                                        <span class="ss-item-qty">Qty: <%# Eval("Quantity") %></span>
                                        <span class="ss-item-cost">&#8377; <%# Eval("Price") %></span>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                    <div class="ss-item-total-strip">
                        <span class="ss-tot-label">Total Amount</span>
                        <span class="ss-tot-value">&#8377; <asp:Literal ID="litTotalAmount" runat="server"></asp:Literal></span>
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
                        <p class="ss-addr-name"><asp:Literal ID="litFullName" runat="server"></asp:Literal></p>
                        <p class="ss-addr-line"><asp:Literal ID="litAddress" runat="server"></asp:Literal></p>
                        <p class="ss-addr-line"><asp:Literal ID="litCityPin" runat="server"></asp:Literal></p>
                        <p class="ss-addr-line">India</p>
                        <p class="ss-addr-phone">Phone: +91 <asp:Literal ID="litMobile" runat="server"></asp:Literal></p>
                    </div>
                </div>

            </div>

        </div>
    </div>
</asp:Content>