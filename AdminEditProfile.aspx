<%@ Page Title="Edit Profile" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminEditProfile.aspx.cs" Inherits="Shakti_Sarees.AdminEditProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHead" runat="server">
    <link href="/Content/AdminEditProfile.css?v=1" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="ss-ep-viewport">
        <div class="ss-ep-card">

            <!-- Section 1: Details -->
            <div class="ss-ep-section">
                <h2 class="ss-ep-section-title">Details</h2>
                <div class="ss-ep-divider"></div>

                <!-- Full Name -->
                <div class="ss-ep-field ss-field-narrow">
                    <label class="ss-ep-label">Full Name</label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="ss-ep-input" Text="Ishit Vadhavana"></asp:TextBox>
                    
                    <asp:RequiredFieldValidator ID="rfvFullName" runat="server"
                        ControlToValidate="txtFullName"
                        ErrorMessage="Full Name is required"
                        CssClass="ss-val-text"
                        Display="Dynamic"
                        EnableClientScript="false" />
                    <asp:RegularExpressionValidator ID="revFullName" runat="server"
                        ControlToValidate="txtFullName"
                        ValidationExpression="^[a-zA-Z\s]{3,60}$"
                        ErrorMessage="Enter letters only (min 3 characters)"
                        CssClass="ss-val-text"
                        Display="Dynamic"
                        EnableClientScript="false" />
                </div>

                <!-- Email & Mobile Row -->
                <div class="ss-ep-row">
                    <div class="ss-ep-col ss-col-compact">
                        <label class="ss-ep-label">Email Address</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="ss-ep-input" Text="ishit@gmail.com"></asp:TextBox>
                        
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                            ControlToValidate="txtEmail"
                            ErrorMessage="Email address is required"
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

                   <div class="ss-ep-col ss-col-wide">
                        <label class="ss-ep-label">Mobile Number</label>
                        <asp:TextBox ID="txtMobile" runat="server" CssClass="ss-ep-input" Text="8460065647" MaxLength="10"></asp:TextBox>
    
                        <asp:RequiredFieldValidator ID="rfvMobile" runat="server"
                            ControlToValidate="txtMobile"
                            ErrorMessage="Mobile number is required"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                        <asp:RegularExpressionValidator ID="revMobile" runat="server"
                            ControlToValidate="txtMobile"
                            ValidationExpression="^[0-9]{10}$"
                            ErrorMessage="Mobile number must be exactly 10 digits"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                    </div>  
                </div>
            </div>

            <!-- Section 2: Address -->
            <div class="ss-ep-section">
                <h2 class="ss-ep-section-title">Address</h2>
                <div class="ss-ep-divider"></div>

                <!-- Local Address & City Row -->
                <div class="ss-ep-row">
                    <div class="ss-ep-col">
                        <label class="ss-ep-label">Local Address</label>
                        <asp:TextBox ID="txtLocalAddress" runat="server" CssClass="ss-ep-input" Text="Samras Boys Hostel"></asp:TextBox>
                        
                        <asp:RequiredFieldValidator ID="rfvLocalAddress" runat="server"
                            ControlToValidate="txtLocalAddress"
                            ErrorMessage="Local address is required"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                    </div>

                    <div class="ss-ep-col">
                        <label class="ss-ep-label">City</label>
                        <asp:TextBox ID="txtCity" runat="server" CssClass="ss-ep-input" Text="Rajkot"></asp:TextBox>
                        
                        <asp:RequiredFieldValidator ID="rfvCity" runat="server"
                            ControlToValidate="txtCity"
                            ErrorMessage="City is required"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                    </div>
                </div>

                <!-- PIN Code -->
                <div class="ss-ep-field ss-field-narrow">
                    <label class="ss-ep-label">PIN Code</label>
                    <asp:TextBox ID="txtPinCode" runat="server" CssClass="ss-ep-input" Text="360005" MaxLength="6"></asp:TextBox>
                    
                    <asp:RequiredFieldValidator ID="rfvPinCode" runat="server"
                        ControlToValidate="txtPinCode"
                        ErrorMessage="PIN code is required"
                        CssClass="ss-val-text"
                        Display="Dynamic"
                        EnableClientScript="false" />
                    <asp:RegularExpressionValidator ID="revPinCode" runat="server"
                        ControlToValidate="txtPinCode"
                        ValidationExpression="^\d{6}$"
                        ErrorMessage="PIN code must be exactly 6 digits"
                        CssClass="ss-val-text"
                        Display="Dynamic"
                        EnableClientScript="false" />
                </div>
            </div>

            <!-- Footer Action Row -->
            <div class="ss-ep-footer-divider"></div>
            <div class="ss-ep-actions">
                <a href="AdminProfile.aspx" class="ss-btn-ep-cancel">Cancel</a>
                <asp:LinkButton ID="btnSaveChanges" runat="server" CssClass="ss-btn-ep-save" OnClick="btnSaveChanges_Click">
                    <i class="fa-regular fa-floppy-disk"></i> Save Changes
                </asp:LinkButton>
            </div>

        </div>
    </div>
</asp:Content>