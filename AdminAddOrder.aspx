<%@ Page Title="Create Order" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminAddOrder.aspx.cs" Inherits="Shakti_Sarees.AdminAddOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminHead" runat="server">
    <link href="/Content/AdminOrderForm.css?v=1" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div class="ss-aof-viewport">
        <div class="ss-aof-card">

            <!-- Feedback / Validation Error Message -->
            <asp:Label ID="lblMsg" runat="server" CssClass="ss-val-text" Visible="false" style="display:block; margin-bottom:15px; font-weight:600;"></asp:Label>

            <!-- Section 1: Order Details -->
            <div class="ss-aof-section">
                <h2 class="ss-aof-title">Order Details</h2>

                <!-- Row 1: Email & Date -->
                <div class="ss-aof-row">
                    <div class="ss-aof-col">
                        <label class="ss-aof-label">Customer Email</label>
                        <asp:TextBox ID="txtCustomerEmail" runat="server" CssClass="ss-aof-input" Placeholder="Select or enter customer email" list="customerEmailsList" autocomplete="off"></asp:TextBox>
                        
                        <!-- Dynamic Email Suggestions Dropdown -->
                        <datalist id="customerEmailsList">
                            <asp:Repeater ID="rptCustomerEmails" runat="server">
                                <ItemTemplate>
                                    <option value='<%# Eval("Email") %>'><%# Eval("FullName") %> (<%# Eval("Role") %>)</option>
                                </ItemTemplate>
                            </asp:Repeater>
                        </datalist>

                        <asp:RequiredFieldValidator ID="rfvCustomerEmail" runat="server"
                            ControlToValidate="txtCustomerEmail"
                            ErrorMessage="Customer email is required"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                        <asp:RegularExpressionValidator ID="revCustomerEmail" runat="server"
                            ControlToValidate="txtCustomerEmail"
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                            ErrorMessage="Enter a valid email address"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                    </div>

                    <div class="ss-aof-col">
                        <label class="ss-aof-label">Order Date</label>
                        <asp:TextBox ID="txtOrderDate" runat="server" CssClass="ss-aof-input" TextMode="Date"></asp:TextBox>
                        
                        <asp:RequiredFieldValidator ID="rfvOrderDate" runat="server"
                            ControlToValidate="txtOrderDate"
                            ErrorMessage="Order date is required"
                            CssClass="ss-val-text"
                            Display="Dynamic"
                            EnableClientScript="false" />
                    </div>
                </div>

                <!-- Row 2: Status & Total Amount -->
                <div class="ss-aof-row">
                    <div class="ss-aof-col">
                        <label class="ss-aof-label">Order Status</label>
                        <asp:DropDownList ID="ddlOrderStatus" runat="server" CssClass="ss-aof-select">
                            <asp:ListItem Text="Pending" Value="Pending" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Processing" Value="Processing"></asp:ListItem>
                            <asp:ListItem Text="Shipped" Value="Shipped"></asp:ListItem>
                            <asp:ListItem Text="Delivered" Value="Delivered"></asp:ListItem>
                            <asp:ListItem Text="Cancelled" Value="Cancelled"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="ss-aof-col">
                        <label class="ss-aof-label">Total Amount (&#8377;)</label>
                        <asp:TextBox ID="txtTotalAmount" runat="server" CssClass="ss-aof-input ss-input-readonly" ReadOnly="true" Text="0.00"></asp:TextBox>
                        <span class="ss-aof-hint">Auto-calculated from products</span>
                    </div>
                </div>
            </div>

            <!-- Section 2: Products Breakdown (100% Dynamic Multi-Row Repeater) -->
            <div class="ss-aof-section ss-products-sec">
                <div class="ss-prod-head-strip">
                    <h2 class="ss-aof-title">Products</h2>
                    <asp:LinkButton ID="btnAddRow" runat="server" CssClass="ss-btn-add-item" OnClick="btnAddRow_Click" CausesValidation="false">
                        + Add Product
                    </asp:LinkButton>
                </div>

                <div class="ss-prod-table-box">
                    <!-- Column Headers -->
                    <div class="ss-prod-table-head">
                        <span class="ss-pcol-id">Product ID</span>
                        <span class="ss-pcol-qty">Quantity</span>
                        <span class="ss-pcol-price">Price (&#8377;)</span>
                        <span class="ss-pcol-act">Action</span>
                    </div>

                    <asp:Repeater ID="rptOrderItems" runat="server">
                        <ItemTemplate>
                            <div class="ss-prod-table-row">
                                <div class="ss-pcol-id">
                                    <asp:TextBox ID="txtProductID" runat="server" CssClass="ss-aof-input" Placeholder="Enter product ID"
                                        Text='<%# Eval("ProductID") %>' AutoPostBack="true" OnTextChanged="txtProductID_TextChanged"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvProductID" runat="server"
                                        ControlToValidate="txtProductID"
                                        ErrorMessage="Product ID is required"
                                        CssClass="ss-val-text"
                                        Display="Dynamic"
                                        EnableClientScript="false" />
                                </div>

                                <div class="ss-pcol-qty">
                                    <asp:TextBox ID="txtQuantity" runat="server" CssClass="ss-aof-input ss-txt-center"
                                        Text='<%# Eval("Quantity") %>' AutoPostBack="true" OnTextChanged="txtItemField_TextChanged"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvQuantity" runat="server"
                                        ControlToValidate="txtQuantity"
                                        ErrorMessage="Required"
                                        CssClass="ss-val-text"
                                        Display="Dynamic"
                                        EnableClientScript="false" />
                                    <asp:RegularExpressionValidator ID="revQuantity" runat="server"
                                        ControlToValidate="txtQuantity"
                                        ValidationExpression="^[1-9][0-9]*$"
                                        ErrorMessage="Min 1"
                                        CssClass="ss-val-text"
                                        Display="Dynamic"
                                        EnableClientScript="false" />
                                </div>

                                <div class="ss-pcol-price">
                                    <asp:TextBox ID="txtItemPrice" runat="server" CssClass="ss-aof-input" Placeholder="0.00"
                                        Text='<%# Eval("Price") %>' AutoPostBack="true" OnTextChanged="txtItemField_TextChanged"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvItemPrice" runat="server"
                                        ControlToValidate="txtItemPrice"
                                        ErrorMessage="Price required"
                                        CssClass="ss-val-text"
                                        Display="Dynamic"
                                        EnableClientScript="false" />
                                    <asp:RegularExpressionValidator ID="revItemPrice" runat="server"
                                        ControlToValidate="txtItemPrice"
                                        ValidationExpression="^[0-9]+(\.[0-9]{1,2})?$"
                                        ErrorMessage="Invalid price"
                                        CssClass="ss-val-text"
                                        Display="Dynamic"
                                        EnableClientScript="false" />
                                </div>

                                <div class="ss-pcol-act">
                                    <asp:LinkButton ID="btnRemoveRow" runat="server" CssClass="ss-prow-delete"
                                        OnClick="btnRemoveRow_Click" CommandArgument='<%# Container.ItemIndex %>' CausesValidation="false"
                                        OnClientClick="return confirm('Are you sure you want to remove this product row?');"
                                        ToolTip="Remove Item">
                                        <i class="fa-regular fa-trash-can"></i>
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                </div>
            </div>

            <!-- Footer Actions -->
            <div class="ss-aof-actions">
                <a href="AdminOrders.aspx" class="ss-aof-cancel-btn">Cancel</a>
                <asp:Button ID="btnCreateOrder" runat="server" Text="Create Order" CssClass="ss-aof-create-btn" OnClick="btnCreateOrder_Click" />
            </div>

        </div>
    </div>
</asp:Content>