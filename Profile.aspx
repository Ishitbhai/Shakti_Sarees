<%@ Page Title="My Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Shakti_Sarees.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="<%= ResolveUrl("~/Content/Profile.css?v=1") %>" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="ss-profile-viewport">

        <!-- 1. Top Summary Card -->
        <div class="ss-profile-card">
            
            <h1 class="ss-prof-name">
                <asp:Literal ID="litFullName" runat="server" Text="Ishit Vadhavana"></asp:Literal>
            </h1>

            <div class="ss-prof-email-row">
                <i class="fa-regular fa-envelope ss-email-icon"></i>
                <asp:Literal ID="litEmail" runat="server" Text="ishit@gmail.com"></asp:Literal>
            </div>

            <div class="ss-prof-info-grid">
                <!-- Mobile Box -->
                <div class="ss-info-pill">
                    <div class="ss-info-badge">
                        <i class="fa-solid fa-phone"></i>
                    </div>
                    <div class="ss-info-text">
                        <span class="ss-info-label">MOBILE</span>
                        <span class="ss-info-val">
                            <asp:Literal ID="litMobile" runat="server" Text="+91 84600 65647"></asp:Literal>
                        </span>
                    </div>
                </div>

                <!-- Primary Address Box -->
                <div class="ss-info-pill">
                    <div class="ss-info-badge">
                        <i class="fa-solid fa-location-dot"></i>
                    </div>
                    <div class="ss-info-text">
                        <span class="ss-info-label">PRIMARY ADDRESS</span>
                        <span class="ss-info-val">
                            <asp:Literal ID="litAddress" runat="server" Text="Rajkot, 360005"></asp:Literal>
                        </span>
                    </div>
                </div>
            </div>

        </div>

        <!-- 2. Bottom Actions Card -->
        <div class="ss-profile-card ss-actions-card">
            
            <span class="ss-actions-heading">ACCOUNT ACTIONS</span>

            <div class="ss-actions-list">
                <!-- Edit Profile -->
                <a href="EditProfile.aspx" class="ss-action-row">
                    <div class="ss-action-left">
                        <i class="fa-solid fa-pen ss-action-icon"></i>
                        <span>Edit Profile</span>
                    </div>
                    <i class="fa-solid fa-chevron-right ss-action-chevron"></i>
                </a>

                <!-- Change Password -->
                <a href="ChangePassword.aspx" class="ss-action-row">
                    <div class="ss-action-left">
                        <i class="fa-solid fa-lock ss-action-icon"></i>
                        <span>Change Password</span>
                    </div>
                    <i class="fa-solid fa-chevron-right ss-action-chevron"></i>
                </a>

                <!-- Order History -->
                <a href="Orders.aspx" class="ss-action-row">
                    <div class="ss-action-left">
                        <i class="fa-solid fa-clock-rotate-left ss-action-icon"></i>
                        <span>Order History</span>
                    </div>
                    <i class="fa-solid fa-chevron-right ss-action-chevron"></i>
                </a>
            </div>

            <!-- Logout Button -->
            <asp:LinkButton ID="btnLogout" runat="server" CssClass="ss-logout-btn" OnClick="btnLogout_Click">
                <i class="fa-solid fa-arrow-right-from-bracket"></i> Logout
            </asp:LinkButton>

        </div>

    </div>
</asp:Content>