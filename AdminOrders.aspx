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

        <!-- Orders Table Card -->
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

            <!-- Row 1: Processing (Yellow) -->
            <div class="ss-ord-row">
                <span class="ss-col-oid ss-oid-text">#0891</span>
                <div class="ss-col-cust">
                    <span class="ss-cust-name">Vadhavana Ishit</span>
                    <span class="ss-cust-email">ishit@gmail.com</span>
                </div>
                <div class="ss-col-prod">
                    <span class="ss-prod-cat">Cotton</span>
                    <span class="ss-prod-title">Royal Maroon Zari Woven Saree</span>
                </div>
                <span class="ss-col-date">Aug 15, 2026</span>
                <span class="ss-col-total ss-total-amt">&#8377;14,500</span>
                <div class="ss-col-status">
                    <span class="ss-badge-yellow">PROCESSING</span>
                </div>
                <div class="ss-col-actions">
                    <a href="AdminEditOrder.aspx?id=0891" class="ss-ord-action-btn ss-ord-edit" title="Edit">
                        <i class="fa-solid fa-pencil"></i>
                    </a>
                    <a href="javascript:void(0);" class="ss-ord-action-btn ss-ord-delete"
                       onclick="confirm('Are you sure you want to delete this order?'); return false;"
                       title="Delete">
                        <i class="fa-regular fa-trash-can"></i>
                    </a>
                </div>
            </div>

            <!-- Row 2: Pending (Grey) -->
            <div class="ss-ord-row">
                <span class="ss-col-oid ss-oid-text">#0891</span>
                <div class="ss-col-cust">
                    <span class="ss-cust-name">Vadhavana Ishit</span>
                    <span class="ss-cust-email">ishit@gmail.com</span>
                </div>
                <div class="ss-col-prod">
                    <span class="ss-prod-cat">Banarasi</span>
                    <span class="ss-prod-title">Weddings, bridal wear</span>
                </div>
                <span class="ss-col-date">Aug 08, 2025</span>
                <span class="ss-col-total ss-total-amt">&#8377;32,800</span>
                <div class="ss-col-status">
                    <span class="ss-badge-grey">PENDING</span>
                </div>
                <div class="ss-col-actions">
                    <a href="AdminEditOrder.aspx?id=0891" class="ss-ord-action-btn ss-ord-edit" title="Edit">
                        <i class="fa-solid fa-pencil"></i>
                    </a>
                    <a href="javascript:void(0);" class="ss-ord-action-btn ss-ord-delete"
                       onclick="confirm('Are you sure you want to delete this order?'); return false;"
                       title="Delete">
                        <i class="fa-regular fa-trash-can"></i>
                    </a>
                </div>
            </div>

            <!-- Row 3: Shipped (Blue) -->
            <div class="ss-ord-row">
                <span class="ss-col-oid ss-oid-text">#0891</span>
                <div class="ss-col-cust">
                    <span class="ss-cust-name">Vadhavana Ishit</span>
                    <span class="ss-cust-email">ishit@gmail.com</span>
                </div>
                <div class="ss-col-prod">
                    <span class="ss-prod-cat">Bandhni</span>
                    <span class="ss-prod-title">Festivals, Navratri</span>
                </div>
                <span class="ss-col-date">Jan 30, 2026</span>
                <span class="ss-col-total ss-total-amt">&#8377;21,965</span>
                <div class="ss-col-status">
                    <span class="ss-badge-blue">SHIPPED</span>
                </div>
                <div class="ss-col-actions">
                    <a href="AdminEditOrder.aspx?id=0891" class="ss-ord-action-btn ss-ord-edit" title="Edit">
                        <i class="fa-solid fa-pencil"></i>
                    </a>
                    <a href="javascript:void(0);" class="ss-ord-action-btn ss-ord-delete"
                       onclick="confirm('Are you sure you want to delete this order?'); return false;"
                       title="Delete">
                        <i class="fa-regular fa-trash-can"></i>
                    </a>
                </div>
            </div>

            <!-- Row 4: Processing (Light Green) -->
            <div class="ss-ord-row">
                <span class="ss-col-oid ss-oid-text">#0891</span>
                <div class="ss-col-cust">
                    <span class="ss-cust-name">Vadhavana Ishit</span>
                    <span class="ss-cust-email">ishit@gmail.com</span>
                </div>
                <div class="ss-col-prod">
                    <span class="ss-prod-cat">Cotton</span>
                    <span class="ss-prod-title">Royal Maroon Zari Woven Saree</span>
                </div>
                <span class="ss-col-date">Jun 15, 2026</span>
                <span class="ss-col-total ss-total-amt">&#8377;56,206</span>
                <div class="ss-col-status">
                    <span class="ss-badge-green">PROCESSING</span>
                </div>
                <div class="ss-col-actions">
                    <a href="AdminEditOrder.aspx?id=0891" class="ss-ord-action-btn ss-ord-edit" title="Edit">
                        <i class="fa-solid fa-pencil"></i>
                    </a>
                    <a href="javascript:void(0);" class="ss-ord-action-btn ss-ord-delete"
                       onclick="confirm('Are you sure you want to delete this order?'); return false;"
                       title="Delete">
                        <i class="fa-regular fa-trash-can"></i>
                    </a>
                </div>
            </div>

            <!-- Row 5: Pending (Grey) -->
            <div class="ss-ord-row">
                <span class="ss-col-oid ss-oid-text">#0891</span>
                <div class="ss-col-cust">
                    <span class="ss-cust-name">Vadhavana Ishit</span>
                    <span class="ss-cust-email">ishit@gmail.com</span>
                </div>
                <div class="ss-col-prod">
                    <span class="ss-prod-cat">Banarasi</span>
                    <span class="ss-prod-title">Weddings, bridal wear</span>
                </div>
                <span class="ss-col-date">Dec 28, 2025</span>
                <span class="ss-col-total ss-total-amt">&#8377;32,800</span>
                <div class="ss-col-status">
                    <span class="ss-badge-grey">PENDING</span>
                </div>
                <div class="ss-col-actions">
                    <a href="AdminEditOrder.aspx?id=0891" class="ss-ord-action-btn ss-ord-edit" title="Edit">
                        <i class="fa-solid fa-pencil"></i>
                    </a>
                    <a href="javascript:void(0);" class="ss-ord-action-btn ss-ord-delete"
                       onclick="confirm('Are you sure you want to delete this order?'); return false;"
                       title="Delete">
                        <i class="fa-regular fa-trash-can"></i>
                    </a>
                </div>
            </div>

        </div>

    </div>
</asp:Content>