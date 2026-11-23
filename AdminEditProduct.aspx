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
                        <asp:TextBox ID="txtProductName" runat="server" CssClass="ss-ap-input"></asp:TextBox>
                        
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

                    <!-- Category Dropdown (100% Dynamic from Categories Table) -->
                    <div class="ss-ap-field">
                        <label class="ss-ap-label">Category <span class="ss-req">*</span></label>
                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="ss-ap-select" DataTextField="CategoryName" DataValueField="CategoryID" AppendDataBoundItems="true">
                            <asp:ListItem Text="Select category" Value=""></asp:ListItem>
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
                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="5" CssClass="ss-ap-textarea"></asp:TextBox>
                        
                        <asp:RequiredFieldValidator ID="rfvDescription" runat="server"
                            ControlToValidate="txtDescription"
                            ErrorMessage="Product description is required"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                    </div>
                </div>

                <!-- 2. Media Gallery Card (100% Dynamic) -->
                <div class="ss-ap-card">
                    <div class="ss-ap-card-header">
                        <i class="fa-regular fa-image ss-ap-card-icon"></i>
                        <h2 class="ss-ap-card-title">Media Gallery</h2>
                    </div>

                    <div class="ss-media-grid">
                        
                        <!-- Main Product Image -->
                        <div class="ss-media-main-box">
                            <span class="ss-media-label">Main Product Image <span class="ss-req">*</span></span>
                            <asp:HiddenField ID="hfMainImage" runat="server" />

                            <asp:Panel ID="pnlMainPreview" runat="server" CssClass="ss-edit-img-wrap ss-main-preview-wrap">
                                <asp:Image ID="imgMainPreview" runat="server" CssClass="ss-edit-full-img" AlternateText="Main Saree" />
                                <asp:LinkButton ID="btnRemoveMain" runat="server" CssClass="ss-img-delete-overlay"
                                    OnClick="btnRemoveImage_Click" CommandArgument="Main" CausesValidation="false"
                                    OnClientClick="return confirm('Are you sure you want to remove the main image?');"
                                    ToolTip="Delete main image">
                                    <i class="fa-solid fa-trash-can"></i>
                                </asp:LinkButton>
                            </asp:Panel>

                            <asp:Panel ID="pnlMainUpload" runat="server" CssClass="ss-drop-zone" Visible="false">
                                <div class="ss-cloud-icon">
                                    <i class="fa-solid fa-cloud-arrow-up"></i>
                                </div>
                                <span class="ss-drop-title">Click to upload main image</span>
                                <span class="ss-drop-sub">PNG, JPG, WebP up to 5MB.</span>
                                <asp:FileUpload ID="fuMainImage" runat="server" CssClass="ss-hidden-file" />
                            </asp:Panel>

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
                                    <asp:HiddenField ID="hfExtra1" runat="server" />
                                    <asp:Panel ID="pnlPreview1" runat="server" CssClass="ss-edit-img-wrap">
                                        <asp:Image ID="imgPreview1" runat="server" CssClass="ss-edit-full-img" AlternateText="Gallery 1" />
                                        <asp:LinkButton ID="btnRemove1" runat="server" CssClass="ss-img-delete-overlay"
                                            OnClick="btnRemoveImage_Click" CommandArgument="Extra1" CausesValidation="false"
                                            OnClientClick="return confirm('Are you sure you want to delete this gallery image?');"
                                            ToolTip="Delete gallery image">
                                            <i class="fa-solid fa-trash-can"></i>
                                        </asp:LinkButton>
                                    </asp:Panel>
                                    <asp:Panel ID="pnlUpload1" runat="server" CssClass="ss-thumb-upload-box" Visible="false">
                                        <i class="fa-solid fa-cloud-arrow-up ss-thumb-icon"></i>
                                        <span class="ss-thumb-text">Upload 1</span>
                                        <asp:FileUpload ID="fuGallery1" runat="server" CssClass="ss-hidden-file" />
                                    </asp:Panel>
                                </div>

                                <!-- Slot 2 -->
                                <div class="ss-slot-cell">
                                    <asp:HiddenField ID="hfExtra2" runat="server" />
                                    <asp:Panel ID="pnlPreview2" runat="server" CssClass="ss-edit-img-wrap">
                                        <asp:Image ID="imgPreview2" runat="server" CssClass="ss-edit-full-img" AlternateText="Gallery 2" />
                                        <asp:LinkButton ID="btnRemove2" runat="server" CssClass="ss-img-delete-overlay"
                                            OnClick="btnRemoveImage_Click" CommandArgument="Extra2" CausesValidation="false"
                                            OnClientClick="return confirm('Are you sure you want to delete this gallery image?');"
                                            ToolTip="Delete gallery image">
                                            <i class="fa-solid fa-trash-can"></i>
                                        </asp:LinkButton>
                                    </asp:Panel>
                                    <asp:Panel ID="pnlUpload2" runat="server" CssClass="ss-thumb-upload-box" Visible="false">
                                        <i class="fa-solid fa-cloud-arrow-up ss-thumb-icon"></i>
                                        <span class="ss-thumb-text">Upload 2</span>
                                        <asp:FileUpload ID="fuGallery2" runat="server" CssClass="ss-hidden-file" />
                                    </asp:Panel>
                                </div>

                                <!-- Slot 3 -->
                                <div class="ss-slot-cell">
                                    <asp:HiddenField ID="hfExtra3" runat="server" />
                                    <asp:Panel ID="pnlPreview3" runat="server" CssClass="ss-edit-img-wrap">
                                        <asp:Image ID="imgPreview3" runat="server" CssClass="ss-edit-full-img" AlternateText="Gallery 3" />
                                        <asp:LinkButton ID="btnRemove3" runat="server" CssClass="ss-img-delete-overlay"
                                            OnClick="btnRemoveImage_Click" CommandArgument="Extra3" CausesValidation="false"
                                            OnClientClick="return confirm('Are you sure you want to delete this gallery image?');"
                                            ToolTip="Delete gallery image">
                                            <i class="fa-solid fa-trash-can"></i>
                                        </asp:LinkButton>
                                    </asp:Panel>
                                    <asp:Panel ID="pnlUpload3" runat="server" CssClass="ss-thumb-upload-box" Visible="false">
                                        <i class="fa-solid fa-cloud-arrow-up ss-thumb-icon"></i>
                                        <span class="ss-thumb-text">Upload 3</span>
                                        <asp:FileUpload ID="fuGallery3" runat="server" CssClass="ss-hidden-file" />
                                    </asp:Panel>
                                </div>

                                <!-- Slot 4 -->
                                <div class="ss-slot-cell">
                                    <asp:HiddenField ID="hfExtra4" runat="server" />
                                    <asp:Panel ID="pnlPreview4" runat="server" CssClass="ss-edit-img-wrap">
                                        <asp:Image ID="imgPreview4" runat="server" CssClass="ss-edit-full-img" AlternateText="Gallery 4" />
                                        <asp:LinkButton ID="btnRemove4" runat="server" CssClass="ss-img-delete-overlay"
                                            OnClick="btnRemoveImage_Click" CommandArgument="Extra4" CausesValidation="false"
                                            OnClientClick="return confirm('Are you sure you want to delete this gallery image?');"
                                            ToolTip="Delete gallery image">
                                            <i class="fa-solid fa-trash-can"></i>
                                        </asp:LinkButton>
                                    </asp:Panel>
                                    <asp:Panel ID="pnlUpload4" runat="server" CssClass="ss-thumb-upload-box" Visible="false">
                                        <i class="fa-solid fa-cloud-arrow-up ss-thumb-icon"></i>
                                        <span class="ss-thumb-text">Upload 4</span>
                                        <asp:FileUpload ID="fuGallery4" runat="server" CssClass="ss-hidden-file" />
                                    </asp:Panel>
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
                            <asp:TextBox ID="txtPrice" runat="server" CssClass="ss-ap-input ss-input-prefixed"></asp:TextBox>
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
                        <asp:TextBox ID="txtStock" runat="server" CssClass="ss-ap-input"></asp:TextBox>

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

                <!-- Visibility & New Arrival Status Card -->
                <div class="ss-ap-card ss-visibility-card">
                    <div class="ss-ap-card-header">
                        <i class="fa-regular fa-eye ss-ap-side-icon"></i>
                        <h2 class="ss-ap-card-title">Visibility Status</h2>
                    </div>

                    <div class="ss-status-option">
                        <input type="radio" id="rbPublished" runat="server" name="statusOption" value="Published" checked="true" />
                        <div class="ss-status-info">
                            <label for="rbPublished" class="ss-status-lbl">Published</label>
                            <span class="ss-status-desc">Product will be visible on the store immediately.</span>
                        </div>
                    </div>

                    <div class="ss-status-option">
                        <input type="radio" id="rbDraft" runat="server" name="statusOption" value="Draft" />
                        <div class="ss-status-info">
                            <label for="rbDraft" class="ss-status-lbl">Draft</label>
                            <span class="ss-status-desc">Save as draft. Hidden from customers.</span>
                        </div>
                    </div>

                    <hr style="border: 0; border-top: 1px solid #eee; margin: 18px 0;" />

                    <!-- New Arrival (0 or 1) Section -->
                    <div class="ss-ap-card-header" style="margin-bottom: 12px;">
                        <i class="fa-solid fa-wand-magic-sparkles ss-ap-side-icon"></i>
                        <h2 class="ss-ap-card-title">New Arrival (Home Page)</h2>
                    </div>

                    <div class="ss-status-option">
                        <input type="radio" id="rbNewArrivalYes" runat="server" name="newArrivalOption" value="1" />
                        <div class="ss-status-info">
                            <label for="rbNewArrivalYes" class="ss-status-lbl">Yes (Show in New Arrivals)</label>
                            <span class="ss-status-desc">Sets NewArrival = 1 to feature on Default.aspx.</span>
                        </div>
                    </div>

                    <div class="ss-status-option">
                        <input type="radio" id="rbNewArrivalNo" runat="server" name="newArrivalOption" value="0" checked="true" />
                        <div class="ss-status-info">
                            <label for="rbNewArrivalNo" class="ss-status-lbl">No (Standard Product)</label>
                            <span class="ss-status-desc">Sets NewArrival = 0 (shown in Shop / Category pages only).</span>
                        </div>
                    </div>
                </div>

            </div>

        </div>
    </div>
</asp:Content>