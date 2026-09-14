<%@ Page Title="Products" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="Shakti_Sarees.Products" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="<%= ResolveUrl("~/Content/Products.css?v=1") %>" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="ss-products-layout">

        <!-- ================= LEFT SIDEBAR: FILTERS ================= -->
        <aside class="ss-filter-sidebar">
            <div class="ss-filter-card">
                
                <div class="ss-filter-header">
                    <h2 class="ss-filter-title">Filters</h2>
                    <asp:LinkButton ID="btnClearAll" runat="server" CssClass="ss-clear-all" OnClick="btnClearAll_Click">Clear All</asp:LinkButton>
                </div>

                <!-- Category Filters -->
                <div class="ss-filter-group">
                    <span class="ss-filter-label">CATEGORY</span>
                    <div class="ss-filter-checkboxes">
                        <asp:CheckBoxList ID="cblCategories" runat="server" CssClass="ss-cbl-list" RepeatLayout="UnorderedList">
                            <asp:ListItem Text="Banarasi" Value="Banarasi" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Kanchipuram" Value="Kanchipuram"></asp:ListItem>
                            <asp:ListItem Text="Cotton" Value="Cotton"></asp:ListItem>
                            <asp:ListItem Text="Bandhni" Value="Bandhni"></asp:ListItem>
                        </asp:CheckBoxList>
                    </div>
                </div>

                <!-- Price Range Filters -->
                <div class="ss-filter-group">
                    <span class="ss-filter-label">PRICE RANGE (₹)</span>
                    <div class="ss-price-inputs">
                        <asp:TextBox ID="txtMinPrice" runat="server" CssClass="ss-price-box" Text="5000"></asp:TextBox>
                        <span class="ss-price-sep">-</span>
                        <asp:TextBox ID="txtMaxPrice" runat="server" CssClass="ss-price-box" Text="25000"></asp:TextBox>
                    </div>
                </div>

                <!-- Apply Filters Action -->
                <asp:Button ID="btnApplyFilters" runat="server" Text="Apply Filters" CssClass="ss-apply-filter-btn" OnClick="btnApplyFilters_Click" />

            </div>
        </aside>

        <!-- ================= RIGHT COLUMN: SEARCH RESULTS & PRODUCTS ================= -->
        <section class="ss-products-catalog">
            
            <header class="ss-catalog-header">
                <h1 class="ss-catalog-heading">
                    <asp:Literal ID="litPageTitle" runat="server" Text="Search Results"></asp:Literal>
                </h1>
            </header>

            <div class="ss-catalog-grid">

                <!-- Product Card 1 -->
                <div class="ss-saree-card">
                    <div class="ss-saree-media">
                        <span class="ss-saree-badge">BANARASI</span>
                        <img src="/images/product_royal_maroon.png" alt="Royal Maroon" />
                    </div>
                    <div class="ss-saree-body">
                        <div class="ss-saree-top-row">
                            <h3 class="ss-saree-name">Royal Maroon...</h3>
                            <span class="ss-saree-price">&#8377;18,500</span>
                        </div>
                        <p class="ss-saree-desc">Pure silk with pure zari woven motifs, perfect for bridal wear</p>
                        <div class="ss-saree-actions">
                            <a href="ProductDetail.aspx?id=1" class="ss-btn-details">Details</a>
                            <asp:LinkButton ID="btnAdd1" runat="server" CssClass="ss-btn-add" OnClick="btnAddToCart_Click" CommandArgument="1">
                                <i class="fa-solid fa-cart-shopping"></i> Add
                            </asp:LinkButton>
                        </div>
                    </div>
                </div>

                <!-- Product Card 2 -->
                <div class="ss-saree-card">
                    <div class="ss-saree-media">
                        <span class="ss-saree-badge">BANARASI</span>
                        <img src="/images/product_emerald.png" alt="Emerald Handloom" />
                    </div>
                    <div class="ss-saree-body">
                        <div class="ss-saree-top-row">
                            <h3 class="ss-saree-name">Emerald...</h3>
                            <span class="ss-saree-price">&#8377;22,000</span>
                        </div>
                        <p class="ss-saree-desc">Authentic handloom weave featuring traditional temple...</p>
                        <div class="ss-saree-actions">
                            <a href="ProductDetail.aspx?id=2" class="ss-btn-details">Details</a>
                            <asp:LinkButton ID="btnAdd2" runat="server" CssClass="ss-btn-add" OnClick="btnAddToCart_Click" CommandArgument="2">
                                <i class="fa-solid fa-cart-shopping"></i> Add
                            </asp:LinkButton>
                        </div>
                    </div>
                </div>

                <!-- Product Card 3 -->
                <div class="ss-saree-card">
                    <div class="ss-saree-media">
                        <span class="ss-saree-badge">COTTON</span>
                        <img src="/images/product_mustard_pink.png" alt="Mustard & Pink" />
                    </div>
                    <div class="ss-saree-body">
                        <div class="ss-saree-top-row">
                            <h3 class="ss-saree-name">Mustard & Pink</h3>
                            <span class="ss-saree-price">&#8377;15,000</span>
                        </div>
                        <p class="ss-saree-desc">A festive classic combining vibrant mustard with rich rani</p>
                        <div class="ss-saree-actions">
                            <a href="ProductDetail.aspx?id=3" class="ss-btn-details">Details</a>
                            <asp:LinkButton ID="btnAdd3" runat="server" CssClass="ss-btn-add" OnClick="btnAddToCart_Click" CommandArgument="3">
                                <i class="fa-solid fa-cart-shopping"></i> Add
                            </asp:LinkButton>
                        </div>
                    </div>
                </div>

                <!-- Product Card 4 -->
                <div class="ss-saree-card">
                    <div class="ss-saree-media">
                        <span class="ss-saree-badge">BANDHNI</span>
                        <img src="/images/product_emerald.png" alt="Emerald Bandhni" />
                    </div>
                    <div class="ss-saree-body">
                        <div class="ss-saree-top-row">
                            <h3 class="ss-saree-name">Emerald...</h3>
                            <span class="ss-saree-price">&#8377;22,000</span>
                        </div>
                        <p class="ss-saree-desc">Authentic handloom weave featuring traditional temple...</p>
                        <div class="ss-saree-actions">
                            <a href="ProductDetail.aspx?id=4" class="ss-btn-details">Details</a>
                            <asp:LinkButton ID="btnAdd4" runat="server" CssClass="ss-btn-add" OnClick="btnAddToCart_Click" CommandArgument="4">
                                <i class="fa-solid fa-cart-shopping"></i> Add
                            </asp:LinkButton>
                        </div>
                    </div>
                </div>

                <!-- Product Card 5 -->
                <div class="ss-saree-card">
                    <div class="ss-saree-media">
                        <span class="ss-saree-badge">SILK</span>
                        <img src="/images/product_pastel_peach.png" alt="Pastel Peach" />
                    </div>
                    <div class="ss-saree-body">
                        <div class="ss-saree-top-row">
                            <h3 class="ss-saree-name">Pastel Peach...</h3>
                            <span class="ss-saree-price">&#8377;12,400</span>
                        </div>
                        <p class="ss-saree-desc">Lightweight pure crepe silk, celebrated for its minimal...</p>
                        <div class="ss-saree-actions">
                            <a href="ProductDetail.aspx?id=5" class="ss-btn-details">Details</a>
                            <asp:LinkButton ID="btnAdd5" runat="server" CssClass="ss-btn-add" OnClick="btnAddToCart_Click" CommandArgument="5">
                                <i class="fa-solid fa-cart-shopping"></i> Add
                            </asp:LinkButton>
                        </div>
                    </div>
                </div>

                <!-- Product Card 6 -->
                <div class="ss-saree-card">
                    <div class="ss-saree-media">
                        <span class="ss-saree-badge">CHIFFON</span>
                        <img src="/images/product_navy_blur_silk.png" alt="Navy Blue Silk" />
                    </div>
                    <div class="ss-saree-body">
                        <div class="ss-saree-top-row">
                            <h3 class="ss-saree-name">Navy Blue Silk</h3>
                            <span class="ss-saree-price">&#8377;8,900</span>
                        </div>
                        <p class="ss-saree-desc">Rich textured Tussar with handcrafted Kantha...</p>
                        <div class="ss-saree-actions">
                            <a href="ProductDetail.aspx?id=6" class="ss-btn-details">Details</a>
                            <asp:LinkButton ID="btnAdd6" runat="server" CssClass="ss-btn-add" OnClick="btnAddToCart_Click" CommandArgument="6">
                                <i class="fa-solid fa-cart-shopping"></i> Add
                            </asp:LinkButton>
                        </div>
                    </div>
                </div>

            </div>
        </section>

    </div>
</asp:Content>