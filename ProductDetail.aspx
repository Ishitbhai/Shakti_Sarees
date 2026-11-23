<%@ Page Title="Product Details" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductDetail.aspx.cs" Inherits="Shakti_Sarees.ProductDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="<%= ResolveUrl("~/Content/ProductDetail.css?v=1") %>" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="ss-detail-wrapper">

        <!-- ================= TOP: PRODUCT SHOWCASE ================= -->
        <div class="ss-product-showcase">
            
            <!-- Left: Gallery Media (100% Dynamic) -->
            <div class="ss-gallery-col">
                <div class="ss-main-media">
                    <asp:Image ID="imgMainPreview" runat="server" AlternateText="Product Preview" />
                </div>
                
                <!-- Dynamic Thumbnails from ExtraImage1..ExtraImage4 -->
                <div class="ss-thumbnail-strip">
                    <asp:Repeater ID="rptThumbnails" runat="server">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnThumb" runat="server" CssClass="ss-thumb" OnClick="btnThumb_Click" CommandArgument='<%# Container.DataItem %>'>
                                <img src='<%# Container.DataItem %>' alt="Thumbnail" />
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <!-- Right: Product Information & Purchase Box -->
            <div class="ss-info-col">
                <h1 class="ss-detail-title">
                    <asp:Literal ID="litTitle" runat="server"></asp:Literal>
                </h1>
                
                <div class="ss-detail-price">
                    <asp:Literal ID="litPrice" runat="server"></asp:Literal>
                </div>

                <div class="ss-detail-paragraphs">
                    <p>
                        <asp:Literal ID="litDescription" runat="server"></asp:Literal>
                    </p>
                </div>

                <!-- Feedback / Stock Message -->
                <asp:Label ID="lblStockMsg" runat="server" CssClass="ss-val-text" Visible="false" style="display:block; margin-bottom:10px; color:#8C0D1B; font-weight:600;"></asp:Label>

                <!-- Purchase Card Box -->
                <div class="ss-buy-box">
                    <span class="ss-qty-label">Quantity</span>
                    
                    <div class="ss-qty-selector">
                        <asp:Button ID="btnQtyMinus" runat="server" Text="&minus;" CssClass="ss-qty-btn" OnClick="btnQtyMinus_Click" />
                        <asp:TextBox ID="txtQuantity" runat="server" Text="1" CssClass="ss-qty-value" ReadOnly="true"></asp:TextBox>
                        <asp:Button ID="btnQtyPlus" runat="server" Text="+" CssClass="ss-qty-btn" OnClick="btnQtyPlus_Click" />
                    </div>

                    <div class="ss-cta-row">
                        <asp:LinkButton ID="btnAddToCart" runat="server" CssClass="ss-btn-cart-outline" OnClick="btnAddToCart_Click">
                            <i class="fa-solid fa-cart-shopping"></i> ADD TO CART
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnBuyNow" runat="server" CssClass="ss-btn-buy-solid" OnClick="btnBuyNow_Click">
                            <i class="fa-solid fa-bolt"></i> BUY NOW
                        </asp:LinkButton>
                    </div>
                </div>

            </div>
        </div>

        <!-- ================= BOTTOM: NEW ARRIVALS RECOMMENDATIONS (100% DYNAMIC) ================= -->
        <section class="ss-recommendations">
            <h2 class="ss-rec-heading">New Arrivals</h2>

            <div class="ss-rec-grid">
                <asp:Repeater ID="rptRecommendations" runat="server">
                    <ItemTemplate>
                        <a href='ProductDetail.aspx?id=<%# Eval("ProductID") %>' class="ss-rec-card" style="text-decoration:none; color:inherit;">
                            <div class="ss-rec-media">
                                <span class="ss-rec-badge"><%# Eval("CategoryName").ToString().ToUpper() %></span>
                                <img src='<%# Eval("MainImage") %>' alt='<%# Eval("ProductName") %>' />
                            </div>
                            <div class="ss-rec-body">
                                <h4 class="ss-rec-title"><%# Eval("ProductName") %></h4>
                                <p class="ss-rec-desc"><%# Eval("ProductDescription") %></p>
                                <span class="ss-rec-price">&#8377;<%# Eval("Price") %></span>
                            </div>
                        </a>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </section>

    </div>
</asp:Content>