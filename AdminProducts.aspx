<%@ Page Title="Manage Products" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminProducts.aspx.cs" Inherits="Shakti_Sarees.AdminProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHead" runat="server">
    <link href="<%= ResolveUrl("~/Content/AdminProducts.css?v=1") %>" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="ss-mp-container">

        <!-- Top Header & Add Action -->
        <div class="ss-mp-header">
            <div>
                <h1 class="ss-mp-title">Manage Products</h1>
                <p class="ss-mp-subtitle">View, edit, and organize the saree inventory.</p>
            </div>
            <a href="AdminAddProduct.aspx" class="ss-btn-add-prod">
                <i class="fa-solid fa-plus"></i> Add Product
            </a>
        </div>

        <!-- Inventory Table Card (100% Dynamic from Products & Categories Tables) -->
        <div class="ss-mp-table-card">
            
            <!-- Table Header -->
            <div class="ss-mp-head-row">
                <span class="ss-col-img">Image</span>
                <span class="ss-col-id">ID</span>
                <span class="ss-col-name">Product Name</span>
                <span class="ss-col-cat">Category</span>
                <span class="ss-col-price">Price</span>
                <span class="ss-col-stock">Stock</span>
                <span class="ss-col-status">Status</span>
                <span class="ss-col-actions">Actions</span>
            </div>

            <asp:Repeater ID="rptProducts" runat="server">
                <ItemTemplate>
                    <div class="ss-mp-data-row">
                        <div class="ss-col-img">
                            <div class="ss-prod-thumb">
                                <img src='<%# Eval("MainImage") %>' alt='<%# Eval("ProductName") %>' />
                            </div>
                        </div>
                        <span class="ss-col-id">#<%# Eval("ProductID") %></span>
                        <span class="ss-col-name"><%# Eval("ProductName") %></span>
                        <span class="ss-col-cat"><%# Eval("CategoryName") %></span>
                        <span class="ss-col-price">&#8377; <%# Eval("Price") %></span>
                        <span class="ss-col-stock"><%# Eval("StockQuantity") %></span>
                        <div class="ss-col-status">
                            <span class='<%# Convert.ToInt32(Eval("StockQuantity")) > 0 && Eval("Status").ToString() == "Active" ? "ss-badge-instock" : "ss-badge-outstock" %>'>
                                <%# Eval("Status").ToString() == "Inactive" ? "INACTIVE" : (Convert.ToInt32(Eval("StockQuantity")) > 0 ? "IN STOCK" : "OUT OF STOCK") %>
                            </span>
                        </div>
                        <div class="ss-col-actions">
                            <a href='AdminEditProduct.aspx?id=<%# Eval("ProductID") %>' class="ss-action-btn ss-edit-btn" title="Edit">
                                <i class="fa-solid fa-pencil"></i>
                            </a>
                            <asp:LinkButton ID="btnDelete" runat="server" CssClass="ss-action-btn ss-delete-btn"
                                OnClick="btnDelete_Click" CommandArgument='<%# Eval("ProductID") %>'
                                OnClientClick="return confirm('Are you sure you want to delete this product?');"
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