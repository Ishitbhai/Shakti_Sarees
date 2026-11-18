<%@ Page Title="Explore Collection" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Categories.aspx.cs" Inherits="Shakti_Sarees.Categories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="<%= ResolveUrl("~/Content/Categories.css?v=1") %>" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="ss-collection-container">
        
        <!-- Header Introduction -->
        <header class="ss-collection-header">
            <h1 class="ss-col-title">Explore Our Collection</h1>
            <p class="ss-col-subtitle">
                Discover handcrafted sarees woven with tradition and elegance, curated for every occasion and style.
            </p>
        </header>

        <!-- 4-Column Collection Grid (100% Dynamic using CategoryImage) -->
        <div class="ss-col-grid">
            <asp:Repeater ID="rptCategories" runat="server">
                <ItemTemplate>
                    <a href='Products.aspx?category=<%# Eval("CategoryID") %>' class="ss-item-card" style="text-decoration:none; color:inherit;">
                        <div class="ss-item-media">
                            <span class="ss-item-badge"><%# Eval("CategoryName").ToString().ToUpper() %></span>
                            <img src='<%# Eval("CategoryImage") %>' alt='<%# Eval("CategoryName") %>' />
                        </div>
                        <div class="ss-item-details">
                            <div class="ss-item-info">
                                <h3 class="ss-item-name"><%# Eval("CategoryName") %></h3>
                                <span class="ss-item-sub">Explore Weaves &rarr;</span>
                            </div>
                        </div>
                    </a>
                </ItemTemplate>
            </asp:Repeater>
        </div>

    </div>
</asp:Content>