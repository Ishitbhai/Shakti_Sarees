<%@ Page Title="Manage Users" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminUsers.aspx.cs" Inherits="Shakti_Sarees.AdminUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHead" runat="server">
    <link href="/Content/AdminUsers.css?v=1" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="ss-usr-viewport">

        <!-- Top Header & Add User Action -->
        <div class="ss-usr-topbar">
            <div>
                <h1 class="ss-usr-title">Manage Users</h1>
                <p class="ss-usr-subtitle">View, edit, and manage Customer</p>
            </div>
            <a href="AdminAddUser.aspx" class="ss-btn-add-user">
                <i class="fa-solid fa-plus"></i> Add User
            </a>
        </div>

        <!-- Users Table Card -->
        <div class="ss-usr-card">

            <!-- Table Header Row -->
            <div class="ss-usr-table-head">
                <span class="ss-col-uid">USER ID</span>
                <span class="ss-col-uname">NAME</span>
                <span class="ss-col-uemail">EMAIL</span>
                <span class="ss-col-umobile">MOBILE</span>
                <span class="ss-col-ustatus">STATUS</span>
                <span class="ss-col-uactions">ACTIONS</span>
            </div>

            <!-- Row 1: Vadhavana Ishit -->
            <div class="ss-usr-row">
                <span class="ss-col-uid ss-txt-uid">USR-<br />8892</span>
                <span class="ss-col-uname ss-txt-name">Vadhavana Ishit</span>
                <span class="ss-col-uemail ss-txt-email">ishit@gmail.com</span>
                <span class="ss-col-umobile ss-txt-mobile">+91 8460065647</span>
                <div class="ss-col-ustatus">
                    <span class="ss-badge-active-grey">ACTIVE</span>
                </div>
                <div class="ss-col-uactions">
                    <a href="AdminEditUser.aspx?id=8892" class="ss-usr-action-btn ss-usr-edit" title="Edit">
                        <i class="fa-solid fa-pencil"></i>
                    </a>
                    <a href="javascript:void(0);" class="ss-usr-action-btn ss-usr-delete"
                       onclick="confirm('Are you sure you want to delete this user?'); return false;"
                       title="Delete">
                        <i class="fa-regular fa-trash-can"></i>
                    </a>
                </div>
            </div>

            <!-- Row 2: Vadhavana Smit -->
            <div class="ss-usr-row">
                <span class="ss-col-uid ss-txt-uid">USR-<br />8892</span>
                <span class="ss-col-uname ss-txt-name">Vadhavana Smit</span>
                <span class="ss-col-uemail ss-txt-email">smit@gmail.com</span>
                <span class="ss-col-umobile ss-txt-mobile">+91 94097 56523</span>
                <div class="ss-col-ustatus">
                    <span class="ss-badge-active-grey">ACTIVE</span>
                </div>
                <div class="ss-col-uactions">
                    <a href="AdminEditUser.aspx?id=8892" class="ss-usr-action-btn ss-usr-edit" title="Edit">
                        <i class="fa-solid fa-pencil"></i>
                    </a>
                    <a href="javascript:void(0);" class="ss-usr-action-btn ss-usr-delete"
                       onclick="confirm('Are you sure you want to delete this user?'); return false;"
                       title="Delete">
                        <i class="fa-regular fa-trash-can"></i>
                    </a>
                </div>
            </div>

            <!-- Row 3: Makvana Hiren -->
            <div class="ss-usr-row">
                <span class="ss-col-uid ss-txt-uid">USR-<br />8892</span>
                <span class="ss-col-uname ss-txt-name">Makvana Hiren</span>
                <span class="ss-col-uemail ss-txt-email">hiren@gmail.com</span>
                <span class="ss-col-umobile ss-txt-mobile">+91 98756 26486</span>
                <div class="ss-col-ustatus">
                    <span class="ss-badge-inactive-pink">INACTIVE</span>
                </div>
                <div class="ss-col-uactions">
                    <a href="AdminEditUser.aspx?id=8892" class="ss-usr-action-btn ss-usr-edit" title="Edit">
                        <i class="fa-solid fa-pencil"></i>
                    </a>
                    <a href="javascript:void(0);" class="ss-usr-action-btn ss-usr-delete"
                       onclick="confirm('Are you sure you want to delete this user?'); return false;"
                       title="Delete">
                        <i class="fa-regular fa-trash-can"></i>
                    </a>
                </div>
            </div>

            <!-- Row 4: Limbad Duval -->
            <div class="ss-usr-row">
                <span class="ss-col-uid ss-txt-uid">USR-<br />8892</span>
                <span class="ss-col-uname ss-txt-name">Limbad Duval</span>
                <span class="ss-col-uemail ss-txt-email">dhruval@gmail.com</span>
                <span class="ss-col-umobile ss-txt-mobile">+91 97235 56457</span>
                <div class="ss-col-ustatus">
                    <span class="ss-badge-active-grey">ACTIVE</span>
                </div>
                <div class="ss-col-uactions">
                    <a href="AdminEditUser.aspx?id=8892" class="ss-usr-action-btn ss-usr-edit" title="Edit">
                        <i class="fa-solid fa-pencil"></i>
                    </a>
                    <a href="javascript:void(0);" class="ss-usr-action-btn ss-usr-delete"
                       onclick="confirm('Are you sure you want to delete this user?'); return false;"
                       title="Delete">
                        <i class="fa-regular fa-trash-can"></i>
                    </a>
                </div>
            </div>

        </div>

    </div>
</asp:Content>