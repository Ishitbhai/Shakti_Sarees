<%@ Page Title="Manage Category" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminCategories.aspx.cs" Inherits="Shakti_Sarees.AdminCategories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHead" runat="server">
    <link href="/Content/AdminCategories.css?v=2" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="ss-cat-viewport">

        <!-- Top Header & Add Category Button -->
        <div class="ss-cat-topbar">
            <div>
                <h1 class="ss-cat-title">Manage Category</h1>
                <p class="ss-cat-subtitle">View, edit, and organize the saree Catrgory.</p>
            </div>
            <a href="AdminAddCategory.aspx" class="ss-btn-add-cat">
                <i class="fa-solid fa-plus"></i> Add Category
            </a>
        </div>

        <!-- Categories Table Card (100% Dynamic from Categories Table) -->
        <div class="ss-cat-card">
            
            <!-- Table Header -->
            <div class="ss-cat-table-head">
                <span class="ss-col-cid">ID</span>
                <span class="ss-col-cname">CATEGORY NAME</span>
                <span class="ss-col-cstatus">STATUS</span>
                <span class="ss-col-cactions">ACTIONS</span>
            </div>

            <asp:Repeater ID="rptCategories" runat="server">
                <ItemTemplate>
                    <div class="ss-cat-row">
                        <span class="ss-col-cid ss-txt-muted">#<%# Eval("CategoryID") %></span>
                        <span class="ss-col-cname ss-txt-dark"><%# Eval("CategoryName") %></span>
                        <div class="ss-col-cstatus">
                            <span class='<%# Eval("Status").ToString() == "Active" ? "ss-badge-active" : "ss-badge-inactive" %>'>
                                <%# Eval("Status").ToString().ToUpper() %>
                            </span>
                        </div>
                        <div class="ss-col-cactions">
                            <a href='AdminEditCategory.aspx?id=<%# Eval("CategoryID") %>' class="ss-cat-action-btn ss-cat-edit" title="Edit">
                                <i class="fa-solid fa-pencil"></i>
                            </a>
                            <asp:LinkButton ID="btnDelete" runat="server" CssClass="ss-cat-action-btn ss-cat-delete"
                                OnClick="btnDelete_Click" CommandArgument='<%# Eval("CategoryID") %>'
                                OnClientClick="return confirm('Are you sure you want to delete this category?');"
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