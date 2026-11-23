<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Shakti_Sarees.About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="<%= ResolveUrl("~/Content/About.css?v=1") %>" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="pnlAboutWrapper" runat="server" Visible="false">
        <div class="ss-about-container">
            
            <!-- ================= TOP: STORY SECTION (100% DYNAMIC FROM PageAbout) ================= -->
            <section class="ss-about-story-row">
                
                <!-- Left Text Content -->
                <div class="ss-story-text-col">
                    <div class="ss-story-eyebrow">
                        <span class="ss-eyebrow-line"></span>
                        <span class="ss-eyebrow-label">ABOUT SHAKTI SAREE</span>
                    </div>

                    <h1 class="ss-story-heading">
                        <asp:Literal ID="litPageTitle" runat="server"></asp:Literal>
                    </h1>

                    <div class="ss-story-body">
                        <asp:Literal ID="litMainStory" runat="server"></asp:Literal>
                    </div>
                </div>

                <!-- Right Image Showcase -->
                <div class="ss-story-media-col">
                    <div class="ss-story-image-wrap">
                        <asp:Image ID="imgHero" runat="server" AlternateText="About Shakti Saree" />
                    </div>
                </div>

            </section>

        </div>

        <!-- ================= BOTTOM: THE SHAKTI PROMISE (FULL WIDTH) ================= -->
        <section class="ss-promise-banner">
            <div class="ss-promise-content">
                
                <h2 class="ss-promise-title">The Shakti Promise</h2>
                <p class="ss-promise-intro">
                    We believe that true luxury lies in trust. Every piece in our collection is backed by our commitment to authenticity and exceptional service.
                </p>

                <div class="ss-promise-features">
                    
                    <!-- Feature 1 -->
                    <div class="ss-feature-item">
                        <div class="ss-feature-icon-box">
                            <asp:Literal ID="litFeature1Icon" runat="server"></asp:Literal>
                        </div>
                        <h3 class="ss-feature-title">
                            <asp:Literal ID="litFeature1Heading" runat="server"></asp:Literal>
                        </h3>
                        <p class="ss-feature-desc">
                            <asp:Literal ID="litFeature1Desc" runat="server"></asp:Literal>
                        </p>
                    </div>

                    <!-- Feature 2 -->
                    <div class="ss-feature-item">
                        <div class="ss-feature-icon-box">
                            <asp:Literal ID="litFeature2Icon" runat="server"></asp:Literal>
                        </div>
                        <h3 class="ss-feature-title">
                            <asp:Literal ID="litFeature2Heading" runat="server"></asp:Literal>
                        </h3>
                        <p class="ss-feature-desc">
                            <asp:Literal ID="litFeature2Desc" runat="server"></asp:Literal>
                        </p>
                    </div>

                </div>

            </div>
        </section>
    </asp:Panel>
</asp:Content>