<%@ Page Title="Manage Orders" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminOrders.aspx.cs" Inherits="Shakti_Sarees.AdminOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHead" runat="server">
    <link href="/Content/AdminOrders.css?v=1" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="ss-ord-viewport">

        <!-- Header & Action Button -->
        <div class="ss-ord-topbar">
            <div>
                <h1 class="ss-ord-title">Manage Orders</h1>
                <p class="ss-ord-subtitle">View, edit, and manage Customer Orders</p>
            </div>
            <a href="AdminAddOrder.aspx" class="ss-btn-create-order">
                <i class="fa-solid fa-plus"></i> Create Order
            </a>
        </div>

        <!-- Orders Table Card (100% Dynamic from Orders, Users, OrderItems & Products Tables) -->
        <div class="ss-ord-card">
            
            <!-- Table Header -->
            <div class="ss-ord-table-head">
                <span class="ss-col-oid">ORDER<br />ID</span>
                <span class="ss-col-cust">CUSTOMER</span>
                <span class="ss-col-prod">PRODUCT</span>
                <span class="ss-col-date">DATE</span>
                <span class="ss-col-total">TOTAL</span>
                <span class="ss-col-status">STATUS</span>
                <span class="ss-col-actions">ACTIONS</span>
            </div>

            <asp:Repeater ID="rptOrders" runat="server">
                <ItemTemplate>
                    <div class="ss-ord-row">
                        <span class="ss-col-oid ss-oid-text">#<%# Eval("OrderID") %></span>
                        <div class="ss-col-cust">
                            <span class="ss-cust-name"><%# Eval("FullName") %></span>
                            <span class="ss-cust-email"><%# Eval("CustomerEmail") %></span>
                        </div>
                        <div class="ss-col-prod">
                            <span class="ss-prod-cat"><%# Eval("CategoryName") %></span>
                            <span class="ss-prod-title"><%# Eval("ProductSummary") %></span>
                        </div>
                        <span class="ss-col-date"><%# Convert.ToDateTime(Eval("OrderDate")).ToString("MMM dd, yyyy") %></span>
                        <span class="ss-col-total ss-total-amt">&#8377;<%# Eval("TotalAmount") %></span>
                        <div class="ss-col-status">
                            <span class='<%# GetStatusBadgeClass(Eval("OrderStatus").ToString()) %>'>
                                <%# Eval("OrderStatus").ToString().ToUpper() %>
                            </span>
                        </div>
                        <div class="ss-col-actions">
                            <a href='AdminEditOrder.aspx?id=<%# Eval("OrderID") %>' class="ss-ord-action-btn ss-ord-edit" title="Edit">
                                <i class="fa-solid fa-pencil"></i>
                            </a>
                            <asp:LinkButton ID="btnDeleteOrder" runat="server" CssClass="ss-ord-action-btn ss-ord-delete"
                                OnClick="btnDeleteOrder_Click" CommandArgument='<%# Eval("OrderID") %>'
                                OnClientClick="return confirm('Are you sure you want to delete this order?');"
                                ToolTip="Delete">
                                <i class="fa-regular fa-trash-can"></i>
                            </asp:LinkButton>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

        </div>

    </div>
</asp:Content>