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
            
            <!-- Left Column: Items List -->
            <div class="ss-cart-items-col">
                
                <!-- Table Header Labels -->
                <div class="ss-cart-table-head">
                    <span class="ss-th-prod">PRODUCT</span>
                    <span class="ss-th-price">PRICE</span>
                    <span class="ss-th-qty">QUANTITY</span>
                    <span class="ss-th-total">TOTAL</span>
                </div>

                <!-- Cart Item Card 1 -->
                <div class="ss-cart-item-card">
                    <div class="ss-item-prod-cell">
                        <div class="ss-item-thumb">
                            <img src="/images/cart_1.png" alt="Royal Maroon" />
                        </div>
                        <div class="ss-item-meta">
                            <span class="ss-badge-silk">BANARASI SILK</span>
                            <h3 class="ss-cart-item-title">Royal Maroon<br />Zari Woven Saree</h3>
                            <asp:LinkButton ID="btnRemove1" runat="server" CssClass="ss-remove-btn" OnClick="btnRemoveItem_Click" CommandArgument="1">
                                <i class="fa-regular fa-trash-can"></i> REMOVE
                            </asp:LinkButton>
                        </div>
                    </div>
                    <div class="ss-item-price-cell">&#8377;12,499</div>
                    <div class="ss-item-qty-cell">
                        <div class="ss-qty-stepper">
                            <asp:Button ID="btnMinus1" runat="server" Text="&minus;" CssClass="ss-step-btn" OnClick="btnMinus_Click" CommandArgument="1" />
                            <asp:Label ID="lblQty1" runat="server" Text="1" CssClass="ss-step-val"></asp:Label>
                            <asp:Button ID="btnPlus1" runat="server" Text="+" CssClass="ss-step-btn" OnClick="btnPlus_Click" CommandArgument="1" />
                        </div>
                    </div>
                    <div class="ss-item-total-cell">&#8377;12,499</div>
                </div>

                <!-- Cart Item Card 2 -->
                <div class="ss-cart-item-card">
                    <div class="ss-item-prod-cell">
                        <div class="ss-item-thumb">
                            <img src="/images/cart_2.png" alt="Emerald Green" />
                        </div>
                        <div class="ss-item-meta">
                            <span class="ss-badge-kanchi">KANCHIPURAM</span>
                            <h3 class="ss-cart-item-title">Emerald Green<br />Peacock Border</h3>
                            <asp:LinkButton ID="btnRemove2" runat="server" CssClass="ss-remove-btn" OnClick="btnRemoveItem_Click" CommandArgument="2">
                                <i class="fa-regular fa-trash-can"></i> REMOVE
                            </asp:LinkButton>
                        </div>
                    </div>
                    <div class="ss-item-price-cell">&#8377;18,950</div>
                    <div class="ss-item-qty-cell">
                        <div class="ss-qty-stepper">
                            <asp:Button ID="btnMinus2" runat="server" Text="&minus;" CssClass="ss-step-btn" OnClick="btnMinus_Click" CommandArgument="2" />
                            <asp:Label ID="lblQty2" runat="server" Text="2" CssClass="ss-step-val"></asp:Label>
                            <asp:Button ID="btnPlus2" runat="server" Text="+" CssClass="ss-step-btn" OnClick="btnPlus_Click" CommandArgument="2" />
                        </div>
                    </div>
                    <div class="ss-item-total-cell">&#8377;37,900</div>
                </div>

                <!-- Return Link -->
                <div class="ss-continue-wrap">
                    <a href="Products.aspx" class="ss-continue-btn">&larr; Continue Shopping</a>
                </div>

            </div>

            <!-- Right Column: Order Summary Card -->
            <aside class="ss-cart-summary-col">
                <div class="ss-summary-card">
                    <h2 class="ss-summary-title">Order Summary</h2>

                    <div class="ss-summary-row">
                        <span class="ss-sum-label">Subtotal (3 items)</span>
                        <span class="ss-sum-val">&#8377;50,399</span>
                    </div>

                    <div class="ss-summary-row">
                        <span class="ss-sum-label">Taxes</span>
                        <span class="ss-sum-val">&#8377;1,035</span>
                    </div>

                    <hr class="ss-sum-divider" />

                    <div class="ss-total-row">
                        <span class="ss-total-label">Total</span>
                        <span class="ss-total-val">&#8377;51,434</span>
                    </div>

                    <asp:Button ID="btnCheckout" runat="server" Text="Proceed to Checkout &rarr;" CssClass="ss-checkout-btn" OnClick="btnCheckout_Click" />
                </div>
            </aside>

        </div>
    </div>
</asp:Content>