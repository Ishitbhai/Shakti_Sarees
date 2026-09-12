<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Shakti_Sarees.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="Content/Home.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="ss-home-container">
        
        <!-- ================= HERO BANNER ================= -->
        <section class="ss-hero-card">
            <div class="ss-hero-overlay">
                <span class="ss-hero-eyebrow">EVERYDAY ELEGANCE</span>
                <h1 class="ss-hero-title">Pure Cotton Comfort</h1>
                <a href="home_main.png" class="ss-hero-btn">Explore Cotton</a>
            </div>
        </section>

        <!-- ================= SHOP BY FABRIC ================= -->
        <section class="ss-section">
            <div class="ss-section-header">
                <div>
                    <h2 class="ss-serif-title">Shop by Fabric</h2>
                    <p class="ss-sub-text">Discover our curated selection of authentic weaves.</p>
                </div>
                <a href="Products.aspx" class="ss-link-all">View All Categories &rarr;</a>
            </div>

            <div class="ss-fabric-row">
                <!-- 1. Silk -->
                <a href="Products.aspx?category=Silk" class="ss-fabric-item">
                    <div class="ss-fabric-thumb">
                        <img src="/images/home_silk.png" alt="Silk" />
                    </div>
                    <span class="ss-fabric-caption">Silk</span>
                </a>

                <!-- 2. Chiffon -->
                <a href="Products.aspx?category=Chiffon" class="ss-fabric-item">
                    <div class="ss-fabric-thumb">
                        <img src="/images/home_chiffon.png" alt="Chiffon" />
                    </div>
                    <span class="ss-fabric-caption">Chiffon</span>
                </a>

                <!-- 3. Cotton -->
                <a href="Products.aspx?category=Cotton" class="ss-fabric-item">
                    <div class="ss-fabric-thumb">
                        <img src="/images/home_cotton.png" alt="Cotton" />
                    </div>
                    <span class="ss-fabric-caption">Cotton</span>
                </a>

                <!-- 4. Bandhani -->
                <a href="Products.aspx?category=Bandhani" class="ss-fabric-item">
                    <div class="ss-fabric-thumb">
                        <img src="/images/home_bandhani.png" alt="Bandhani" />
                    </div>
                    <span class="ss-fabric-caption">Bandhani</span>
                </a>
            </div>
        </section>

        <!-- ================= NEW ARRIVALS ================= -->
        <section class="ss-section ss-new-arrivals-section">
            <h2 class="ss-serif-title ss-title-center">New Arrivals</h2>

            <div class="ss-products-row">
                <!-- Product 1: Royal Purple -->
                <div class="ss-card">
                    <div class="ss-card-media">
                        <span class="ss-tag-badge">SILK</span>
                        <img src="/images/home_royal_purple.png" alt="Royal Purple" />
                    </div>
                    <div class="ss-card-body">
                        <h3 class="ss-card-name">Royal Purple...</h3>
                        <p class="ss-card-caption">Authentic handloom with gold zari.</p>
                        <div class="ss-card-price">&#8377;14,500</div>
                    </div>
                </div>

                <!-- Product 2: Cream Floral -->
                <div class="ss-card">
                    <div class="ss-card-media">
                        <span class="ss-tag-badge">CHIFFON</span>
                        <img src="/images/home_cream_floral.png" alt="Cream Floral" />
                    </div>
                    <div class="ss-card-body">
                        <h3 class="ss-card-name">Cream Floral...</h3>
                        <p class="ss-card-caption">Lightweight elegance for evenings.</p>
                        <div class="ss-card-price">&#8377;4,200</div>
                    </div>
                </div>

                <!-- Product 3: Sunshine Block -->
                <div class="ss-card">
                    <div class="ss-card-media">
                        <span class="ss-tag-badge">COTTON</span>
                        <img src="/images/home_sunshine_block.png" alt="Sunshine Block" />
                    </div>
                    <div class="ss-card-body">
                        <h3 class="ss-card-name">Sunshine Block ...</h3>
                        <p class="ss-card-caption">Breathable everyday wear.</p>
                        <div class="ss-card-price">&#8377;1,850</div>
                    </div>
                </div>

                <!-- Product 4: Midnight Maroon -->
                <div class="ss-card">
                    <div class="ss-card-media">
                        <span class="ss-tag-badge">GEORGETTE</span>
                        <img src="/images/home_midnight_maroon.png" alt="Midnight Maroon" />
                    </div>
                    <div class="ss-card-body">
                        <h3 class="ss-card-name">Midnight Maroon...</h3>
                        <p class="ss-card-caption">Fluid drape for party wear.</p>
                        <div class="ss-card-price">&#8377;6,500</div>
                    </div>
                </div>
            </div>

            <!-- Centered Browse All Products Button -->
            <div class="ss-browse-action">
                <a href="Products.aspx" class="ss-btn-browse">Browse All Products &rarr;</a>
            </div>
        </section>

    </div>
</asp:Content>