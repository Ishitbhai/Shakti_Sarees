<%@ Page Title="Edit Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditProfile.aspx.cs" Inherits="Shakti_Sarees.EditProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="<%= ResolveUrl("~/Content/EditProfile.css?v=1") %>" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="ss-ep-viewport">

        <!-- Page Header -->
        <header class="ss-ep-header">
            <h1 class="ss-ep-title">Edit Profile</h1>
            <p class="ss-ep-subtitle">Update your personal information and shipping details.</p>
        </header>

        <!-- Main Form Card -->
        <div class="ss-ep-card">

            <!-- Section 1: Personal Details -->
            <div class="ss-ep-section">
                <h2 class="ss-ep-sec-title">Personal Details</h2>

                <!-- Full Name: Only letters and spaces, min length 2 -->
                <div class="ss-ep-field ss-field-half">
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
                        ValidationExpression="^[a-zA-Z\s]{2,}$"
                        ErrorMessage="Name must contain only letters and at least 2 characters"
                        CssClass="ss-val-text"
                        Display="Dynamic"
                        EnableClientScript="false" />
                </div>

                <!-- Email & Mobile -->
                <div class="ss-ep-row">
                    <div class="ss-ep-col">
                        <label class="ss-ep-label">Email Address</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="ss-ep-input" Text="ishit@gmail.com"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                            ControlToValidate="txtEmail"
                            ErrorMessage="Email is required"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                        <asp:RegularExpressionValidator ID="revEmail" runat="server"
                            ControlToValidate="txtEmail"
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                            ErrorMessage="Invalid email address format"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                    </div>

                    <div class="ss-ep-col">
                        <label class="ss-ep-label">Mobile Number</label>
                        <asp:TextBox ID="txtMobile" runat="server" CssClass="ss-ep-input" Text="8460065647"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvMobile" runat="server"
                            ControlToValidate="txtMobile"
                            ErrorMessage="Mobile is required"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                        <asp:RegularExpressionValidator ID="revMobile" runat="server"
                            ControlToValidate="txtMobile"
                            ValidationExpression="^(\+91[\-\s]?)?[0-9]{10}$"
                            ErrorMessage="Enter a valid 10-digit mobile number"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                    </div>
                </div>
            </div>

            <!-- Section 2: Default Shipping Address -->
            <div class="ss-ep-section">
                <h2 class="ss-ep-sec-title">Default Shipping Address</h2>

                <!-- Local Address & City -->
                <div class="ss-ep-row">
                    <div class="ss-ep-col">
                        <label class="ss-ep-label">Local Address</label>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="ss-ep-input" Text="Samras Boys Hostel"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvAddress" runat="server"
                            ControlToValidate="txtAddress"
                            ErrorMessage="Address is required"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                        <asp:RegularExpressionValidator ID="revAddress" runat="server"
                            ControlToValidate="txtAddress"
                            ValidationExpression="^.{10,}$"
                            ErrorMessage="It is too small"
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
                        <asp:RegularExpressionValidator ID="revCity" runat="server"
                            ControlToValidate="txtCity"
                            ValidationExpression="^[a-zA-Z\s]+$"
                            ErrorMessage="City must contain only letters"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                    </div>
                </div>

                <!-- PIN Code -->
                <div class="ss-ep-field ss-field-half">
                    <label class="ss-ep-label">PIN Code</label>
                    <asp:TextBox ID="txtPincode" runat="server" CssClass="ss-ep-input" Text="360005"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPincode" runat="server"
                        ControlToValidate="txtPincode"
                        ErrorMessage="Pincode is required"
                        CssClass="ss-val-text"
                        Display="Dynamic"
                        EnableClientScript="false" />
                    <asp:RegularExpressionValidator ID="revPincode" runat="server"
                        ControlToValidate="txtPincode"
                        ValidationExpression="^[0-9]{6}$"
                        ErrorMessage="Pincode must be 6 digits only"
                        CssClass="ss-val-text"
                        Display="Dynamic"
                        EnableClientScript="false" />
                </div>
            </div>

            <!-- Footer Action Controls -->
            <div class="ss-ep-actions">
                <a href="Profile.aspx" class="ss-ep-cancel-btn">Cancel</a>
                <asp:LinkButton ID="btnSaveProfile" runat="server" CssClass="ss-ep-save-btn" OnClick="btnSaveProfile_Click">
                    <i class="fa-regular fa-floppy-disk"></i> Save Changes
                </asp:LinkButton>
            </div>

        </div>

    </div>
</asp:Content>