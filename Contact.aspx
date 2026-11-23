<%@ Page Title="Contact Us" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Shakti_Sarees.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="<%= ResolveUrl("~/Content/Contact.css?v=1") %>" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="pnlContactWrapper" runat="server" Visible="false">
        <div class="ss-contact-viewport">

            <!-- Header Introduction (100% Dynamic from PageContact) -->
            <header class="ss-contact-header">
                <div class="ss-contact-eyebrow">
                    <span class="ss-contact-eyebrow-line"></span>
                    <span class="ss-contact-eyebrow-text">CONNECT WITH US</span>
                </div>

                <h1 class="ss-contact-title">
                    <asp:Literal ID="litPageTitle" runat="server"></asp:Literal>
                </h1>

                <p class="ss-contact-desc">
                    <asp:Literal ID="litMainStory" runat="server"></asp:Literal>
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
                    <asp:Literal ID="litAddress" runat="server"></asp:Literal>
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
                            <asp:HyperLink ID="hlPhone" runat="server" CssClass="ss-channel-val"></asp:HyperLink>
                        </div>
                    </div>

                    <!-- Email -->
                    <div class="ss-channel-row">
                        <div class="ss-channel-icon">
                            <i class="fa-solid fa-envelope"></i>
                        </div>
                        <div class="ss-channel-info">
                            <span class="ss-channel-lbl">EMAIL</span>
                            <asp:HyperLink ID="hlEmail" runat="server" CssClass="ss-channel-val"></asp:HyperLink>
                        </div>
                    </div>

                    <!-- Business Hours -->
                    <div class="ss-channel-row">
                        <div class="ss-channel-icon">
                            <i class="fa-regular fa-clock"></i>
                        </div>
                        <div class="ss-channel-info">
                            <span class="ss-channel-lbl">BUSINESS HOURS</span>
                            <asp:Literal ID="litBusinessHours" runat="server"></asp:Literal>
                        </div>
                    </div>

                </div>

            </div>

        </div>
    </asp:Panel>
</asp:Content>