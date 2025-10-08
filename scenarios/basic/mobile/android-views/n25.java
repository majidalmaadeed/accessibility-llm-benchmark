package com.example.uicomponents;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

public class MissingSkipLinkActivity extends Activity {
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        // Create main layout
        ScrollView scrollView = new ScrollView(this);
        LinearLayout mainLayout = new LinearLayout(this);
        mainLayout.setOrientation(LinearLayout.VERTICAL);
        mainLayout.setBackgroundColor(0xFFF5F5F5);
        
        // Header with Navigation - MISSING SKIP LINK
        LinearLayout headerLayout = createHeader();
        mainLayout.addView(headerLayout);
        
        // Navigation Menu - MISSING SKIP LINK
        LinearLayout navLayout = createNavigation();
        mainLayout.addView(navLayout);
        
        // Main Content
        LinearLayout contentLayout = createMainContent();
        mainLayout.addView(contentLayout);
        
        scrollView.addView(mainLayout);
        setContentView(scrollView);
    }
    
    private LinearLayout createHeader() {
        LinearLayout headerLayout = new LinearLayout(this);
        headerLayout.setOrientation(LinearLayout.VERTICAL);
        headerLayout.setBackgroundColor(0xFF1976D2);
        headerLayout.setPadding(32, 32, 32, 32);
        
        TextView titleText = new TextView(this);
        titleText.setText("Electronics Store");
        titleText.setTextSize(24);
        titleText.setTextColor(0xFFFFFFFF);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        
        TextView subtitleText = new TextView(this);
        subtitleText.setText("Your one-stop shop for tech products");
        subtitleText.setTextSize(16);
        subtitleText.setTextColor(0xE6FFFFFF);
        
        headerLayout.addView(titleText);
        headerLayout.addView(subtitleText);
        
        return headerLayout;
    }
    
    private LinearLayout createNavigation() {
        LinearLayout navLayout = new LinearLayout(this);
        navLayout.setOrientation(LinearLayout.HORIZONTAL);
        navLayout.setBackgroundColor(0xFFFFFFFF);
        navLayout.setPadding(16, 16, 16, 16);
        
        String[] navItems = {"Home", "Products", "Services", "About", "Contact"};
        String[] navIcons = {"🏠", "🛍️", "🔧", "ℹ️", "📧"};
        
        for (int i = 0; i < navItems.length; i++) {
            LinearLayout navItem = createNavItem(navIcons[i], navItems[i]);
            LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(0, 
                LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
            navLayout.addView(navItem, params);
        }
        
        return navLayout;
    }
    
    private LinearLayout createNavItem(String icon, String label) {
        LinearLayout itemLayout = new LinearLayout(this);
        itemLayout.setOrientation(LinearLayout.VERTICAL);
        itemLayout.setGravity(android.view.Gravity.CENTER);
        
        TextView iconText = new TextView(this);
        iconText.setText(icon);
        iconText.setTextSize(20);
        iconText.setGravity(android.view.Gravity.CENTER);
        
        TextView labelText = new TextView(this);
        labelText.setText(label);
        labelText.setTextSize(12);
        labelText.setTextColor(0xFF1976D2);
        labelText.setGravity(android.view.Gravity.CENTER);
        
        itemLayout.addView(iconText);
        itemLayout.addView(labelText);
        
        return itemLayout;
    }
    
    private LinearLayout createMainContent() {
        LinearLayout contentLayout = new LinearLayout(this);
        contentLayout.setOrientation(LinearLayout.VERTICAL);
        contentLayout.setPadding(16, 16, 16, 16);
        
        // Hero Section
        LinearLayout heroLayout = createHeroSection();
        contentLayout.addView(heroLayout);
        
        // Products Section
        LinearLayout productsLayout = createProductsSection();
        contentLayout.addView(productsLayout);
        
        // Footer
        LinearLayout footerLayout = createFooter();
        contentLayout.addView(footerLayout);
        
        return contentLayout;
    }
    
    private LinearLayout createHeroSection() {
        LinearLayout heroLayout = new LinearLayout(this);
        heroLayout.setOrientation(LinearLayout.VERTICAL);
        heroLayout.setBackgroundColor(0xFFFFFFFF);
        heroLayout.setPadding(20, 20, 20, 20);
        
        TextView heroTitle = new TextView(this);
        heroTitle.setText("Featured Products");
        heroTitle.setTextSize(20);
        heroTitle.setTypeface(null, android.graphics.Typeface.BOLD);
        heroTitle.setTextColor(0xFF1976D2);
        heroTitle.setPadding(0, 0, 0, 12);
        
        TextView heroText = new TextView(this);
        heroText.setText("Discover our latest collection of cutting-edge technology products designed to enhance your digital lifestyle.");
        heroText.setTextSize(16);
        heroText.setTextColor(0xFF666666);
        
        heroLayout.addView(heroTitle);
        heroLayout.addView(heroText);
        
        return heroLayout;
    }
    
    private LinearLayout createProductsSection() {
        LinearLayout productsLayout = new LinearLayout(this);
        productsLayout.setOrientation(LinearLayout.VERTICAL);
        productsLayout.setBackgroundColor(0xFFFFFFFF);
        productsLayout.setPadding(16, 16, 16, 16);
        
        String[][] products = {
            {"Wireless Headphones", "$99.99", "High-quality wireless headphones with noise cancellation"},
            {"Smart Watch", "$299.99", "Advanced fitness tracking and health monitoring"},
            {"Bluetooth Speaker", "$79.99", "Portable speaker with excellent sound quality"}
        };
        
        for (String[] product : products) {
            LinearLayout productItem = createProductCard(product[0], product[1], product[2]);
            productsLayout.addView(productItem);
        }
        
        return productsLayout;
    }
    
    private LinearLayout createProductCard(String name, String price, String description) {
        LinearLayout cardLayout = new LinearLayout(this);
        cardLayout.setOrientation(LinearLayout.HORIZONTAL);
        cardLayout.setBackgroundColor(0xFFFFFFFF);
        cardLayout.setPadding(16, 16, 16, 16);
        
        // Product Image
        ImageView productImage = new ImageView(this);
        productImage.setImageResource(android.R.drawable.ic_menu_gallery);
        productImage.setBackgroundColor(0xFFE0E0E0);
        productImage.setMinimumWidth(80);
        productImage.setMinimumHeight(80);
        productImage.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
        productImage.setContentDescription("Product image of " + name);
        
        // Product Info
        LinearLayout infoLayout = new LinearLayout(this);
        infoLayout.setOrientation(LinearLayout.VERTICAL);
        infoLayout.setPadding(16, 0, 0, 0);
        
        TextView nameText = new TextView(this);
        nameText.setText(name);
        nameText.setTextSize(18);
        nameText.setTypeface(null, android.graphics.Typeface.BOLD);
        nameText.setTextColor(0xFF1976D2);
        
        TextView descText = new TextView(this);
        descText.setText(description);
        descText.setTextSize(14);
        descText.setTextColor(0xFF666666);
        descText.setPadding(0, 4, 0, 4);
        
        TextView priceText = new TextView(this);
        priceText.setText(price);
        priceText.setTextSize(16);
        priceText.setTypeface(null, android.graphics.Typeface.BOLD);
        priceText.setTextColor(0xFF4CAF50);
        
        infoLayout.addView(nameText);
        infoLayout.addView(descText);
        infoLayout.addView(priceText);
        
        // Action Button
        Button detailsButton = new Button(this);
        detailsButton.setText("View Details");
        detailsButton.setBackgroundColor(0xFF1976D2);
        detailsButton.setTextColor(0xFFFFFFFF);
        detailsButton.setPadding(16, 16, 16, 16);
        
        cardLayout.addView(productImage);
        
        LinearLayout.LayoutParams infoParams = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        cardLayout.addView(infoLayout, infoParams);
        
        LinearLayout.LayoutParams buttonParams = new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.WRAP_CONTENT, 
            LinearLayout.LayoutParams.WRAP_CONTENT);
        cardLayout.addView(detailsButton, buttonParams);
        
        return cardLayout;
    }
    
    private LinearLayout createFooter() {
        LinearLayout footerLayout = new LinearLayout(this);
        footerLayout.setOrientation(LinearLayout.VERTICAL);
        footerLayout.setBackgroundColor(0xFF424242);
        footerLayout.setPadding(20, 20, 20, 20);
        
        TextView footerTitle = new TextView(this);
        footerTitle.setText("Contact Information");
        footerTitle.setTextSize(18);
        footerTitle.setTypeface(null, android.graphics.Typeface.BOLD);
        footerTitle.setTextColor(0xFFFFFFFF);
        footerTitle.setPadding(0, 0, 0, 12);
        
        TextView emailText = new TextView(this);
        emailText.setText("Email: info@electronicsstore.com");
        emailText.setTextSize(14);
        emailText.setTextColor(0xCCFFFFFF);
        emailText.setPadding(0, 0, 0, 4);
        
        TextView phoneText = new TextView(this);
        phoneText.setText("Phone: (555) 123-4567");
        phoneText.setTextSize(14);
        phoneText.setTextColor(0xCCFFFFFF);
        phoneText.setPadding(0, 0, 0, 4);
        
        TextView addressText = new TextView(this);
        addressText.setText("Address: 123 Tech Street, Digital City, DC 12345");
        addressText.setTextSize(14);
        addressText.setTextColor(0xCCFFFFFF);
        
        footerLayout.addView(footerTitle);
        footerLayout.addView(emailText);
        footerLayout.addView(phoneText);
        footerLayout.addView(addressText);
        
        return footerLayout;
    }
}
