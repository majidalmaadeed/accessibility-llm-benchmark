package com.example.accessibilityscenarios;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

public class MissingImageAltTextActivity extends Activity {
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        // Create main layout
        ScrollView scrollView = new ScrollView(this);
        LinearLayout mainLayout = new LinearLayout(this);
        mainLayout.setOrientation(LinearLayout.VERTICAL);
        mainLayout.setPadding(32, 32, 32, 32);
        mainLayout.setBackgroundColor(0xFFF5F5F5);
        
        // Header
        LinearLayout headerLayout = createHeader();
        mainLayout.addView(headerLayout);
        
        // Search and Filter
        LinearLayout searchLayout = createSearchFilter();
        mainLayout.addView(searchLayout);
        
        // Products Grid
        LinearLayout productsLayout = createProductsGrid();
        mainLayout.addView(productsLayout);
        
        scrollView.addView(mainLayout);
        setContentView(scrollView);
    }
    
    private LinearLayout createHeader() {
        LinearLayout headerLayout = new LinearLayout(this);
        headerLayout.setOrientation(LinearLayout.VERTICAL);
        headerLayout.setBackgroundColor(0xFF4CAF50);
        headerLayout.setPadding(32, 32, 32, 32);
        
        TextView titleText = new TextView(this);
        titleText.setText("Electronics Store");
        titleText.setTextSize(24);
        titleText.setTextColor(0xFFFFFFFF);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        
        TextView subtitleText = new TextView(this);
        subtitleText.setText("Best deals on tech products");
        subtitleText.setTextSize(16);
        subtitleText.setTextColor(0xE6FFFFFF);
        
        headerLayout.addView(titleText);
        headerLayout.addView(subtitleText);
        
        return headerLayout;
    }
    
    private LinearLayout createSearchFilter() {
        LinearLayout searchLayout = new LinearLayout(this);
        searchLayout.setOrientation(LinearLayout.HORIZONTAL);
        searchLayout.setBackgroundColor(0xFFFFFFFF);
        searchLayout.setPadding(16, 16, 16, 16);
        
        TextView searchText = new TextView(this);
        searchText.setText("Search products...");
        searchText.setTextSize(16);
        searchText.setTextColor(0xFF666666);
        searchText.setPadding(16, 16, 16, 16);
        searchText.setBackgroundColor(0xFFF0F0F0);
        
        Button filterButton = new Button(this);
        filterButton.setText("Filter");
        filterButton.setBackgroundColor(0xFF2196F3);
        filterButton.setTextColor(0xFFFFFFFF);
        filterButton.setPadding(16, 16, 16, 16);
        
        LinearLayout.LayoutParams searchParams = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        searchLayout.addView(searchText, searchParams);
        
        LinearLayout.LayoutParams buttonParams = new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.WRAP_CONTENT, 
            LinearLayout.LayoutParams.WRAP_CONTENT);
        buttonParams.setMargins(16, 0, 0, 0);
        searchLayout.addView(filterButton, buttonParams);
        
        return searchLayout;
    }
    
    private LinearLayout createProductsGrid() {
        LinearLayout productsLayout = new LinearLayout(this);
        productsLayout.setOrientation(LinearLayout.VERTICAL);
        productsLayout.setBackgroundColor(0xFFFFFFFF);
        productsLayout.setPadding(16, 16, 16, 16);
        
        String[] productNames = {
            "Wireless Headphones", "Smart Watch", "Bluetooth Speaker", 
            "Gaming Mouse", "Mechanical Keyboard"
        };
        String[] productPrices = {"$99.99", "$299.99", "$79.99", "$59.99", "$129.99"};
        String[] productRatings = {"4.5", "4.8", "4.3", "4.6", "4.7"};
        
        for (int i = 0; i < productNames.length; i++) {
            LinearLayout productItem = createProductCard(
                productNames[i], productPrices[i], productRatings[i]);
            productsLayout.addView(productItem);
        }
        
        return productsLayout;
    }
    
    private LinearLayout createProductCard(String name, String price, String rating) {
        LinearLayout cardLayout = new LinearLayout(this);
        cardLayout.setOrientation(LinearLayout.VERTICAL);
        cardLayout.setBackgroundColor(0xFFFFFFFF);
        cardLayout.setPadding(16, 16, 16, 16);
        
        // Product Image - MISSING ALT TEXT
        ImageView productImage = new ImageView(this);
        productImage.setImageResource(android.R.drawable.ic_menu_gallery);
        productImage.setBackgroundColor(0xFFE0E0E0);
        productImage.setMinimumHeight(200);
        productImage.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
        productImage.setContentDescription(null); // MISSING: No alternative text for product image
        
        // Product Info
        LinearLayout infoLayout = new LinearLayout(this);
        infoLayout.setOrientation(LinearLayout.VERTICAL);
        infoLayout.setPadding(0, 16, 0, 0);
        
        TextView nameText = new TextView(this);
        nameText.setText(name);
        nameText.setTextSize(18);
        nameText.setTypeface(null, android.graphics.Typeface.BOLD);
        nameText.setPadding(0, 0, 0, 8);
        
        // Rating
        LinearLayout ratingLayout = new LinearLayout(this);
        ratingLayout.setOrientation(LinearLayout.HORIZONTAL);
        
        TextView ratingText = new TextView(this);
        ratingText.setText(rating + " ⭐");
        ratingText.setTextSize(14);
        ratingText.setTextColor(0xFF666666);
        
        TextView reviewsText = new TextView(this);
        reviewsText.setText("(128 reviews)");
        reviewsText.setTextSize(14);
        reviewsText.setTextColor(0xFF666666);
        reviewsText.setPadding(8, 0, 0, 0);
        
        ratingLayout.addView(ratingText);
        ratingLayout.addView(reviewsText);
        
        // Price
        LinearLayout priceLayout = new LinearLayout(this);
        priceLayout.setOrientation(LinearLayout.HORIZONTAL);
        priceLayout.setPadding(0, 8, 0, 16);
        
        TextView priceText = new TextView(this);
        priceText.setText(price);
        priceText.setTextSize(20);
        priceText.setTypeface(null, android.graphics.Typeface.BOLD);
        priceText.setTextColor(0xFF4CAF50);
        
        TextView originalPriceText = new TextView(this);
        originalPriceText.setText("$149.99");
        originalPriceText.setTextSize(16);
        originalPriceText.setTextColor(0xFF666666);
        originalPriceText.setPadding(8, 0, 0, 0);
        
        priceLayout.addView(priceText);
        priceLayout.addView(originalPriceText);
        
        // Action Buttons
        LinearLayout buttonLayout = new LinearLayout(this);
        buttonLayout.setOrientation(LinearLayout.HORIZONTAL);
        
        Button addToCartButton = new Button(this);
        addToCartButton.setText("Add to Cart");
        addToCartButton.setBackgroundColor(0xFF4CAF50);
        addToCartButton.setTextColor(0xFFFFFFFF);
        addToCartButton.setPadding(16, 16, 16, 16);
        
        Button wishlistButton = new Button(this);
        wishlistButton.setText("Wishlist");
        wishlistButton.setBackgroundColor(0xFFFFFFFF);
        wishlistButton.setTextColor(0xFF2196F3);
        wishlistButton.setPadding(16, 16, 16, 16);
        
        LinearLayout.LayoutParams buttonParams = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        buttonParams.setMargins(0, 0, 8, 0);
        buttonLayout.addView(addToCartButton, buttonParams);
        
        LinearLayout.LayoutParams wishlistParams = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        wishlistParams.setMargins(8, 0, 0, 0);
        buttonLayout.addView(wishlistButton, wishlistParams);
        
        infoLayout.addView(nameText);
        infoLayout.addView(ratingLayout);
        infoLayout.addView(priceLayout);
        infoLayout.addView(buttonLayout);
        
        cardLayout.addView(productImage);
        cardLayout.addView(infoLayout);
        
        return cardLayout;
    }
}
