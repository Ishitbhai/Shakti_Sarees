<%@ Page Title="Explore Collection" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Categories.aspx.cs" Inherits="Shakti_Sarees.Categories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="<%= ResolveUrl("~/Content/Categories.css?v=1") %>" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="ss-collection-container">
        
        <!-- Header Introduction -->
        <header class="ss-collection-header">
            <h1 class="ss-col-title">Explore Our Collection</h1>
            <p class="ss-col-subtitle">
                Discover handcrafted sarees woven with tradition and elegance, curated for every occasion and style.
            </p>
        </header>

        <!-- 4-Column Collection Grid -->
        <div class="ss-col-grid">
            
            <!-- Card 1: Banarasi Silk -->
            <a href="Products.aspx?category=Banarasi" class="ss-item-card">
                <div class="ss-item-media">
                    <span class="ss-item-badge">BANARASI SILK</span>
                    <img src="/images/categories_banarasi_silk.png" alt="Royal Purple Banarasi" />
                </div>
                <div class="ss-item-details">
                    <div class="ss-item-info">
                        <h3 class="ss-item-name">Royal Purple</h3>
                        <span class="ss-item-sub">Banarasi Silk...</span>
                    </div>
                    <div class="ss-item-price">&#8377; 12,499</div>
                </div>
            </a>

            <!-- Card 2: Chiffon -->
            <a href="Products.aspx?category=Chiffon" class="ss-item-card">
                <div class="ss-item-media">
                    <span class="ss-item-badge">CHIFFON</span>
                    <img src="/images/categories_chiffon.png" alt="Blush Pink Evening" />
                </div>
                <div class="ss-item-details">
                    <div class="ss-item-info">
                        <h3 class="ss-item-name">Blush Pink Evening</h3>
                        <span class="ss-item-sub">Chiffon</span>
                    </div>
                    <div class="ss-item-price">&#8377; 4,299</div>
                </div>
            </a>

            <!-- Card 3: Cotton -->
            <a href="Products.aspx?category=Cotton" class="ss-item-card">
                <div class="ss-item-media">
                    <span class="ss-item-badge">COTTON</span>
                    <img src="/images/categories_cotton.png" alt="Terracotta Block Print" />
                </div>
                <div class="ss-item-details">
                    <div class="ss-item-info">
                        <h3 class="ss-item-name">Terracotta Block Print</h3>
                        <span class="ss-item-sub">Cotton</span>
                    </div>
                    <div class="ss-item-price">&#8377; 2,150</div>
                </div>
            </a>

            <!-- Card 4: Kanchipuram Grand -->
            <a href="Products.aspx?category=Kanchipuram" class="ss-item-card">
                <div class="ss-item-media">
                    <span class="ss-item-badge">KANCHIPURAM GRAND</span>
                    <img src="/images/categories_kanchipuram_grand.png" alt="Deep Maroon Kanchipuram" />
                </div>
                <div class="ss-item-details">
                    <div class="ss-item-info">
                        <h3 class="ss-item-name">Deep Maroon</h3>
                        <span class="ss-item-sub">Kanchipuram Grand</span>
                    </div>
                    <div class="ss-item-price">&#8377; 18,900</div>
                </div>
            </a>

            <!-- Card 5: Zari / Linen -->
            <a href="Products.aspx?category=Zari" class="ss-item-card">
                <div class="ss-item-media">
                    <span class="ss-item-badge">ZARI</span>
                    <img src="/images/categories_golden_glow_linen.png" alt="Golden Glow Linen Zari" />
                </div>
                <div class="ss-item-details">
                    <div class="ss-item-info">
                        <h3 class="ss-item-name">Golden Glow Linen</h3>
                        <span class="ss-item-sub">Zari</span>
                    </div>
                    <div class="ss-item-price">&#8377; 3,450</div>
                </div>
            </a>

            <!-- Card 6: Georgette -->
            <a href="Products.aspx?category=Georgette" class="ss-item-card">
                <div class="ss-item-media">
                    <span class="ss-item-badge">GEORGETTE</span>
                    <img src="/images/categories_georgette.png" alt="Cream Kashmiri Georgette" />
                </div>
                <div class="ss-item-details">
                    <div class="ss-item-info">
                        <h3 class="ss-item-name">Cream Kashmiri</h3>
                        <span class="ss-item-sub">Georgette</span>
                    </div>
                    <div class="ss-item-price">&#8377; 8,999</div>
                </div>
            </a>

        </div>
    </div>
</asp:Content>