<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Shakti_Sarees.About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="<%= ResolveUrl("~/Content/About.css?v=1") %>" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="ss-about-container">
        
        <!-- ================= TOP: STORY SECTION ================= -->
        <section class="ss-about-story-row">
            
            <!-- Left Text Content -->
            <div class="ss-story-text-col">
                <div class="ss-story-eyebrow">
                    <span class="ss-eyebrow-line"></span>
                    <span class="ss-eyebrow-label">ABOUT SHAKTI SAREE</span>
                </div>

                <h1 class="ss-story-heading">
                    Elegance<br />in Every Thread
                </h1>

                <div class="ss-story-body">
                    <p class="ss-story-lead">
                        <span class="ss-drop-cap">F</span>or over three decades, Shakti Saree has been the custodian of India's rich textile heritage. We don't merely sell garments; we curate stories woven by master artisans across the subcontinent.
                    </p>
                    <p>
                        From the royal, intricate looms of Banaras to the delicate, breathable craft of fine handloom cottons, our collection is a testament to accessible elegance. We bridge the gap between traditional craftsmanship and modern sensibilities, ensuring every piece you wear is a masterpiece of uncompromising quality.
                    </p>
                </div>
            </div>

            <!-- Right Image Showcase -->
            <div class="ss-story-media-col">
                <div class="ss-story-image-wrap">
                    <img src="/images/about.png" alt="Elegance in Every Thread - Shakti Saree" />
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
                
                <!-- Feature 1: Quality -->
                <div class="ss-feature-item">
                    <div class="ss-feature-icon-box">
                        <i class="fa-regular fa-gem"></i>
                    </div>
                    <h3 class="ss-feature-title">Uncompromising Quality</h3>
                    <p class="ss-feature-desc">
                        Each saree undergoes a rigorous multi-point inspection process to ensure the fabric, zari, and finish meet boutique standards.
                    </p>
                </div>

                <!-- Feature 2: Delivery -->
                <div class="ss-feature-item">
                    <div class="ss-feature-icon-box">
                        <i class="fa-solid fa-truck"></i>
                    </div>
                    <h3 class="ss-feature-title">Seamless Delivery</h3>
                    <p class="ss-feature-desc">
                        From our showroom to your doorstep, we provide secure, fully insured shipping with transparent tracking worldwide.
                    </p>
                </div>

            </div>

        </div>
    </section>
</asp:Content>