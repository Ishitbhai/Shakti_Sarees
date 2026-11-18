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

                <!-- Category Filters (100% Dynamic from Categories Table) -->
                <div class="ss-filter-group">
                    <span class="ss-filter-label">CATEGORY</span>
                    <div class="ss-filter-checkboxes">
                        <asp:CheckBoxList ID="cblCategories" runat="server" CssClass="ss-cbl-list" RepeatLayout="UnorderedList" DataTextField="CategoryName" DataValueField="CategoryID">
                        </asp:CheckBoxList>
                    </div>
                </div>

                <!-- Price Range Filters -->
                <div class="ss-filter-group">
                    <span class="ss-filter-label">PRICE RANGE (₹)</span>
                    <div class="ss-price-inputs">
                        <asp:TextBox ID="txtMinPrice" runat="server" CssClass="ss-price-box" Text="500"></asp:TextBox>
                        <span class="ss-price-sep">-</span>
                        <asp:TextBox ID="txtMaxPrice" runat="server" CssClass="ss-price-box" Text="1500"></asp:TextBox>
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
                    <asp:Literal ID="litPageTitle" runat="server" Text="All Products"></asp:Literal>
                </h1>
            </header>

            <div class="ss-catalog-grid">
                <asp:Repeater ID="rptProducts" runat="server">
                    <ItemTemplate>
                        <div class="ss-saree-card">
                            <div class="ss-saree-media">
                                <span class="ss-saree-badge"><%# Eval("CategoryName").ToString().ToUpper() %></span>
                                <img src='<%# Eval("MainImage") %>' alt='<%# Eval("ProductName") %>' />
                            </div>
                            <div class="ss-saree-body">
                                <div class="ss-saree-top-row">
                                    <h3 class="ss-saree-name"><%# Eval("ProductName") %></h3>
                                    <span class="ss-saree-price">&#8377;<%# Eval("Price") %></span>
                                </div>
                                <p class="ss-saree-desc"><%# Eval("ProductDescription") %></p>
                                <div class="ss-saree-actions">
                                    <a href='ProductDetail.aspx?id=<%# Eval("ProductID") %>' class="ss-btn-details">Details</a>
                                    <asp:LinkButton ID="btnAdd" runat="server" CssClass="ss-btn-add" OnClick="btnAddToCart_Click" CommandArgument='<%# Eval("ProductID") %>'>
                                        <i class="fa-solid fa-cart-shopping"></i> Add
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

        </section>

    </div>
</asp:Content>