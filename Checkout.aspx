<%@ Page Title="Checkout" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="Shakti_Sarees.Checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="<%= ResolveUrl("~/Content/Checkout.css?v=1") %>" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="ss-checkout-container">
        
        <!-- Header -->
        <header class="ss-checkout-header">
            <h1 class="ss-checkout-title">Checkout</h1>
            <p class="ss-checkout-subtitle">Complete your order securely.</p>
        </header>

        <div class="ss-checkout-layout">
            
            <!-- ================= LEFT COLUMN: READONLY DETAILS (FROM USERS TABLE) ================= -->
            <div class="ss-checkout-info-col">
                
                <!-- Section 1: Address -->
                <div class="ss-section-header">
                    <div class="ss-sec-icon"><i class="fa-solid fa-location-dot"></i></div>
                    <h2 class="ss-sec-title">Address</h2>
                </div>

                <div class="ss-static-field">
                    <label class="ss-field-lbl">FULL NAME</label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="ss-static-input" ReadOnly="true"></asp:TextBox>
                </div>

                <div class="ss-static-field">
                    <label class="ss-field-lbl">LOCAL ADDRESS</label>
                    <asp:TextBox ID="txtAddress" runat="server" CssClass="ss-static-input" ReadOnly="true"></asp:TextBox>
                </div>

                <div class="ss-static-row">
                    <div class="ss-static-col">
                        <label class="ss-field-lbl">CITY</label>
                        <asp:TextBox ID="txtCity" runat="server" CssClass="ss-static-input" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div class="ss-static-col">
                        <label class="ss-field-lbl">PINCODE</label>
                        <asp:TextBox ID="txtPincode" runat="server" CssClass="ss-static-input" ReadOnly="true"></asp:TextBox>
                    </div>
                </div>

                <!-- Section 2: Contact Information -->
                <div class="ss-section-header ss-sec-spacing">
                    <div class="ss-sec-icon"><i class="fa-solid fa-phone"></i></div>
                    <h2 class="ss-sec-title">Contact Information</h2>
                </div>

                <div class="ss-static-row">
                    <div class="ss-static-col">
                        <label class="ss-field-lbl">MOBILE NUMBER</label>
                        <div class="ss-phone-wrapper">
                            <span class="ss-phone-prefix">+91</span>
                            <asp:TextBox ID="txtMobile" runat="server" CssClass="ss-static-input ss-phone-input" ReadOnly="true"></asp:TextBox>
                        </div>
                    </div>
                    <div class="ss-static-col">
                        <label class="ss-field-lbl">EMAIL ADDRESS</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="ss-static-input" ReadOnly="true"></asp:TextBox>
                    </div>
                </div>

                <div class="ss-profile-note">
                    Go to profile Section to change details.
                </div>

            </div>

            <!-- ================= RIGHT COLUMN: SUMMARY & PAYMENT (FROM CART TABLE) ================= -->
            <div class="ss-checkout-side-col">
                
                <!-- Order Summary Card -->
                <div class="ss-chk-card">
                    <h3 class="ss-chk-card-title">Order Summary</h3>

                    <div class="ss-chk-items">
                        <asp:Repeater ID="rptCheckoutItems" runat="server">
                            <ItemTemplate>
                                <div class="ss-chk-item-row">
                                    <img src='<%# Eval("MainImage") %>' alt='<%# Eval("ProductName") %>' class="ss-chk-item-img" />
                                    <div class="ss-chk-item-meta">
                                        <span class="ss-chk-item-name"><%# Eval("ProductName") %> (x<%# Eval("Quantity") %>)</span>
                                        <span class="ss-chk-item-price">&#8377; <%# Eval("ItemTotal") %></span>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <div class="ss-chk-bill-row">
                        <span>Subtotal</span>
                        <span>&#8377; <asp:Literal ID="litSubtotal" runat="server" Text="0.00"></asp:Literal></span>
                    </div>
                    <div class="ss-chk-bill-row">
                        <span>Shipping</span>
                        <span class="ss-shipping-free">Free</span>
                    </div>
                    <div class="ss-chk-bill-row">
                        <span>Taxes (GST 5%)</span>
                        <span>&#8377; <asp:Literal ID="litTaxes" runat="server" Text="0.00"></asp:Literal></span>
                    </div>

                    <div class="ss-chk-total-row">
                        <span class="ss-chk-total-lbl">Total</span>
                        <span class="ss-chk-total-val">&#8377;<asp:Literal ID="litTotal" runat="server" Text="0.00"></asp:Literal></span>
                    </div>
                </div>

                <!-- Payment Method Card -->
                <div class="ss-chk-card ss-pay-card">
                    <h3 class="ss-chk-card-title ss-pay-title">Payment Method</h3>
                    
                    <label class="ss-pay-option">
                        <input type="radio" id="rbCOD" name="paymentMethod" value="COD" checked="checked" />
                        <span class="ss-pay-text">Cash on Delivery</span>
                        <i class="fa-solid fa-truck ss-pay-icon"></i>
                    </label>
                </div>

                <!-- Place Order Button -->
                <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order Securely &rarr;" CssClass="ss-place-order-btn" OnClick="btnPlaceOrder_Click" />

            </div>

        </div>
    </div>
</asp:Content>