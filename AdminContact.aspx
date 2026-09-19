<%@ Page Title="Edit Contact Details" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminContact.aspx.cs" Inherits="Shakti_Sarees.AdminContact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHead" runat="server">
    <link href="/Content/AdminContact.css?v=1" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="ss-ctc-container">

        <!-- Top Header & Save Actions -->
        <div class="ss-ctc-topbar">
            <div>
                <h1 class="ss-ctc-title">Edit Contact Details</h1>
                <p class="ss-ctc-subtitle">Update the information customers use to reach your boutique. Changes here will immediately reflect on the public Contact Us page.</p>
            </div>
            <div class="ss-ctc-top-actions">
                <a href="AdminDashboard.aspx" class="ss-btn-ctc-discard">
                    <i class="fa-solid fa-rotate-left"></i> DISCARD
                </a>
                <asp:LinkButton ID="btnSaveChanges" runat="server" CssClass="ss-btn-ctc-save" OnClick="btnSaveChanges_Click">
                    <i class="fa-solid fa-floppy-disk"></i> SAVE CHANGES
                </asp:LinkButton>
            </div>
        </div>

        <div class="ss-ctc-layout">

            <!-- ================= LEFT COLUMN: CORE CONTENT ================= -->
            <div class="ss-ctc-main-col">
                <div class="ss-ctc-card">
                    <div class="ss-ctc-card-header">
                        <i class="fa-regular fa-file-lines ss-ctc-icon"></i>
                        <h2 class="ss-ctc-card-title">Core Content</h2>
                    </div>

                    <!-- Page Title -->
                    <div class="ss-ctc-field">
                        <label class="ss-ctc-label">Page Title</label>
                        <asp:TextBox ID="txtPageTitle" runat="server" CssClass="ss-ctc-input" Text="Let's Weave Something beautiful together."></asp:TextBox>
                        
                        <asp:RequiredFieldValidator ID="rfvPageTitle" runat="server"
                            ControlToValidate="txtPageTitle"
                            ErrorMessage="Page title is required"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                    </div>

                    <!-- Main Story -->
                    <div class="ss-ctc-field ss-field-last">
                        <label class="ss-ctc-label">Main Story</label>
                        <asp:TextBox ID="txtMainStory" runat="server" TextMode="MultiLine" Rows="8" CssClass="ss-ctc-textarea"
                            Text="Whether you're looking for a specific heritage weave, have a question about our collections, or need assistance with a bespoke order, our team is here with traditional warmth and modern efficiency."></asp:TextBox>
                        
                        <asp:RequiredFieldValidator ID="rfvMainStory" runat="server"
                            ControlToValidate="txtMainStory"
                            ErrorMessage="Main story description is required"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                    </div>
                </div>
            </div>

            <!-- ================= RIGHT COLUMN: CONTACTS ================= -->
            <div class="ss-ctc-side-col">
                <div class="ss-ctc-card">
                    <div class="ss-ctc-card-header">
                        <i class="fa-regular fa-file-lines ss-ctc-icon"></i>
                        <h2 class="ss-ctc-card-title">Contacts</h2>
                    </div>

                    <!-- Address -->
                    <div class="ss-ctc-field">
                        <label class="ss-ctc-label">Address</label>
                        <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="4" CssClass="ss-ctc-textarea ss-compact-area"
                            Text="Tapeshwar Mandir Road,&#10;Satta Bazar,&#10;Veraval, Gujarat - 362265,&#10;India"></asp:TextBox>
                        
                        <asp:RequiredFieldValidator ID="rfvAddress" runat="server"
                            ControlToValidate="txtAddress"
                            ErrorMessage="Address is required"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                    </div>

                    <!-- Phone -->
                    <div class="ss-ctc-field">
                        <label class="ss-ctc-label">Phone</label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="ss-ctc-input" Text="8460065647" MaxLength="10"></asp:TextBox>
    
                        <asp:RequiredFieldValidator ID="rfvPhone" runat="server"
                            ControlToValidate="txtPhone"
                            ErrorMessage="Phone number is required"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
        
                        <asp:RegularExpressionValidator ID="revPhone" runat="server"
                            ControlToValidate="txtPhone"
                            ValidationExpression="^[0-9]{10}$"
                            ErrorMessage="Phone number must be exactly 10 digits"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                    </div>

                    <!-- Email -->
                    <div class="ss-ctc-field">
                        <label class="ss-ctc-label">Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="ss-ctc-input" Text="ishitvadhavana@gmail.com"></asp:TextBox>
                        
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                            ControlToValidate="txtEmail"
                            ErrorMessage="Email is required"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                        <asp:RegularExpressionValidator ID="revEmail" runat="server"
                            ControlToValidate="txtEmail"
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                            ErrorMessage="Enter a valid email address"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                    </div>

                    <!-- Business Hours -->
                    <div class="ss-ctc-field ss-field-last">
                        <label class="ss-ctc-label">Business Hours</label>
                        <asp:TextBox ID="txtBusinessHours" runat="server" TextMode="MultiLine" Rows="3" CssClass="ss-ctc-textarea ss-compact-area"
                            Text="Mon - Sat: 10:00 AM - 8:00 PM&#10;Sunday: Closed"></asp:TextBox>
                        
                        <asp:RequiredFieldValidator ID="rfvBusinessHours" runat="server"
                            ControlToValidate="txtBusinessHours"
                            ErrorMessage="Business hours are required"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                    </div>

                </div>
            </div>

        </div>

    </div>
</asp:Content>