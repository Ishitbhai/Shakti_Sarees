<%@ Page Title="Sign In" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Shakti_Sarees.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<link href="<%= ResolveUrl("~/Content/Auth.css?v=2") %>" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="ss-login-viewport">
        <div class="ss-login-card">
            
            <!-- Top Header Banner Tab -->
            <div class="ss-login-header">
                <h2 class="ss-login-title">Welcome Back</h2>
            </div>

            <!-- Card Content Body -->
            <div class="ss-login-body">
                
                <!-- Feedback / Error Message -->
                <asp:Label ID="lblLoginMsg" runat="server" CssClass="ss-auth-msg" Visible="false"></asp:Label>

                <!-- 1. Email or Mobile -->
                <div class="ss-login-group">
                    <label class="ss-login-label">Email or Mobile Number</label>
                    <asp:TextBox ID="txtIdentifier" runat="server" CssClass="ss-login-input" Placeholder="Enter your email or mobile"></asp:TextBox>
                    
                    <asp:RequiredFieldValidator ID="rfvIdentifier" runat="server"
                        ControlToValidate="txtIdentifier"
                        ErrorMessage="Email or mobile number is required"
                        CssClass="ss-val-text"
                        Display="Dynamic"
                        EnableClientScript="false" />

                    <!-- Accepts either a valid 10-digit phone number OR a standard email -->
                    <asp:RegularExpressionValidator ID="revIdentifier" runat="server"
                        ControlToValidate="txtIdentifier"
                        ValidationExpression="(^[0-9]{10}$)|(^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$)"
                        ErrorMessage="Enter a valid 10-digit number or email address"
                        CssClass="ss-val-text"
                        Display="Dynamic"
                        EnableClientScript="false" />
                </div>

                <!-- 2. Password -->
                <div class="ss-login-group">
                    <label class="ss-login-label">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="ss-login-input" TextMode="Password" Placeholder="Enter your password"></asp:TextBox>
                    
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                        ControlToValidate="txtPassword"
                        ErrorMessage="Password is required"
                        CssClass="ss-val-text"
                        Display="Dynamic"
                        EnableClientScript="false" />
                </div>

                <!-- 3. Sign In Button -->
                <asp:Button ID="btnSignIn" runat="server" Text="Sign In &rarr;" CssClass="ss-login-submit-btn" OnClick="btnSignIn_Click" />

                <!-- 4. OR Divider -->
                <div class="ss-or-divider">
                    <span class="ss-or-line"></span>
                    <span class="ss-or-text">OR</span>
                    <span class="ss-or-line"></span>
                </div>

                <!-- 5. Register Link -->
                <div class="ss-login-footer">
                    New to Shakti Saree? <a href="Register.aspx" class="ss-login-link">Register Here</a>
                </div>

            </div>
        </div>
    </div>
</asp:Content>