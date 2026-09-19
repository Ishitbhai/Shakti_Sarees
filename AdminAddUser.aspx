<%@ Page Title="Add New User" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminAddUser.aspx.cs" Inherits="Shakti_Sarees.AdminAddUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHead" runat="server">
    <link href="/Content/AdminUserForm.css?v=1" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="ss-auf-viewport">
        
        <!-- Header -->
        <h1 class="ss-auf-title">Add New User</h1>

        <!-- Form Card Container -->
        <div class="ss-auf-card">

            <!-- Full Name -->
            <div class="ss-auf-field">
                <label class="ss-auf-label">Full Name</label>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="ss-auf-input" Placeholder="Enter Full Name"></asp:TextBox>
                
                <asp:RequiredFieldValidator ID="rfvFullName" runat="server"
                    ControlToValidate="txtFullName"
                    ErrorMessage="Full Name is required"
                    CssClass="ss-val-text"
                    Display="Dynamic"
                    EnableClientScript="false" />
                <asp:RegularExpressionValidator ID="revFullName" runat="server"
                    ControlToValidate="txtFullName"
                    ValidationExpression="^[a-zA-Z\s]{3,60}$"
                    ErrorMessage="Enter a valid name (letters only, min 3 chars)"
                    CssClass="ss-val-text"
                    Display="Dynamic"
                    EnableClientScript="false" />
            </div>

            <!-- Email -->
            <div class="ss-auf-field">
                <label class="ss-auf-label">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="ss-auf-input" Placeholder="Enter Email Address"></asp:TextBox>
                
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

            <!-- Contact Number -->
            <div class="ss-auf-field">
                <label class="ss-auf-label">Contact Number</label>
                <asp:TextBox ID="txtContactNumber" runat="server" CssClass="ss-auf-input" Placeholder="Enter mobile Number"></asp:TextBox>
                
                <asp:RequiredFieldValidator ID="rfvContactNumber" runat="server"
                    ControlToValidate="txtContactNumber"
                    ErrorMessage="Contact number is required"
                    CssClass="ss-val-text"
                    Display="Dynamic"
                    EnableClientScript="false" />
                <asp:RegularExpressionValidator ID="revContactNumber" runat="server"
                    ControlToValidate="txtContactNumber"
                    ValidationExpression="^[6-9]\d{9}$"
                    ErrorMessage="Enter a valid 10-digit Indian mobile number"
                    CssClass="ss-val-text"
                    Display="Dynamic"
                    EnableClientScript="false" />
            </div>

            <!-- Local Address -->
            <div class="ss-auf-field">
                <label class="ss-auf-label">Local Address</label>
                <asp:TextBox ID="txtLocalAddress" runat="server" CssClass="ss-auf-input" Placeholder="Enter Local Address"></asp:TextBox>
                
                <asp:RequiredFieldValidator ID="rfvLocalAddress" runat="server"
                    ControlToValidate="txtLocalAddress"
                    ErrorMessage="Local address is required"
                    CssClass="ss-val-text"
                    Display="Dynamic"
                    EnableClientScript="false" />
            </div>

            <!-- City & Pin Code Row -->
            <div class="ss-auf-row">
                <div class="ss-auf-col">
                    <label class="ss-auf-label">City</label>
                    <asp:TextBox ID="txtCity" runat="server" CssClass="ss-auf-input" Placeholder="Enter City"></asp:TextBox>
                    
                    <asp:RequiredFieldValidator ID="rfvCity" runat="server"
                        ControlToValidate="txtCity"
                        ErrorMessage="City is required"
                        CssClass="ss-val-text"
                        Display="Dynamic"
                        EnableClientScript="false" />
                </div>

                <div class="ss-auf-col">
                    <label class="ss-auf-label">Pin code</label>
                    <asp:TextBox ID="txtPinCode" runat="server" CssClass="ss-auf-input" Placeholder="Enter Pin code"></asp:TextBox>
                    
                    <asp:RequiredFieldValidator ID="rfvPinCode" runat="server"
                        ControlToValidate="txtPinCode"
                        ErrorMessage="Pin code is required"
                        CssClass="ss-val-text"
                        Display="Dynamic"
                        EnableClientScript="false" />
                    <asp:RegularExpressionValidator ID="revPinCode" runat="server"
                        ControlToValidate="txtPinCode"
                        ValidationExpression="^\d{6}$"
                        ErrorMessage="Enter a valid 6-digit pin code"
                        CssClass="ss-val-text"
                        Display="Dynamic"
                        EnableClientScript="false" />
                </div>
            </div>

            <!-- Password & Role Row -->
            <div class="ss-auf-row">
                <div class="ss-auf-col">
                    <label class="ss-auf-label">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="ss-auf-input" Placeholder="Enter Password"></asp:TextBox>
                    
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                        ControlToValidate="txtPassword"
                        ErrorMessage="Password is required"
                        CssClass="ss-val-text"
                        Display="Dynamic"
                        EnableClientScript="false" />
                    <asp:RegularExpressionValidator ID="revPassword" runat="server"
                        ControlToValidate="txtPassword"
                        ValidationExpression="^.{6,20}$"
                        ErrorMessage="Password must be between 6 and 20 characters"
                        CssClass="ss-val-text"
                        Display="Dynamic"
                        EnableClientScript="false" />
                </div>

                <div class="ss-auf-col">
                    <label class="ss-auf-label">Role</label>
                    <asp:DropDownList ID="ddlRole" runat="server" CssClass="ss-auf-select">
                        <asp:ListItem Text="Admin" Value="Admin" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Customer" Value="Customer"></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>

            <!-- Status Radios -->
            <div class="ss-auf-field ss-auf-status-group">
                <label class="ss-auf-label">Status</label>
                <div class="ss-auf-radio-row">
                    <label class="ss-auf-radio-opt">
                        <input type="radio" id="rbActive" name="userStatus" value="Active" checked="checked" />
                        <span>Active</span>
                    </label>
                    <label class="ss-auf-radio-opt">
                        <input type="radio" id="rbInactive" name="userStatus" value="Inactive" />
                        <span>Inactive</span>
                    </label>
                </div>
            </div>

            <!-- Footer Actions -->
            <div class="ss-auf-actions">
                <a href="AdminUsers.aspx" class="ss-auf-cancel-btn">Cancel</a>
                <asp:LinkButton ID="btnAddUser" runat="server" CssClass="ss-auf-submit-btn" OnClick="btnAddUser_Click">
                    Add User &rarr;
                </asp:LinkButton>
            </div>

        </div>

    </div>
</asp:Content>