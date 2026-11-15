<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Shakti_Sarees.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="Content/Home.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="ss-home-container">

        <!-- HERO BANNER -->
        <section class="ss-hero-card">
            <div class="ss-hero-overlay">
                <span class="ss-hero-eyebrow">EVERYDAY ELEGANCE</span>
                <h1 class="ss-hero-title">Pure Cotton Comfort</h1>
                <a href="Products.aspx?category=Cotton" class="ss-hero-btn">
                    Explore Cotton
                </a>
            </div>
        </section>


        <!-- SHOP BY FABRIC -->
        <section class="ss-section">

            <div class="ss-section-header">
                <div>
                    <h2 class="ss-serif-title">Shop by Fabric</h2>
                    <p class="ss-sub-text">
                        Discover our curated selection of authentic weaves.
                    </p>
                </div>

                <a href="Categories.aspx" class="ss-link-all">
                    View All Categories &rarr;
                </a>
            </div>

            <div class="ss-fabric-row">

                <asp:Repeater ID="rptCategories" runat="server">
                    <ItemTemplate>

                        <a href='Products.aspx?category=<%# Eval("CategoryID") %>'
                           class="ss-fabric-item">

                            <div class="ss-fabric-thumb">
                                <img src='<%# Eval("CategoryImage") %>'
                                     alt='<%# Eval("CategoryName") %>' />
                            </div>

                            <span class="ss-fabric-caption">
                                <%# Eval("CategoryName") %>
                            </span>

                        </a>

                    </ItemTemplate>
                </asp:Repeater>

            </div>

        </section>


        <!-- NEW ARRIVALS -->
        <section class="ss-section ss-new-arrivals-section">

            <h2 class="ss-serif-title ss-title-center">
                New Arrivals
            </h2>

            <div class="ss-products-row">

                <asp:Repeater ID="rptNewArrivals" runat="server">
                    <ItemTemplate>

                        <a href='ProductDetail.aspx?id=<%# Eval("ProductID") %>'
                           class="ss-card"
                           style="text-decoration:none; color:inherit;">

                            <div class="ss-card-media">

                                <span class="ss-tag-badge">
                                    <%# Eval("CategoryName").ToString().ToUpper() %>
                                </span>

                                <img src='<%# Eval("MainImage") %>'
                                     alt='<%# Eval("ProductName") %>' />

                            </div>

                            <div class="ss-card-body">

                                <h3 class="ss-card-name">
                                    <%# Eval("ProductName") %>
                                </h3>

                                <p class="ss-card-caption">
                                    <%# Eval("ProductDescription") %>
                                </p>

                                <div class="ss-card-price">
                                    &#8377;<%# Eval("Price") %>
                                </div>

                            </div>

                        </a>

                    </ItemTemplate>
                </asp:Repeater>

            </div>


            <!-- BROWSE ALL PRODUCTS -->
            <div class="ss-browse-action">

                <a href="Products.aspx" class="ss-btn-browse">
                    Browse All Products &rarr;
                </a>

            </div>

        </section>

    </div>

</asp:Content>
