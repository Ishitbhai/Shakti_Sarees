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

        <!-- Users Table Card (100% Dynamic from Users Table) -->
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

            <asp:Repeater ID="rptUsers" runat="server">
                <ItemTemplate>
                    <div class="ss-usr-row">
                        <span class="ss-col-uid ss-txt-uid">USR-<br />#<%# Eval("UserID") %></span>
                        <span class="ss-col-uname ss-txt-name"><%# Eval("FullName") %></span>
                        <span class="ss-col-uemail ss-txt-email"><%# Eval("Email") %></span>
                        <span class="ss-col-umobile ss-txt-mobile">+91 <%# Eval("MobileNumber") %></span>
                        <div class="ss-col-ustatus">
                            <span class='<%# Eval("Status").ToString() == "Active" ? "ss-badge-active-grey" : "ss-badge-inactive-pink" %>'>
                                <%# Eval("Status").ToString().ToUpper() %>
                            </span>
                        </div>
                        <div class="ss-col-uactions">
                            <a href='AdminEditUser.aspx?id=<%# Eval("UserID") %>' class="ss-usr-action-btn ss-usr-edit" title="Edit">
                                <i class="fa-solid fa-pencil"></i>
                            </a>
                            <asp:LinkButton ID="btnDeleteUser" runat="server" CssClass="ss-usr-action-btn ss-usr-delete"
                                OnClick="btnDeleteUser_Click" CommandArgument='<%# Eval("UserID") %>'
                                OnClientClick="return confirm('Are you sure you want to delete this user?');"
                                ToolTip="Delete">
                                <i class="fa-regular fa-trash-can"></i>
                            </asp:LinkButton>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

        </div>

    </div>
</asp:Content>