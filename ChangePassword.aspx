<%@ Page Title="Security Settings" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="Shakti_Sarees.ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="<%= ResolveUrl("~/Content/ChangePassword.css?v=1") %>" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="ss-sec-viewport">
        <div class="ss-sec-card">
            
            <!-- Heading & Subtitle -->
            <h1 class="ss-sec-title">Security Settings</h1>
            <p class="ss-sec-subtitle">
                Update your password to keep your<br />
                Shakti Saree account secure.
            </p>

            <!-- 1. Current Password -->
            <div class="ss-sec-group">
                <label class="ss-sec-label">Current Password</label>
                <asp:TextBox ID="txtCurrentPassword" runat="server" CssClass="ss-sec-input" TextMode="Password" Placeholder="Enter current password"></asp:TextBox>
                
                <asp:RequiredFieldValidator ID="rfvCurrentPassword" runat="server"
                    ControlToValidate="txtCurrentPassword"
                    ErrorMessage="Current password is required"
                    CssClass="ss-val-text"
                    Display="Dynamic"
                    EnableClientScript="false" />
            </div>

            <!-- Divider: NEW PASSWORD -->
            <div class="ss-sec-divider">
                <span class="ss-divider-line"></span>
                <span class="ss-divider-text">NEW PASSWORD</span>
                <span class="ss-divider-line"></span>
            </div>

            <!-- 2. New Password -->
            <div class="ss-sec-group">
                <label class="ss-sec-label">New Password</label>
                <asp:TextBox ID="txtNewPassword" runat="server" CssClass="ss-sec-input" TextMode="Password" Placeholder="Enter new password"></asp:TextBox>
                
                <asp:RequiredFieldValidator ID="rfvNewPassword" runat="server"
                    ControlToValidate="txtNewPassword"
                    ErrorMessage="New password is required"
                    CssClass="ss-val-text"
                    Display="Dynamic"
                    EnableClientScript="false" />

                <!-- Complexity: Min 8 chars, 1 uppercase, 1 lowercase, 1 digit, 1 special character -->
                <asp:RegularExpressionValidator ID="revNewPassword" runat="server"
                    ControlToValidate="txtNewPassword"
                    ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&^#_\-])[A-Za-z\d@$!%*?&^#_\-]{8,}$"
                    ErrorMessage="Min 8 chars, 1 upper, 1 lower, 1 digit, 1 special char"
                    CssClass="ss-val-text"
                    Display="Dynamic"
                    EnableClientScript="false" />
            </div>

            <!-- 3. Confirm Password -->
            <div class="ss-sec-group">
                <label class="ss-sec-label">Confirm Password</label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="ss-sec-input" TextMode="Password" Placeholder="Confirm new password"></asp:TextBox>
                
                <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server"
                    ControlToValidate="txtConfirmPassword"
                    ErrorMessage="Confirm password is required"
                    CssClass="ss-val-text"
                    Display="Dynamic"
                    EnableClientScript="false" />

                <asp:CompareValidator ID="cvConfirmPassword" runat="server"
                    ControlToValidate="txtConfirmPassword"
                    ControlToCompare="txtNewPassword"
                    Operator="Equal"
                    Type="String"
                    ErrorMessage="Passwords do not match"
                    CssClass="ss-val-text"
                    Display="Dynamic"
                    EnableClientScript="false" />
            </div>

            <!-- Submit Button -->
            <asp:Button ID="btnChangePassword" runat="server" Text="Change Password" CssClass="ss-sec-btn" OnClick="btnChangePassword_Click" />

        </div>
    </div>
</asp:Content>