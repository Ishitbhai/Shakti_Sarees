<%@ Page Title="Update Password" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminChangePassword.aspx.cs" Inherits="Shakti_Sarees.AdminChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHead" runat="server">
    <link href="/Content/AdminChangePassword.css?v=1" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="ss-cp-viewport">

        <!-- Page Header -->
        <div class="ss-cp-header">
            <h1 class="ss-cp-title">Update Password</h1>
            <p class="ss-cp-subtitle">Ensure your account uses a long, random password to stay secure. It's recommended to change it periodically.</p>
        </div>

        <!-- Form Card Container -->
        <div class="ss-cp-card">

            <!-- Current Password -->
            <div class="ss-cp-field">
                <label class="ss-cp-label">Current Password</label>
                <asp:TextBox ID="txtCurrentPassword" runat="server" TextMode="Password" CssClass="ss-cp-input" Placeholder="Enter current password"></asp:TextBox>
                
                <asp:RequiredFieldValidator ID="rfvCurrentPassword" runat="server"
                    ControlToValidate="txtCurrentPassword"
                    ErrorMessage="Current password is required"
                    CssClass="ss-val-text"
                    Display="Dynamic"
                    EnableClientScript="false" />
            </div>

            <div class="ss-cp-divider"></div>

            <!-- New Password -->
            <div class="ss-cp-field">
                <label class="ss-cp-label">New Password</label>
                <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="ss-cp-input" Placeholder="Create new password"></asp:TextBox>
    
                <asp:RequiredFieldValidator ID="rfvNewPassword" runat="server"
                    ControlToValidate="txtNewPassword"
                    ErrorMessage="New password is required"
                    CssClass="ss-val-text"
                    Display="Dynamic"
                    EnableClientScript="false" />
        
                <asp:RegularExpressionValidator ID="revNewPassword" runat="server"
                    ControlToValidate="txtNewPassword"
                    ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#^()_\-+={}\[\]:;<>,.?/~`|]).{8,}$"
                    ErrorMessage="Password must be at least 8 characters with 1 uppercase, 1 lowercase, 1 digit, and 1 special character"
                    CssClass="ss-val-text"
                    Display="Dynamic"
                    EnableClientScript="false" />
            </div>

            <div class="ss-cp-divider"></div>

            <!-- Confirm New Password -->
            <div class="ss-cp-field ss-field-last">
                <label class="ss-cp-label">Confirm New Password</label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="ss-cp-input" Placeholder="Confirm new password"></asp:TextBox>
                
                <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server"
                    ControlToValidate="txtConfirmPassword"
                    ErrorMessage="Please confirm your new password"
                    CssClass="ss-val-text"
                    Display="Dynamic"
                    EnableClientScript="false" />
                <asp:CompareValidator ID="cvPasswordMatch" runat="server"
                    ControlToValidate="txtConfirmPassword"
                    ControlToCompare="txtNewPassword"
                    ErrorMessage="Passwords do not match"
                    CssClass="ss-val-text"
                    Display="Dynamic"
                    EnableClientScript="false" />
            </div>

            <!-- Action Controls -->
            <div class="ss-cp-actions">
                <a href="AdminProfile.aspx" class="ss-cp-cancel-btn">Cancel</a>
                <asp:Button ID="btnUpdatePassword" runat="server" Text="Update Password" CssClass="ss-cp-submit-btn" OnClick="btnUpdatePassword_Click" />
            </div>

        </div>

    </div>
</asp:Content>