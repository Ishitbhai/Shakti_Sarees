<%@ Page Title="Product Details" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductDetail.aspx.cs" Inherits="Shakti_Sarees.ProductDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="<%= ResolveUrl("~/Content/ProductDetail.css?v=1") %>" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="ss-detail-wrapper">

        <!-- ================= TOP: PRODUCT SHOWCASE ================= -->
        <div class="ss-product-showcase">
            
            <!-- Left: Gallery Media -->
            <div class="ss-gallery-col">
                <div class="ss-main-media">
                    <img id="imgMainPreview" src="/images/single_product_main.png" alt="Midnight Orchid Heritage Saree" />
                </div>
                
                <!-- Thumbnails -->
                <div class="ss-thumbnail-strip">
                    <div class="ss-thumb ss-thumb-active">
                        <img src="/images/single_product_1.png" alt="Detail 1" />
                    </div>
                    <div class="ss-thumb">
                        <img src="/images/single_product_2.png" alt="Detail 2" />
                    </div>
                    <div class="ss-thumb">
                        <img src="/images/single_product_3.png" alt="Detail 3" />
                    </div>
                    <div class="ss-thumb">
                        <img src="/images/single_product_2.png" alt="Detail 4" />
                    </div>
                </div>
            </div>

            <!-- Right: Product Information & Purchase Box -->
            <div class="ss-info-col">
                <h1 class="ss-detail-title">
                    <asp:Literal ID="litTitle" runat="server" Text="Midnight Orchid Heritage Saree"></asp:Literal>
                </h1>
                
                <div class="ss-detail-price">
                    <asp:Literal ID="litPrice" runat="server" Text="&#8377;14,500"></asp:Literal>
                </div>

                <div class="ss-detail-paragraphs">
                    <p>
                        Woven in the spiritual heart of Varanasi, this Midnight Orchid Banarasi silk saree is a masterpiece of textile art. The rich, royal purple base is meticulously adorned with pure golden zari work, featuring classic 'jangla' floral vines spanning the entire body.
                    </p>
                    <p>
                        Perfect for weddings and grand evening affairs, it drapes with a weighty elegance that only genuine heritage silk can provide. Comes with a matching unstitched blouse piece.
                    </p>
                </div>

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

        <!-- ================= BOTTOM: NEW ARRIVALS RECOMMENDATIONS ================= -->
        <section class="ss-recommendations">
            <h2 class="ss-rec-heading">New Arrivals</h2>

            <div class="ss-rec-grid">
                
                <!-- Rec 1 -->
                <div class="ss-rec-card">
                    <div class="ss-rec-media">
                        <span class="ss-rec-badge">SILK</span>
                        <img src="/images/single_product_new_1.png" alt="Royal Purple" />
                    </div>
                    <div class="ss-rec-body">
                        <h4 class="ss-rec-title">Royal Purple...</h4>
                        <p class="ss-rec-desc">Authentic handloom with gold zari.</p>
                        <span class="ss-rec-price">&#8377;14,500</span>
                    </div>
                </div>

                <!-- Rec 2 -->
                <div class="ss-rec-card">
                    <div class="ss-rec-media">
                        <span class="ss-rec-badge">CHIFFON</span>
                        <img src="/images/single_product_new_2.png" alt="Cream Floral" />
                    </div>
                    <div class="ss-rec-body">
                        <h4 class="ss-rec-title">Cream Floral...</h4>
                        <p class="ss-rec-desc">Lightweight elegance for evenings.</p>
                        <span class="ss-rec-price">&#8377;4,200</span>
                    </div>
                </div>

                <!-- Rec 3 -->
                <div class="ss-rec-card">
                    <div class="ss-rec-media">
                        <span class="ss-rec-badge">COTTON</span>
                        <img src="/images/single_product_new_3.png" alt="Sunshine Block" />
                    </div>
                    <div class="ss-rec-body">
                        <h4 class="ss-rec-title">Sunshine Block</h4>
                        <p class="ss-rec-desc">Breathable everyday wear.</p>
                        <span class="ss-rec-price">&#8377;1,850</span>
                    </div>
                </div>

                <!-- Rec 4 -->
                <div class="ss-rec-card">
                    <div class="ss-rec-media">
                        <span class="ss-rec-badge">GEORGETTE</span>
                        <img src="/images/single_product_new_4.png" alt="Midnight Maroon" />
                    </div>
                    <div class="ss-rec-body">
                        <h4 class="ss-rec-title">Midnight Maroon...</h4>
                        <p class="ss-rec-desc">Fluid drape for party wear.</p>
                        <span class="ss-rec-price">&#8377;6,500</span>
                    </div>
                </div>

            </div>
        </section>

    </div>
</asp:Content>