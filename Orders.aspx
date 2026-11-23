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

        <!-- Orders List Container (100% Dynamic from Orders & OrderItems Tables) -->
        <div class="ss-orders-list">
            <asp:Repeater ID="rptOrders" runat="server">
                <ItemTemplate>
                    <div class="ss-order-card">
                        <div class="ss-order-media">
                            <img src='<%# Eval("ThumbnailImage") %>' alt='Order <%# Eval("OrderID") %> Thumbnail' />
                        </div>
                        <div class="ss-order-content">
                            <div class="ss-order-top">
                                <h3 class="ss-order-num">Order <%# Eval("OrderID") %></h3>
                                <span class='<%# Eval("BadgeCssClass") %>'><%# Eval("StatusText") %></span>
                            </div>
                            <div class="ss-order-date">Placed on <%# Eval("FormattedDate") %></div>
                            
                            <div class="ss-order-items-summary">
                                <span class="ss-items-count">Items: <%# Eval("TotalItems") %></span>
                                <p class="ss-items-names"><%# Eval("ItemNamesSummary") %></p>
                            </div>

                            <div class="ss-order-bottom">
                                <div class="ss-order-price">&#8377;<%# Eval("TotalAmount") %></div>
                                <a href='OrderDetails.aspx?id=<%# Eval("OrderID") %>' class="ss-btn-view-details">View Details</a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

    </div>
</asp:Content>