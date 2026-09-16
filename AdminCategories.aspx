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

        <!-- Categories Table Card -->
        <div class="ss-cat-card">
            
            <!-- Table Header -->
            <div class="ss-cat-table-head">
                <span class="ss-col-cid">ID</span>
                <span class="ss-col-cname">CATEGORY NAME</span>
                <span class="ss-col-cstatus">STATUS</span>
                <span class="ss-col-cactions">ACTIONS</span>
            </div>

            <!-- Row 1: Banarasi Silk -->
            <div class="ss-cat-row">
                <span class="ss-col-cid ss-txt-muted">#CAT-001</span>
                <span class="ss-col-cname ss-txt-dark">Banarasi Silk</span>
                <div class="ss-col-cstatus">
                    <span class="ss-badge-active">ACTIVE</span>
                </div>
                <div class="ss-col-cactions">
                    <a href="AdminEditCategory.aspx?id=1" class="ss-cat-action-btn ss-cat-edit" title="Edit">
                        <i class="fa-solid fa-pencil"></i>
                    </a>
                    <a href="javascript:void(0);" class="ss-cat-action-btn ss-cat-delete"
                       onclick="confirm('Are you sure you want to delete this category?'); return false;"
                       title="Delete">
                        <i class="fa-regular fa-trash-can"></i>
                    </a>
                </div>
            </div>

            <!-- Row 2: Cotton Elegance -->
            <div class="ss-cat-row">
                <span class="ss-col-cid ss-txt-muted">#CAT-002</span>
                <span class="ss-col-cname ss-txt-dark">Cotton Elegance</span>
                <div class="ss-col-cstatus">
                    <span class="ss-badge-active">ACTIVE</span>
                </div>
                <div class="ss-col-cactions">
                    <a href="AdminEditCategory.aspx?id=2" class="ss-cat-action-btn ss-cat-edit" title="Edit">
                        <i class="fa-solid fa-pencil"></i>
                    </a>
                    <a href="javascript:void(0);" class="ss-cat-action-btn ss-cat-delete"
                       onclick="confirm('Are you sure you want to delete this category?'); return false;"
                       title="Delete">
                        <i class="fa-regular fa-trash-can"></i>
                    </a>
                </div>
            </div>

            <!-- Row 3: Kanjivaram -->
            <div class="ss-cat-row">
                <span class="ss-col-cid ss-txt-muted">#CAT-003</span>
                <span class="ss-col-cname ss-txt-dark">Kanjivaram</span>
                <div class="ss-col-cstatus">
                    <span class="ss-badge-inactive">INACTIVE</span>
                </div>
                <div class="ss-col-cactions">
                    <a href="AdminEditCategory.aspx?id=3" class="ss-cat-action-btn ss-cat-edit" title="Edit">
                        <i class="fa-solid fa-pencil"></i>
                    </a>
                    <a href="javascript:void(0);" class="ss-cat-action-btn ss-cat-delete"
                       onclick="confirm('Are you sure you want to delete this category?'); return false;"
                       title="Delete">
                        <i class="fa-regular fa-trash-can"></i>
                    </a>
                </div>
            </div>

            <!-- Row 4: Designer Georgette -->
            <div class="ss-cat-row">
                <span class="ss-col-cid ss-txt-muted">#CAT-004</span>
                <span class="ss-col-cname ss-txt-dark">Designer Georgette</span>
                <div class="ss-col-cstatus">
                    <span class="ss-badge-active">ACTIVE</span>
                </div>
                <div class="ss-col-cactions">
                    <a href="AdminEditCategory.aspx?id=4" class="ss-cat-action-btn ss-cat-edit" title="Edit">
                        <i class="fa-solid fa-pencil"></i>
                    </a>
                    <a href="javascript:void(0);" class="ss-cat-action-btn ss-cat-delete"
                       onclick="confirm('Are you sure you want to delete this category?'); return false;"
                       title="Delete">
                        <i class="fa-regular fa-trash-can"></i>
                    </a>
                </div>
            </div>

        </div>

    </div>
</asp:Content>