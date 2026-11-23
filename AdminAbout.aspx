<%@ Page Title="Edit About Us" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminAbout.aspx.cs" Inherits="Shakti_Sarees.AdminAbout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHead" runat="server">
    <link href="/Content/AdminAbout.css?v=1" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="ss-abt-container">

        <!-- Top Header & Action Controls -->
        <div class="ss-abt-topbar">
            <div>
                <h1 class="ss-abt-title">Edit About Us</h1>
                <p class="ss-abt-subtitle">Update the content, imagery, and key selling points for the About page.</p>
            </div>
            <div class="ss-abt-top-actions">
                <a href="AdminDashboard.aspx" class="ss-btn-discard">Discard Changes</a>
                <asp:LinkButton ID="btnPublishUpdates" runat="server" CssClass="ss-btn-publish" OnClick="btnPublishUpdates_Click">
                    <i class="fa-solid fa-floppy-disk"></i> Publish Updates
                </asp:LinkButton>
            </div>
        </div>

        <div class="ss-abt-layout">

            <!-- ================= LEFT COLUMN ================= -->
            <div class="ss-abt-main-col">

                <!-- 1. Core Content Card (100% Dynamic from PageAbout Table) -->
                <div class="ss-abt-card">
                    <div class="ss-abt-card-header">
                        <i class="fa-regular fa-file-lines ss-abt-icon"></i>
                        <h2 class="ss-abt-card-title">Core Content</h2>
                    </div>

                    <!-- Page Title -->
                    <div class="ss-abt-field">
                        <label class="ss-abt-label">Page Title</label>
                        <asp:TextBox ID="txtPageTitle" runat="server" CssClass="ss-abt-input" Placeholder="Enter page title"></asp:TextBox>
                        
                        <asp:RequiredFieldValidator ID="rfvPageTitle" runat="server"
                            ControlToValidate="txtPageTitle"
                            ErrorMessage="Page title is required"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                    </div>

                    <!-- Main Story (Rich Text) -->
                    <div class="ss-abt-field ss-field-last">
                        <label class="ss-abt-label">Main Story (Rich Text)</label>
                        <asp:TextBox ID="txtMainStory" runat="server" TextMode="MultiLine" Rows="11" CssClass="ss-abt-textarea" Placeholder="Enter main brand story..."></asp:TextBox>
                        
                        <asp:RequiredFieldValidator ID="rfvMainStory" runat="server"
                            ControlToValidate="txtMainStory"
                            ErrorMessage="Main story content is required"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                    </div>
                </div>

                <!-- 2. Why Choose Us Card -->
                <div class="ss-abt-card">
                    <div class="ss-abt-card-header">
                        <i class="fa-solid fa-sliders ss-abt-icon"></i>
                        <h2 class="ss-abt-card-title">Why Choose Us</h2>
                    </div>

                    <!-- Feature Box 1 -->
                    <div class="ss-feature-box">
                        <div class="ss-feature-row">
                            <div class="ss-feature-col-icon">
                                <span class="ss-mini-label">ICON</span>
                                <asp:HiddenField ID="hfFeatureIcon1" runat="server" />
                                <div class="ss-icon-upload-slot">
                                    <i class="fa-regular fa-image"></i>
                                    <asp:FileUpload ID="fuFeatureIcon1" runat="server" CssClass="ss-hidden-file" />
                                </div>
                            </div>
                            <div class="ss-feature-col-heading">
                                <span class="ss-mini-label">HEADING</span>
                                <asp:TextBox ID="txtFeature1Heading" runat="server" CssClass="ss-abt-input" Placeholder="Feature 1 Heading"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvFeature1Heading" runat="server"
                                    ControlToValidate="txtFeature1Heading"
                                    ErrorMessage="Heading is required"
                                    CssClass="ss-val-text"
                                    Display="Dynamic"
                                    EnableClientScript="false" />
                            </div>
                        </div>
                        <div class="ss-feature-desc-wrap">
                            <span class="ss-mini-label">BRIEF DESCRIPTION</span>
                            <asp:TextBox ID="txtFeature1Desc" runat="server" TextMode="MultiLine" Rows="2" CssClass="ss-abt-textarea ss-desc-box" Placeholder="Feature 1 Description"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvFeature1Desc" runat="server"
                                ControlToValidate="txtFeature1Desc"
                                ErrorMessage="Brief description is required"
                                CssClass="ss-val-text"
                                Display="Dynamic"
                                EnableClientScript="false" />
                        </div>
                    </div>

                    <!-- Feature Box 2 -->
                    <div class="ss-feature-box ss-field-last">
                        <div class="ss-feature-row">
                            <div class="ss-feature-col-icon">
                                <span class="ss-mini-label">ICON</span>
                                <asp:HiddenField ID="hfFeatureIcon2" runat="server" />
                                <div class="ss-icon-upload-slot">
                                    <i class="fa-regular fa-image"></i>
                                    <asp:FileUpload ID="fuFeatureIcon2" runat="server" CssClass="ss-hidden-file" />
                                </div>
                            </div>
                            <div class="ss-feature-col-heading">
                                <span class="ss-mini-label">HEADING</span>
                                <asp:TextBox ID="txtFeature2Heading" runat="server" CssClass="ss-abt-input" Placeholder="Feature 2 Heading"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvFeature2Heading" runat="server"
                                    ControlToValidate="txtFeature2Heading"
                                    ErrorMessage="Heading is required"
                                    CssClass="ss-val-text"
                                    Display="Dynamic"
                                    EnableClientScript="false" />
                            </div>
                        </div>
                        <div class="ss-feature-desc-wrap">
                            <span class="ss-mini-label">BRIEF DESCRIPTION</span>
                            <asp:TextBox ID="txtFeature2Desc" runat="server" TextMode="MultiLine" Rows="2" CssClass="ss-abt-textarea ss-desc-box" Placeholder="Feature 2 Description"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvFeature2Desc" runat="server"
                                ControlToValidate="txtFeature2Desc"
                                ErrorMessage="Brief description is required"
                                CssClass="ss-val-text"
                                Display="Dynamic"
                                EnableClientScript="false" />
                        </div>
                    </div>

                </div>

            </div>

            <!-- ================= RIGHT COLUMN (IMAGE) ================= -->
            <div class="ss-abt-side-col">
                <div class="ss-abt-card">
                    <div class="ss-abt-card-header">
                        <i class="fa-regular fa-image ss-abt-icon"></i>
                        <h2 class="ss-abt-card-title">Image</h2>
                    </div>

                    <!-- Stored Image Reference -->
                    <asp:HiddenField ID="hfAboutImage" runat="server" />

                    <!-- Upload Zone Matching Screenshot -->
                    <div class="ss-abt-img-dropzone" style="position:relative; overflow:hidden;">
                        <asp:Image ID="imgHeroPreview" runat="server" Visible="false" style="width:100%; height:100%; object-fit:cover; position:absolute; top:0; left:0;" />
                        <i id="icoPlaceholder" runat="server" class="fa-regular fa-image ss-zone-ph-icon"></i>
                        <asp:FileUpload ID="fuAboutImage" runat="server" CssClass="ss-hidden-file" />
                    </div>

                    <!-- Server-Side File Validation -->
                    <asp:CustomValidator ID="cvAboutImage" runat="server"
                        OnServerValidate="cvAboutImage_ServerValidate"
                        ErrorMessage="Please select an image file"
                        CssClass="ss-val-text"
                        Display="Dynamic"
                        EnableClientScript="false" />
                </div>
            </div>

        </div>

    </div>
</asp:Content>