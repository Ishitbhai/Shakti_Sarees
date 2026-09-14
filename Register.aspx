<%@ Page Title="Create Account" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Shakti_Sarees.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<link href="<%= ResolveUrl("~/Content/Auth.css?v=2") %>" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="ss-split-auth-container">
        
        <!-- Left Side: Heritage Model Image -->
        <div class="ss-auth-visual">
            <img src="images/auth_model.png" alt="Shakti Saree Heritage Model" class="ss-auth-banner-img" />
        </div>

        <!-- Right Side: Centered Form Card -->
        <div class="ss-auth-panel">
            <div class="ss-auth-box">
                
                <!-- Top Badge Icon -->
                <div class="ss-badge-icon-wrap">
                    <div class="ss-badge-icon">
                        <i class="fa-regular fa-user"></i>
                    </div>
                </div>

                <h2 class="ss-reg-title">Create Account</h2>

                <!-- Status / Feedback Message -->
                <asp:Label ID="lblMessage" runat="server" CssClass="ss-auth-msg" Visible="false"></asp:Label>

                <!-- 1. Full Name: Only letters and spaces, min length 2 -->
                <div class="ss-underline-group">
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="ss-underline-input" Placeholder="Full Name"></asp:TextBox>
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

                <!-- 2. Mobile & Email -->
                <div class="ss-underline-row">
                    <div class="ss-underline-col">
                        <asp:TextBox ID="txtMobile" runat="server" CssClass="ss-underline-input" Placeholder="Mobile Number"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvMobile" runat="server" 
                            ControlToValidate="txtMobile"
                            ErrorMessage="Mobile required" 
                            CssClass="ss-val-text" 
                            Display="Dynamic" 
                            EnableClientScript="false" />
                        <asp:RegularExpressionValidator ID="revMobile" runat="server" 
                            ControlToValidate="txtMobile"
                            ValidationExpression="^[0-9]{10}$" 
                            ErrorMessage="Must be 10 digits"
                            CssClass="ss-val-text" 
                            Display="Dynamic" 
                            EnableClientScript="false" />
                    </div>
                    <div class="ss-underline-col">
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="ss-underline-input" Placeholder="Email Address"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                            ControlToValidate="txtEmail"
                            ErrorMessage="Email required" 
                            CssClass="ss-val-text" 
                            Display="Dynamic" 
                            EnableClientScript="false" />
                        <asp:RegularExpressionValidator ID="revEmail" runat="server" 
                            ControlToValidate="txtEmail"
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                            ErrorMessage="Invalid email" 
                            CssClass="ss-val-text" 
                            Display="Dynamic" 
                            EnableClientScript="false" />
                    </div>
                </div>

                <!-- 3. Local Address: At least 10 characters -->
                <div class="ss-underline-group">
                    <asp:TextBox ID="txtAddress" runat="server" CssClass="ss-underline-input" Placeholder="Local Address"></asp:TextBox>
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

                <!-- 4. City (Letters only) & Pincode (Exactly 6 digits) -->
                <div class="ss-underline-row">
                    <div class="ss-underline-col">
                        <asp:TextBox ID="txtCity" runat="server" CssClass="ss-underline-input" Placeholder="City"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCity" runat="server" 
                            ControlToValidate="txtCity"
                            ErrorMessage="City required" 
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
                    <div class="ss-underline-col">
                        <asp:TextBox ID="txtPincode" runat="server" CssClass="ss-underline-input" Placeholder="Pincode"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPincode" runat="server" 
                            ControlToValidate="txtPincode"
                            ErrorMessage="Pincode required" 
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

                <!-- 5. Password & Confirm Password (Strong complexity + Match comparison) -->
                <div class="ss-underline-row">
                    <div class="ss-underline-col">
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="ss-underline-input" TextMode="Password" Placeholder="Password"></asp:TextBox>
                        
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                            ControlToValidate="txtPassword"
                            ErrorMessage="Password required" 
                            CssClass="ss-val-text" 
                            Display="Dynamic" 
                            EnableClientScript="false" />
                            
                        <asp:RegularExpressionValidator ID="revPassword" runat="server" 
                            ControlToValidate="txtPassword"
                            ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&^#_\-])[A-Za-z\d@$!%*?&^#_\-]{8,}$"
                            ErrorMessage="Min 8 chars, 1 upper, 1 lower, 1 digit, 1 special" 
                            CssClass="ss-val-text" 
                            Display="Dynamic" 
                            EnableClientScript="false" />
                    </div>
                    <div class="ss-underline-col">
                        <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="ss-underline-input" TextMode="Password" Placeholder="Confirm Password"></asp:TextBox>
                        
                        <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" 
                            ControlToValidate="txtConfirmPassword"
                            ErrorMessage="Confirm required" 
                            CssClass="ss-val-text" 
                            Display="Dynamic" 
                            EnableClientScript="false" />
                            
                        <asp:CompareValidator ID="cvPassword" runat="server" 
                            ControlToValidate="txtConfirmPassword"
                            ControlToCompare="txtPassword" 
                            Operator="Equal" 
                            Type="String"
                            ErrorMessage="Passwords do not match" 
                            CssClass="ss-val-text" 
                            Display="Dynamic" 
                            EnableClientScript="false" />
                    </div>
                </div>

                <!-- Submit Button -->
                <asp:Button ID="btnRegister" runat="server" Text="Register Account &rarr;" CssClass="ss-register-pill-btn" OnClick="btnRegister_Click" />

                <!-- Login Link -->
                <div class="ss-switch-auth">
                    Already have an account? <a href="Login.aspx">Login here</a>
                </div>

            </div>
        </div>
    </div>
</asp:Content>