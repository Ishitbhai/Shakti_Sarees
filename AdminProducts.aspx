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

        <!-- Inventory Table Card -->
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

            <!-- Row 1: In Stock -->
            <div class="ss-mp-data-row">
                <div class="ss-col-img">
                    <div class="ss-prod-thumb">
                        <img src="/images/home_main.png" alt="Crimson Gold Kanjeevaram" />
                    </div>
                </div>
                <span class="ss-col-id">#PRD-101</span>
                <span class="ss-col-name">Crimson Gold Kanjeevaram</span>
                <span class="ss-col-cat">Kanjeevaram</span>
                <span class="ss-col-price">&#8377; 24,500</span>
                <span class="ss-col-stock">12</span>
                <div class="ss-col-status">
                    <span class="ss-badge-instock">IN STOCK</span>
                </div>
                <div class="ss-col-actions">
                    <a href="AdminEditProduct.aspx?id=101" class="ss-action-btn ss-edit-btn" title="Edit">
                        <i class="fa-solid fa-pencil"></i>
                    </a>
                    <asp:LinkButton ID="btnDelete1" runat="server" CssClass="ss-action-btn ss-delete-btn"
                        OnClick="btnDelete_Click" CommandArgument="101"
                        OnClientClick="return confirm('Are you sure you want to delete this product?');"
                        ToolTip="Delete">
                        <i class="fa-regular fa-trash-can"></i>
                    </asp:LinkButton>
                </div>
            </div>

            <!-- Row 2: In Stock -->
            <div class="ss-mp-data-row">
                <div class="ss-col-img">
                    <div class="ss-prod-thumb">
                        <img src="/images/home_main.png" alt="Kasavu Cotton Classic" />
                    </div>
                </div>
                <span class="ss-col-id">#PRD-102</span>
                <span class="ss-col-name">Kasavu Cotton Classic</span>
                <span class="ss-col-cat">Cotton</span>
                <span class="ss-col-price">&#8377; 3,200</span>
                <span class="ss-col-stock">2</span>
                <div class="ss-col-status">
                    <span class="ss-badge-instock">IN STOCK</span>
                </div>
                <div class="ss-col-actions">
                    <a href="AdminEditProduct.aspx?id=102" class="ss-action-btn ss-edit-btn" title="Edit">
                        <i class="fa-solid fa-pencil"></i>
                    </a>
                    <asp:LinkButton ID="btnDelete2" runat="server" CssClass="ss-action-btn ss-delete-btn"
                        OnClick="btnDelete_Click" CommandArgument="102"
                        OnClientClick="return confirm('Are you sure you want to delete this product?');"
                        ToolTip="Delete">
                        <i class="fa-regular fa-trash-can"></i>
                    </asp:LinkButton>
                </div>
            </div>

            <!-- Row 3: Out of Stock -->
            <div class="ss-mp-data-row">
                <div class="ss-col-img">
                    <div class="ss-prod-thumb">
                        <img src="/images/home_main.png" alt="Emerald Flora Banarasi" />
                    </div>
                </div>
                <span class="ss-col-id">#PRD-103</span>
                <span class="ss-col-name">Emerald Flora Banarasi</span>
                <span class="ss-col-cat">Banarasi</span>
                <span class="ss-col-price">&#8377; 18,900</span>
                <span class="ss-col-stock">0</span>
                <div class="ss-col-status">
                    <span class="ss-badge-outstock">OUT OF STOCK</span>
                </div>
                <div class="ss-col-actions">
                    <a href="AdminEditProduct.aspx?id=103" class="ss-action-btn ss-edit-btn" title="Edit">
                        <i class="fa-solid fa-pencil"></i>
                    </a>
                    <asp:LinkButton ID="btnDelete3" runat="server" CssClass="ss-action-btn ss-delete-btn"
                        OnClick="btnDelete_Click" CommandArgument="103"
                        OnClientClick="return confirm('Are you sure you want to delete this product?');"
                        ToolTip="Delete">
                        <i class="fa-regular fa-trash-can"></i>
                    </asp:LinkButton>
                </div>
            </div>

            <!-- Row 4: In Stock -->
            <div class="ss-mp-data-row">
                <div class="ss-col-img">
                    <div class="ss-prod-thumb">
                        <img src="/images/home_main.png" alt="Crimson Gold Kanjeevaram" />
                    </div>
                </div>
                <span class="ss-col-id">#PRD-101</span>
                <span class="ss-col-name">Crimson Gold Kanjeevaram</span>
                <span class="ss-col-cat">Kanjeevaram</span>
                <span class="ss-col-price">&#8377; 24,500</span>
                <span class="ss-col-stock">12</span>
                <div class="ss-col-status">
                    <span class="ss-badge-instock">IN STOCK</span>
                </div>
                <div class="ss-col-actions">
                    <a href="AdminEditProduct.aspx?id=101" class="ss-action-btn ss-edit-btn" title="Edit">
                        <i class="fa-solid fa-pencil"></i>
                    </a>
                    <asp:LinkButton ID="btnDelete4" runat="server" CssClass="ss-action-btn ss-delete-btn"
                        OnClick="btnDelete_Click" CommandArgument="101"
                        OnClientClick="return confirm('Are you sure you want to delete this product?');"
                        ToolTip="Delete">
                        <i class="fa-regular fa-trash-can"></i>
                    </asp:LinkButton>
                </div>
            </div>

            <!-- Row 5: In Stock -->
            <div class="ss-mp-data-row">
                <div class="ss-col-img">
                    <div class="ss-prod-thumb">
                        <img src="/images/home_main.png" alt="Kasavu Cotton Classic" />
                    </div>
                </div>
                <span class="ss-col-id">#PRD-102</span>
                <span class="ss-col-name">Kasavu Cotton Classic</span>
                <span class="ss-col-cat">Cotton</span>
                <span class="ss-col-price">&#8377; 3,200</span>
                <span class="ss-col-stock">2</span>
                <div class="ss-col-status">
                    <span class="ss-badge-instock">IN STOCK</span>
                </div>
                <div class="ss-col-actions">
                    <a href="AdminEditProduct.aspx?id=102" class="ss-action-btn ss-edit-btn" title="Edit">
                        <i class="fa-solid fa-pencil"></i>
                    </a>
                    <asp:LinkButton ID="btnDelete5" runat="server" CssClass="ss-action-btn ss-delete-btn"
                        OnClick="btnDelete_Click" CommandArgument="102"
                        OnClientClick="return confirm('Are you sure you want to delete this product?');"
                        ToolTip="Delete">
                        <i class="fa-regular fa-trash-can"></i>
                    </asp:LinkButton>
                </div>
            </div>

            <!-- Row 6: Out of Stock -->
            <div class="ss-mp-data-row">
                <div class="ss-col-img">
                    <div class="ss-prod-thumb">
                        <img src="/images/home_main.png" alt="Emerald Flora Banarasi" />
                    </div>
                </div>
                <span class="ss-col-id">#PRD-103</span>
                <span class="ss-col-name">Emerald Flora Banarasi</span>
                <span class="ss-col-cat">Banarasi</span>
                <span class="ss-col-price">&#8377; 18,900</span>
                <span class="ss-col-stock">0</span>
                <div class="ss-col-status">
                    <span class="ss-badge-outstock">OUT OF STOCK</span>
                </div>
                <div class="ss-col-actions">
                    <a href="AdminEditProduct.aspx?id=103" class="ss-action-btn ss-edit-btn" title="Edit">
                        <i class="fa-solid fa-pencil"></i>
                    </a>
                    <asp:LinkButton ID="btnDelete6" runat="server" CssClass="ss-action-btn ss-delete-btn"
                        OnClick="btnDelete_Click" CommandArgument="103"
                        OnClientClick="return confirm('Are you sure you want to delete this product?');"
                        ToolTip="Delete">
                        <i class="fa-regular fa-trash-can"></i>
                    </asp:LinkButton>
                </div>
            </div>

        </div>

    </div>
</asp:Content>