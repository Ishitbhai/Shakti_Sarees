<%@ Page Title="Edit Saree" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminEditProduct.aspx.cs" Inherits="Shakti_Sarees.AdminEditProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHead" runat="server">
    <link href="<%= ResolveUrl("~/Content/AdminAddProduct.css?v=3") %>" rel="stylesheet" type="text/css" />
    <link href="<%= ResolveUrl("~/Content/AdminEditProduct.css?v=1") %>" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="ss-ap-container">

        <!-- Top Header & Action Controls -->
        <div class="ss-ap-topbar">
            <div>
                <span class="ss-ap-eyebrow">INVENTORY MANAGEMENT</span>
                <h1 class="ss-ap-title">Edit Saree</h1>
            </div>
            <div class="ss-ap-top-actions">
                <a href="AdminProducts.aspx" class="ss-btn-discard">
                    <i class="fa-solid fa-xmark"></i> Discard
                </a>
                <asp:LinkButton ID="btnSaveChanges" runat="server" CssClass="ss-btn-publish" OnClick="btnSaveChanges_Click">
                    <i class="fa-solid fa-floppy-disk"></i> Save Changes
                </asp:LinkButton>
            </div>
        </div>

        <div class="ss-ap-layout">
            
            <!-- ================= LEFT COLUMN ================= -->
            <div class="ss-ap-main-col">

                <!-- 1. Core Details Card -->
                <div class="ss-ap-card">
                    <div class="ss-ap-card-header">
                        <i class="fa-solid fa-circle-info ss-ap-card-icon"></i>
                        <h2 class="ss-ap-card-title">Core Details</h2>
                    </div>

                    <!-- Product Name -->
                    <div class="ss-ap-field">
                        <label class="ss-ap-label">Product Name <span class="ss-req">*</span></label>
                        <asp:TextBox ID="txtProductName" runat="server" CssClass="ss-ap-input" Text="Crimson Gold Kanjeevaram"></asp:TextBox>
                        
                        <asp:RequiredFieldValidator ID="rfvProductName" runat="server"
                            ControlToValidate="txtProductName"
                            ErrorMessage="Product Name is required"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                        <asp:RegularExpressionValidator ID="revProductName" runat="server"
                            ControlToValidate="txtProductName"
                            ValidationExpression="^[a-zA-Z0-9\s,\-]{3,100}$"
                            ErrorMessage="Enter a valid product title (min 3 chars)"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                    </div>

                    <!-- Category Dropdown -->
                    <div class="ss-ap-field">
                        <label class="ss-ap-label">Category <span class="ss-req">*</span></label>
                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="ss-ap-select">
                            <asp:ListItem Text="Select category" Value=""></asp:ListItem>
                            <asp:ListItem Text="Banarasi Silk" Value="Banarasi"></asp:ListItem>
                            <asp:ListItem Text="Kanchipuram Grand" Value="Kanchipuram"></asp:ListItem>
                            <asp:ListItem Text="Chiffon" Value="Chiffon"></asp:ListItem>
                            <asp:ListItem Text="Cotton Handloom" Value="Cotton" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Bandhni" Value="Bandhni"></asp:ListItem>
                            <asp:ListItem Text="Georgette" Value="Georgette"></asp:ListItem>
                        </asp:DropDownList>

                        <asp:RequiredFieldValidator ID="rfvCategory" runat="server"
                            ControlToValidate="ddlCategory"
                            InitialValue=""
                            ErrorMessage="Please select a category"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                    </div>

                    <!-- Description Textarea -->
                    <div class="ss-ap-field">
                        <div class="ss-ap-lbl-row">
                            <label class="ss-ap-label">Description <span class="ss-req">*</span></label>
                            <span class="ss-ap-limit">0/500</span>
                        </div>
                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="5" CssClass="ss-ap-textarea"
                            Text="Woven in the spiritual heart of Varanasi, this Midnight Orchid Banarasi silk saree is a masterpiece of textile art. The rich, royal purple base is meticulously adorned with pure golden zari work, featuring classic 'jangla' floral vines spanning the entire body."></asp:TextBox>
                        
                        <asp:RequiredFieldValidator ID="rfvDescription" runat="server"
                            ControlToValidate="txtDescription"
                            ErrorMessage="Product description is required"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                    </div>
                </div>

                <!-- 2. Media Gallery Card -->
                <div class="ss-ap-card">
                    <div class="ss-ap-card-header">
                        <i class="fa-regular fa-image ss-ap-card-icon"></i>
                        <h2 class="ss-ap-card-title">Media Gallery</h2>
                    </div>

                    <div class="ss-media-grid">
                        
                        <!-- Main Product Image -->
                        <div class="ss-media-main-box">
                            <span class="ss-media-label">Main Product Image <span class="ss-req">*</span></span>
                            <asp:HiddenField ID="hfMainImage" runat="server" Value="/images/home_main.png" />

                            <div class="ss-edit-img-wrap ss-main-preview-wrap">
                                <img src="/images/home_main.png" alt="Main Saree" class="ss-edit-full-img" />
                                <a href="javascript:void(0);" class="ss-img-delete-overlay"
                                   onclick="confirm('Are you sure you want to remove the main image?'); return false;"
                                   title="Delete main image">
                                    <i class="fa-solid fa-trash-can"></i>
                                </a>
                            </div>

                            <asp:CustomValidator ID="cvMainImage" runat="server"
                                OnServerValidate="cvMainImage_ServerValidate"
                                ErrorMessage="Main product image is required"
                                CssClass="ss-val-text"
                                Display="Dynamic"
                                EnableClientScript="false" />
                        </div>

                        <!-- Gallery Thumbnails (Max 4) -->
                        <div class="ss-media-thumbs-col">
                            <div class="ss-thumbs-header">
                                <span class="ss-thumbs-title">Gallery</span>
                                <span class="ss-thumbs-limit">(Max 4)</span>
                            </div>

                            <div class="ss-thumbs-slots">
                                
                                <!-- Slot 1 -->
                                <div class="ss-slot-cell">
                                    <div class="ss-edit-img-wrap">
                                        <img src="/images/home_main.png" alt="Gallery 1" class="ss-edit-full-img" />
                                        <a href="javascript:void(0);" class="ss-img-delete-overlay"
                                           onclick="confirm('Are you sure you want to delete this gallery image?'); return false;"
                                           title="Delete gallery image">
                                            <i class="fa-solid fa-trash-can"></i>
                                        </a>
                                    </div>
                                </div>

                                <!-- Slot 2 -->
                                <div class="ss-slot-cell">
                                    <div class="ss-edit-img-wrap">
                                        <img src="/images/home_main.png" alt="Gallery 2" class="ss-edit-full-img" />
                                        <a href="javascript:void(0);" class="ss-img-delete-overlay"
                                           onclick="confirm('Are you sure you want to delete this gallery image?'); return false;"
                                           title="Delete gallery image">
                                            <i class="fa-solid fa-trash-can"></i>
                                        </a>
                                    </div>
                                </div>

                                <!-- Slot 3 -->
                                <div class="ss-slot-cell">
                                    <div class="ss-edit-img-wrap">
                                        <img src="/images/home_main.png" alt="Gallery 3" class="ss-edit-full-img" />
                                        <a href="javascript:void(0);" class="ss-img-delete-overlay"
                                           onclick="confirm('Are you sure you want to delete this gallery image?'); return false;"
                                           title="Delete gallery image">
                                            <i class="fa-solid fa-trash-can"></i>
                                        </a>
                                    </div>
                                </div>

                                <!-- Slot 4 -->
                                <div class="ss-slot-cell">
                                    <div class="ss-edit-img-wrap">
                                        <img src="/images/home_main.png" alt="Gallery 4" class="ss-edit-full-img" />
                                        <a href="javascript:void(0);" class="ss-img-delete-overlay"
                                           onclick="confirm('Are you sure you want to delete this gallery image?'); return false;"
                                           title="Delete gallery image">
                                            <i class="fa-solid fa-trash-can"></i>
                                        </a>
                                    </div>
                                </div>

                            </div>
                        </div>

                    </div>
                </div>

            </div>

            <!-- ================= RIGHT COLUMN ================= -->
            <div class="ss-ap-side-col">

                <!-- Pricing & Inventory Card -->
                <div class="ss-ap-card">
                    <div class="ss-ap-card-header">
                        <i class="fa-solid fa-tag ss-ap-side-icon"></i>
                        <h2 class="ss-ap-card-title">Pricing &amp; Inventory</h2>
                    </div>

                    <!-- Price -->
                    <div class="ss-ap-field">
                        <label class="ss-ap-label">Price (&#8377;) <span class="ss-req">*</span></label>
                        <div class="ss-input-affix-wrap">
                            <span class="ss-input-affix">&#8377;</span>
                            <asp:TextBox ID="txtPrice" runat="server" CssClass="ss-ap-input ss-input-prefixed" Text="15999"></asp:TextBox>
                        </div>

                        <asp:RequiredFieldValidator ID="rfvPrice" runat="server"
                            ControlToValidate="txtPrice"
                            ErrorMessage="Price is required"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                        <asp:RegularExpressionValidator ID="revPrice" runat="server"
                            ControlToValidate="txtPrice"
                            ValidationExpression="^[0-9]+(\.[0-9]{1,2})?$"
                            ErrorMessage="Enter a valid amount"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                    </div>

                    <!-- Stock Quantity -->
                    <div class="ss-ap-field ss-field-last">
                        <label class="ss-ap-label">Stock Quantity <span class="ss-req">*</span></label>
                        <asp:TextBox ID="txtStock" runat="server" CssClass="ss-ap-input" Text="50"></asp:TextBox>

                        <asp:RequiredFieldValidator ID="rfvStock" runat="server"
                            ControlToValidate="txtStock"
                            ErrorMessage="Stock quantity is required"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                        <asp:RegularExpressionValidator ID="revStock" runat="server"
                            ControlToValidate="txtStock"
                            ValidationExpression="^\d+$"
                            ErrorMessage="Stock must be a positive integer"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                    </div>
                </div>

                <!-- Visibility Status Card -->
                <div class="ss-ap-card ss-visibility-card">
                    <div class="ss-ap-card-header">
                        <i class="fa-regular fa-eye ss-ap-side-icon"></i>
                        <h2 class="ss-ap-card-title">Visibility Status</h2>
                    </div>

                    <div class="ss-status-option">
                        <input type="radio" id="rbPublished" name="statusOption" value="Published" checked="checked" />
                        <div class="ss-status-info">
                            <label for="rbPublished" class="ss-status-lbl">Published</label>
                            <span class="ss-status-desc">Product will be visible on the store immediately.</span>
                        </div>
                    </div>

                    <div class="ss-status-option">
                        <input type="radio" id="rbDraft" name="statusOption" value="Draft" />
                        <div class="ss-status-info">
                            <label for="rbDraft" class="ss-status-lbl">Draft</label>
                            <span class="ss-status-desc">Save as draft. Hidden from customers.</span>
                        </div>
                    </div>
                </div>

            </div>

        </div>
    </div>
</asp:Content>