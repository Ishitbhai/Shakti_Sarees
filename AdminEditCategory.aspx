<%@ Page Title="Edit Category" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminEditCategory.aspx.cs" Inherits="Shakti_Sarees.AdminEditCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHead" runat="server">
    <link href="/Content/AdminCategoryForm.css?v=2" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="ss-cat-viewport">
        
        <h1 class="ss-cat-title">Edit Category</h1>

        <div class="ss-cat-card">

            <!-- Feedback / Error Message -->
            <asp:Label ID="lblMsg" runat="server" CssClass="ss-val-text" Visible="false" style="display:block; margin-bottom:15px; font-weight:600;"></asp:Label>
            
            <!-- Category Name Field -->
            <div class="ss-cat-field">
                <label class="ss-cat-label">Category Name</label>
                <asp:TextBox ID="txtCategoryName" runat="server" CssClass="ss-cat-input"></asp:TextBox>
                
                <asp:RequiredFieldValidator ID="rfvCategoryName" runat="server"
                    ControlToValidate="txtCategoryName"
                    ErrorMessage="Category Name is required"
                    CssClass="ss-val-text"
                    Display="Dynamic"
                    EnableClientScript="false" />
                <asp:RegularExpressionValidator ID="revCategoryName" runat="server"
                    ControlToValidate="txtCategoryName"
                    ValidationExpression="^[a-zA-Z\s]{2,50}$"
                    ErrorMessage="Category name must contain only letters (min 2 characters)"
                    CssClass="ss-val-text"
                    Display="Dynamic"
                    EnableClientScript="false" />
            </div>

            <!-- Category Image Field -->
            <div class="ss-cat-field">
                <label class="ss-cat-label">Category Image</label>
                <asp:HiddenField ID="hfCategoryImage" runat="server" />
                <div style="margin-bottom: 10px;">
                    <asp:Image ID="imgCategoryPreview" runat="server" style="width: 70px; height: 70px; object-fit: cover; border-radius: 6px; border: 1px solid #ddd;" />
                </div>
                <asp:FileUpload ID="fuCategoryImage" runat="server" CssClass="ss-cat-input" style="padding: 8px;" />
            </div>

            <!-- Status Radios -->
            <div class="ss-cat-status-group">
                <label class="ss-cat-label">Status</label>
                <div class="ss-cat-radio-row">
                    <label class="ss-cat-radio-opt">
                        <input type="radio" id="rbActiveEdit" runat="server" name="categoryStatus" value="Active" checked="true" />
                        <span>Active</span>
                    </label>
                    <label class="ss-cat-radio-opt">
                        <input type="radio" id="rbInactiveEdit" runat="server" name="categoryStatus" value="Inactive" />
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