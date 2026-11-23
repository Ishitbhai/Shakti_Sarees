<%@ Page Title="Your Cart" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="Shakti_Sarees.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="<%= ResolveUrl("~/Content/Cart.css?v=1") %>" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="ss-cart-viewport">
        
        <!-- Header -->
        <header class="ss-cart-page-header">
            <h1 class="ss-cart-title">Your Cart</h1>
            <p class="ss-cart-desc">Review your selected items before proceeding to checkout.</p>
        </header>

        <!-- Main Content Layout -->
        <div class="ss-cart-layout">
            
            <!-- Left Column: Items List (100% Dynamic from Cart Table) -->
            <div class="ss-cart-items-col">
                
                <!-- Table Header Labels -->
                <div class="ss-cart-table-head">
                    <span class="ss-th-prod">PRODUCT</span>
                    <span class="ss-th-price">PRICE</span>
                    <span class="ss-th-qty">QUANTITY</span>
                    <span class="ss-th-total">TOTAL</span>
                </div>

                <asp:Repeater ID="rptCartItems" runat="server">
                    <ItemTemplate>
                        <div class="ss-cart-item-card">
                            <div class="ss-item-prod-cell">
                                <div class="ss-item-thumb">
                                    <img src='<%# Eval("MainImage") %>' alt='<%# Eval("ProductName") %>' />
                                </div>
                                <div class="ss-item-meta">
                                    <span class="ss-badge-silk"><%# Eval("CategoryName").ToString().ToUpper() %></span>
                                    <h3 class="ss-cart-item-title"><%# Eval("ProductName") %></h3>
                                    <asp:LinkButton ID="btnRemove" runat="server" CssClass="ss-remove-btn" OnClick="btnRemoveItem_Click" CommandArgument='<%# Eval("CartID") %>'>
                                        <i class="fa-regular fa-trash-can"></i> REMOVE
                                    </asp:LinkButton>
                                </div>
                            </div>
                            <div class="ss-item-price-cell">&#8377;<%# Eval("Price") %></div>
                            <div class="ss-item-qty-cell">
                                <div class="ss-qty-stepper">
                                    <asp:Button ID="btnMinus" runat="server" Text="&minus;" CssClass="ss-step-btn" OnClick="btnMinus_Click" CommandArgument='<%# Eval("CartID") %>' />
                                    <asp:Label ID="lblQty" runat="server" Text='<%# Eval("Quantity") %>' CssClass="ss-step-val"></asp:Label>
                                    <asp:Button ID="btnPlus" runat="server" Text="+" CssClass="ss-step-btn" OnClick="btnPlus_Click" CommandArgument='<%# Eval("CartID") %>' />
                                </div>
                            </div>
                            <div class="ss-item-total-cell">&#8377;<%# Eval("ItemTotal") %></div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <!-- Return Link -->
                <div class="ss-continue-wrap">
                    <a href="Products.aspx" class="ss-continue-btn">&larr; Continue Shopping</a>
                </div>

            </div>

            <!-- Right Column: Order Summary Card (100% Dynamic) -->
            <aside class="ss-cart-summary-col">
                <div class="ss-summary-card">
                    <h2 class="ss-summary-title">Order Summary</h2>

                    <div class="ss-summary-row">
                        <span class="ss-sum-label">
                            Subtotal (<asp:Literal ID="litItemCount" runat="server" Text="0"></asp:Literal> items)
                        </span>
                        <span class="ss-sum-val">&#8377;<asp:Literal ID="litSubtotal" runat="server" Text="0.00"></asp:Literal></span>
                    </div>

                    <div class="ss-summary-row">
                        <span class="ss-sum-label">Taxes</span>
                        <span class="ss-sum-val">&#8377;<asp:Literal ID="litTaxes" runat="server" Text="0.00"></asp:Literal></span>
                    </div>

                    <hr class="ss-sum-divider" />

                    <div class="ss-total-row">
                        <span class="ss-total-label">Total</span>
                        <span class="ss-total-val">&#8377;<asp:Literal ID="litFinalTotal" runat="server" Text="0.00"></asp:Literal></span>
                    </div>

                    <asp:Button ID="btnCheckout" runat="server" Text="Proceed to Checkout &rarr;" CssClass="ss-checkout-btn" OnClick="btnCheckout_Click" />
                </div>
            </aside>

        </div>
    </div>
</asp:Content>