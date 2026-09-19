<%@ Page Title="Admin Profile" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminProfile.aspx.cs" Inherits="Shakti_Sarees.AdminProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHead" runat="server">
    <link href="/Content/AdminProfile.css?v=1" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="ss-prof-viewport">

        <!-- Page Header -->
        <div class="ss-prof-header">
            <h1 class="ss-prof-title">Admin Profile</h1>
            <p class="ss-prof-subtitle">Manage your personal information and administrative access.</p>
        </div>

        <!-- Card 1: Identity & Contact Info -->
        <div class="ss-prof-card">
            <!-- Name and Email Header -->
            <div class="ss-prof-meta">
                <h2 class="ss-prof-name">Ishit Vadhavana</h2>
                <div class="ss-prof-email">
                    <i class="fa-regular fa-envelope ss-icon-maroon"></i>
                    <span>ishit@gmail.com</span>
                </div>
            </div>

            <!-- Detail Mini Cards -->
            <div class="ss-prof-detail-grid">
                <!-- Mobile Box -->
                <div class="ss-prof-detail-box">
                    <div class="ss-box-icon-wrap">
                        <i class="fa-solid fa-phone ss-icon-maroon"></i>
                    </div>
                    <div class="ss-box-text">
                        <span class="ss-box-lbl">MOBILE</span>
                        <span class="ss-box-val">+91 84600 65647</span>
                    </div>
                </div>

                <!-- Primary Address Box -->
                <div class="ss-prof-detail-box">
                    <div class="ss-box-icon-wrap">
                        <i class="fa-solid fa-location-dot ss-icon-maroon"></i>
                    </div>
                    <div class="ss-box-text">
                        <span class="ss-box-lbl">PRIMARY ADDRESS</span>
                        <span class="ss-box-val">Rajkot, 360005</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Card 2: Account Actions -->
        <div class="ss-prof-card ss-prof-actions-card">
            <span class="ss-action-card-lbl">ACCOUNT ACTIONS</span>

            <div class="ss-action-links-list">
                <!-- Edit Profile Button -->
                <a href="AdminEditProfile.aspx" class="ss-action-row">
                    <div class="ss-action-left">
                        <i class="fa-solid fa-pencil"></i>
                        <span>Edit Profile</span>
                    </div>
                    <i class="fa-solid fa-angle-right ss-arrow-icon"></i>
                </a>

                <!-- Change Password Button -->
                <a href="AdminChangePassword.aspx" class="ss-action-row">
                    <div class="ss-action-left">
                        <i class="fa-solid fa-lock"></i>
                        <span>Change Password</span>
                    </div>
                    <i class="fa-solid fa-angle-right ss-arrow-icon"></i>
                </a>
            </div>
        </div>

    </div>
</asp:Content>