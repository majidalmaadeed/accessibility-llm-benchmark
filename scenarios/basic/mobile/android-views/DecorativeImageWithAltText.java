package com.example.accessibilityscenarios;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

public class DecorativeImageWithAltTextActivity extends Activity {
    
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
        
        // Products List
        LinearLayout productsLayout = createProductsList();
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
        titleText.setText("Product Catalog");
        titleText.setTextSize(24);
        titleText.setTextColor(0xFFFFFFFF);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        
        TextView subtitleText = new TextView(this);
        subtitleText.setText("Discover our latest products");
        subtitleText.setTextSize(16);
        subtitleText.setTextColor(0xE6FFFFFF);
        
        headerLayout.addView(titleText);
        headerLayout.addView(subtitleText);
        
        return headerLayout;
    }
    
    private LinearLayout createProductsList() {
        LinearLayout productsLayout = new LinearLayout(this);
        productsLayout.setOrientation(LinearLayout.VERTICAL);
        productsLayout.setBackgroundColor(0xFFFFFFFF);
        productsLayout.setPadding(16, 16, 16, 16);
        
        String[][] products = {
            {"Premium Headphones", "$199.99", "High-quality wireless headphones with noise cancellation", "4.8", "324"},
            {"Smart Watch", "$299.99", "Advanced fitness tracking and health monitoring", "4.6", "156"},
            {"Bluetooth Speaker", "$89.99", "Portable speaker with excellent sound quality", "4.4", "89"}
        };
        
        for (String[] product : products) {
            LinearLayout productItem = createProductCard(product[0], product[1], product[2], product[3], product[4]);
            productsLayout.addView(productItem);
        }
        
        return productsLayout;
    }
    
    private LinearLayout createProductCard(String name, String price, String description, String rating, String reviews) {
        LinearLayout cardLayout = new LinearLayout(this);
        cardLayout.setOrientation(LinearLayout.VERTICAL);
        cardLayout.setBackgroundColor(0xFFFFFFFF);
        cardLayout.setPadding(16, 16, 16, 16);
        
        // Product Image with Decorative Border
        LinearLayout imageContainer = new LinearLayout(this);
        imageContainer.setOrientation(LinearLayout.VERTICAL);
        imageContainer.setBackgroundColor(0xFFE0E0E0);
        imageContainer.setMinimumHeight(200);
        imageContainer.setGravity(android.view.Gravity.CENTER);
        
        // Main product image placeholder
        ImageView productImage = new ImageView(this);
        productImage.setImageResource(android.R.drawable.ic_menu_gallery);
        productImage.setContentDescription("Product image of " + name);
        productImage.setPadding(16, 16, 16, 16);
        
        // Decorative border images - UNNECESSARY DESCRIPTIVE ALT TEXT
        LinearLayout decorativeLayout = new LinearLayout(this);
        decorativeLayout.setOrientation(LinearLayout.VERTICAL);
        decorativeLayout.setPadding(8, 8, 8, 8);
        
        // Decorative corner ornaments - UNNECESSARY DESCRIPTIVE ALT TEXT
        ImageView star1 = new ImageView(this);
        star1.setImageResource(android.R.drawable.btn_star_big_on);
        star1.setContentDescription("Decorative star ornament in the top left corner of the product image border"); // UNNECESSARY: Too descriptive for decorative element
        star1.setPadding(4, 4, 4, 4);
        
        ImageView star2 = new ImageView(this);
        star2.setImageResource(android.R.drawable.btn_star_big_on);
        star2.setContentDescription("Decorative star ornament in the top right corner of the product image border"); // UNNECESSARY: Too descriptive for decorative element
        star2.setPadding(4, 4, 4, 4);
        
        ImageView star3 = new ImageView(this);
        star3.setImageResource(android.R.drawable.btn_star_big_on);
        star3.setContentDescription("Decorative star ornament in the bottom left corner of the product image border"); // UNNECESSARY: Too descriptive for decorative element
        star3.setPadding(4, 4, 4, 4);
        
        ImageView star4 = new ImageView(this);
        star4.setImageResource(android.R.drawable.btn_star_big_on);
        star4.setContentDescription("Decorative star ornament in the bottom right corner of the product image border"); // UNNECESSARY: Too descriptive for decorative element
        star4.setPadding(4, 4, 4, 4);
        
        decorativeLayout.addView(star1);
        decorativeLayout.addView(star2);
        decorativeLayout.addView(star3);
        decorativeLayout.addView(star4);
        
        imageContainer.addView(productImage);
        imageContainer.addView(decorativeLayout);
        
        // Product Info
        LinearLayout infoLayout = new LinearLayout(this);
        infoLayout.setOrientation(LinearLayout.VERTICAL);
        infoLayout.setPadding(0, 16, 0, 0);
        
        TextView nameText = new TextView(this);
        nameText.setText(name);
        nameText.setTextSize(18);
        nameText.setTypeface(null, android.graphics.Typeface.BOLD);
        nameText.setPadding(0, 0, 0, 4);
        
        TextView descriptionText = new TextView(this);
        descriptionText.setText(description);
        descriptionText.setTextSize(14);
        descriptionText.setTextColor(0xFF666666);
        descriptionText.setPadding(0, 0, 0, 8);
        
        // Rating
        LinearLayout ratingLayout = new LinearLayout(this);
        ratingLayout.setOrientation(LinearLayout.HORIZONTAL);
        ratingLayout.setPadding(0, 0, 0, 12);
        
        TextView ratingText = new TextView(this);
        ratingText.setText(rating + " ⭐");
        ratingText.setTextSize(14);
        ratingText.setTextColor(0xFF666666);
        
        TextView reviewsText = new TextView(this);
        reviewsText.setText("(" + reviews + " reviews)");
        reviewsText.setTextSize(14);
        reviewsText.setTextColor(0xFF666666);
        reviewsText.setPadding(8, 0, 0, 0);
        
        ratingLayout.addView(ratingText);
        ratingLayout.addView(reviewsText);
        
        // Price and Action
        LinearLayout priceActionLayout = new LinearLayout(this);
        priceActionLayout.setOrientation(LinearLayout.HORIZONTAL);
        
        TextView priceText = new TextView(this);
        priceText.setText(price);
        priceText.setTextSize(20);
        priceText.setTypeface(null, android.graphics.Typeface.BOLD);
        priceText.setTextColor(0xFF4CAF50);
        
        Button addToCartButton = new Button(this);
        addToCartButton.setText("Add to Cart");
        addToCartButton.setBackgroundColor(0xFF4CAF50);
        addToCartButton.setTextColor(0xFFFFFFFF);
        addToCartButton.setPadding(16, 16, 16, 16);
        
        LinearLayout.LayoutParams priceParams = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        priceActionLayout.addView(priceText, priceParams);
        
        LinearLayout.LayoutParams buttonParams = new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.WRAP_CONTENT, 
            LinearLayout.LayoutParams.WRAP_CONTENT);
        priceActionLayout.addView(addToCartButton, buttonParams);
        
        infoLayout.addView(nameText);
        infoLayout.addView(descriptionText);
        infoLayout.addView(ratingLayout);
        infoLayout.addView(priceActionLayout);
        
        cardLayout.addView(imageContainer);
        cardLayout.addView(infoLayout);
        
        return cardLayout;
    }
}
