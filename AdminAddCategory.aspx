<%@ Page Title="Add New Category" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminAddCategory.aspx.cs" Inherits="Shakti_Sarees.AdminAddCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHead" runat="server">
    <link href="/Content/AdminCategoryForm.css?v=2" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="ss-cat-viewport">
        
        <h1 class="ss-cat-title">Add New Category</h1>

        <div class="ss-cat-card">

            <!-- Feedback / Error Message -->
            <asp:Label ID="lblMsg" runat="server" CssClass="ss-val-text" Visible="false" style="display:block; margin-bottom:15px; font-weight:600;"></asp:Label>

            <!-- Category Name -->
            <div class="ss-cat-field">
                <label class="ss-cat-label">Category Name</label>
                <asp:TextBox ID="txtCategoryName" runat="server" CssClass="ss-cat-input" Placeholder="e.g. Banarasi Silk"></asp:TextBox>
                
                <asp:RequiredFieldValidator ID="rfvCategoryName" runat="server"
                    ControlToValidate="txtCategoryName"
                    ErrorMessage="Category Name is required"
                    CssClass="ss-val-text"
                    Display="Dynamic"
                    EnableClientScript="false" />
                <asp:RegularExpressionValidator ID="revCategoryName" runat="server"
                    ControlToValidate="txtCategoryName"
                    ValidationExpression="^[a-zA-Z\s]{3,50}$"
                    ErrorMessage="Category name must be 3-50 characters with letters only"
                    CssClass="ss-val-text"
                    Display="Dynamic"
                    EnableClientScript="false" />
            </div>

            <!-- Category Image Upload -->
            <div class="ss-cat-field">
                <label class="ss-cat-label">Category Image</label>
                <asp:FileUpload ID="fuCategoryImage" runat="server" CssClass="ss-cat-input" style="padding: 8px;" />
                
                <asp:CustomValidator ID="cvCategoryImage" runat="server"
                    OnServerValidate="cvCategoryImage_ServerValidate"
                    ErrorMessage="Please select a category image"
                    CssClass="ss-val-text"
                    Display="Dynamic"
                    EnableClientScript="false" />
            </div>

            <!-- Status Radios -->
            <div class="ss-cat-status-group">
                <label class="ss-cat-label">Status</label>
                <div class="ss-cat-radio-row">
                    <label class="ss-cat-radio-opt">
                        <input type="radio" id="rbActive" runat="server" name="categoryStatus" value="Active" checked="true" />
                        <span>Active</span>
                    </label>
                    <label class="ss-cat-radio-opt">
                        <input type="radio" id="rbInactive" runat="server" name="categoryStatus" value="Inactive" />
                        <span>Inactive</span>
                    </label>
                </div>
            </div>

            <!-- Action Controls -->
            <div class="ss-cat-actions">
                <a href="AdminCategories.aspx" class="ss-btn-cat-cancel">Cancel</a>
                <asp:LinkButton ID="btnSaveCategory" runat="server" CssClass="ss-btn-cat-save" OnClick="btnSaveCategory_Click">
                    Save Category &rarr;
                </asp:LinkButton>
            </div>

        </div>

    </div>
</asp:Content>