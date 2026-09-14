<%@ Page Title="Contact Us" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Shakti_Sarees.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="<%= ResolveUrl("~/Content/Contact.css?v=1") %>" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="ss-contact-viewport">

        <!-- Header Introduction -->
        <header class="ss-contact-header">
            <div class="ss-contact-eyebrow">
                <span class="ss-contact-eyebrow-line"></span>
                <span class="ss-contact-eyebrow-text">CONNECT WITH US</span>
            </div>

            <h1 class="ss-contact-title">
                Let's weave something <br />
                <span class="ss-contact-highlight">beautiful together.</span>
            </h1>

            <p class="ss-contact-desc">
                Whether you're looking for a specific heritage weave, have a question about our collections, or need assistance with a bespoke order, our team is here with traditional warmth and modern efficiency.
            </p>
        </header>

        <!-- Flagship Store Information Card -->
        <div class="ss-store-card">
            
            <!-- Store Category Pill -->
            <div class="ss-store-badge">
                <i class="fa-solid fa-store ss-badge-icon"></i>
                <span>FLAGSHIP STORE</span>
            </div>

            <!-- Address Block -->
            <div class="ss-store-address">
                <p>Tapeshwar Mandir Road,</p>
                <p>Satta Bazar,</p>
                <p>Veraval, Gujarat - 362265, India</p>
            </div>

            <!-- Contact Channels -->
            <div class="ss-store-channels">
                
                <!-- Phone -->
                <div class="ss-channel-row">
                    <div class="ss-channel-icon">
                        <i class="fa-solid fa-phone"></i>
                    </div>
                    <div class="ss-channel-info">
                        <span class="ss-channel-lbl">PHONE</span>
                        <a href="tel:+918460065647" class="ss-channel-val">+91 84600 65647</a>
                    </div>
                </div>

                <!-- Email -->
                <div class="ss-channel-row">
                    <div class="ss-channel-icon">
                        <i class="fa-solid fa-envelope"></i>
                    </div>
                    <div class="ss-channel-info">
                        <span class="ss-channel-lbl">EMAIL</span>
                        <a href="mailto:ishitvadhavana@gmail.com" class="ss-channel-val">ishitvadhavana@gmail.com</a>
                    </div>
                </div>

                <!-- Business Hours -->
                <div class="ss-channel-row">
                    <div class="ss-channel-icon">
                        <i class="fa-regular fa-clock"></i>
                    </div>
                    <div class="ss-channel-info">
                        <span class="ss-channel-lbl">BUSINESS HOURS</span>
                        <span class="ss-channel-val">Mon - Sat: 10:00 AM - 8:00 PM</span>
                        <span class="ss-channel-sub">Sunday: Closed</span>
                    </div>
                </div>

            </div>

        </div>

    </div>
</asp:Content>