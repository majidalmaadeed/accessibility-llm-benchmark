package com.example.accessibilityscenarios;

import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

public class FlashingAdvertisementActivity extends Activity {
    
    private TextView flashText;
    private TextView flashCountText;
    private boolean flashState = true;
    private int flashCount = 0;
    private Handler handler = new Handler();
    private Runnable flashRunnable;
    
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
        
        // Flashing Sale Banner - FLASHING 5 TIMES PER SECOND
        LinearLayout bannerLayout = createFlashingBanner();
        mainLayout.addView(bannerLayout);
        
        // Products List
        LinearLayout productsLayout = createProductsList();
        mainLayout.addView(productsLayout);
        
        scrollView.addView(mainLayout);
        setContentView(scrollView);
        
        // Start flashing
        startFlashing();
    }
    
    private void startFlashing() {
        flashRunnable = new Runnable() {
            @Override
            public void run() {
                flashState = !flashState;
                if (flashState) {
                    flashCount++;
                    flashCountText.setText("Flashes: " + flashCount);
                }
                
                // FLASHING: Alternates between colors
                if (flashState) {
                    flashText.setBackgroundColor(0xFFFF5722); // Orange
                } else {
                    flashText.setBackgroundColor(0xFFFF9800); // Light Orange
                }
                
                handler.postDelayed(this, 200); // Flash every 200ms (5 times per second)
            }
        };
        handler.post(flashRunnable);
    }
    
    private LinearLayout createHeader() {
        LinearLayout headerLayout = new LinearLayout(this);
        headerLayout.setOrientation(LinearLayout.VERTICAL);
        headerLayout.setBackgroundColor(0xFF2196F3);
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
    
    private LinearLayout createFlashingBanner() {
        LinearLayout bannerLayout = new LinearLayout(this);
        bannerLayout.setOrientation(LinearLayout.HORIZONTAL);
        bannerLayout.setBackgroundColor(0xFFFF5722); // FLASHING: Alternates between colors
        bannerLayout.setPadding(16, 16, 16, 16);
        
        TextView flashIcon = new TextView(this);
        flashIcon.setText("🔥");
        flashIcon.setTextSize(20);
        flashIcon.setPadding(0, 0, 12, 0);
        
        flashText = new TextView(this);
        flashText.setText("FLASH SALE!");
        flashText.setTextSize(20);
        flashText.setTextColor(0xFFFFFFFF);
        flashText.setTypeface(null, android.graphics.Typeface.BOLD);
        flashText.setPadding(0, 0, 12, 0);
        
        TextView discountText = new TextView(this);
        discountText.setText("Up to 50% OFF!");
        discountText.setTextSize(16);
        discountText.setTextColor(0xFFFFFFFF);
        
        flashCountText = new TextView(this);
        flashCountText.setText("Flashes: 0");
        flashCountText.setTextSize(12);
        flashCountText.setTextColor(0xB3FFFFFF);
        flashCountText.setPadding(16, 0, 0, 0);
        
        LinearLayout.LayoutParams iconParams = new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.WRAP_CONTENT, 
            LinearLayout.LayoutParams.WRAP_CONTENT);
        bannerLayout.addView(flashIcon, iconParams);
        
        LinearLayout.LayoutParams flashParams = new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.WRAP_CONTENT, 
            LinearLayout.LayoutParams.WRAP_CONTENT);
        bannerLayout.addView(flashText, flashParams);
        
        LinearLayout.LayoutParams discountParams = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        bannerLayout.addView(discountText, discountParams);
        
        LinearLayout.LayoutParams countParams = new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.WRAP_CONTENT, 
            LinearLayout.LayoutParams.WRAP_CONTENT);
        bannerLayout.addView(flashCountText, countParams);
        
        return bannerLayout;
    }
    
    private LinearLayout createProductsList() {
        LinearLayout productsLayout = new LinearLayout(this);
        productsLayout.setOrientation(LinearLayout.VERTICAL);
        productsLayout.setBackgroundColor(0xFFFFFFFF);
        productsLayout.setPadding(16, 16, 16, 16);
        
        String[][] products = {
            {"Wireless Headphones", "$99.99", "$149.99", "4.5", "128"},
            {"Smart Watch", "$299.99", "$399.99", "4.8", "256"},
            {"Bluetooth Speaker", "$79.99", "$99.99", "4.3", "89"}
        };
        
        for (String[] product : products) {
            LinearLayout productItem = createProductCard(product[0], product[1], product[2], product[3], product[4]);
            productsLayout.addView(productItem);
        }
        
        return productsLayout;
    }
    
    private LinearLayout createProductCard(String name, String price, String originalPrice, String rating, String reviews) {
        LinearLayout cardLayout = new LinearLayout(this);
        cardLayout.setOrientation(LinearLayout.VERTICAL);
        cardLayout.setBackgroundColor(0xFFFFFFFF);
        cardLayout.setPadding(16, 16, 16, 16);
        
        // Product Image
        ImageView productImage = new ImageView(this);
        productImage.setImageResource(android.R.drawable.ic_menu_gallery);
        productImage.setBackgroundColor(0xFFE0E0E0);
        productImage.setMinimumHeight(150);
        productImage.setScaleType(ImageView.ScaleType.CENTER_INSIDE);
        productImage.setContentDescription("Product image of " + name);
        
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
        ratingLayout.setPadding(0, 0, 0, 8);
        
        TextView ratingText = new TextView(this);
        ratingText.setText(rating + " ⭐");
        ratingText.setTextSize(14);
        ratingText.setTextColor(0xFF666666);
        
        TextView reviewsText = new TextView(this);
        reviewsText.setText("(" + reviews + ")");
        reviewsText.setTextSize(14);
        reviewsText.setTextColor(0xFF666666);
        reviewsText.setPadding(8, 0, 0, 0);
        
        ratingLayout.addView(ratingText);
        ratingLayout.addView(reviewsText);
        
        // Price
        LinearLayout priceLayout = new LinearLayout(this);
        priceLayout.setOrientation(LinearLayout.HORIZONTAL);
        priceLayout.setPadding(0, 0, 0, 12);
        
        TextView priceText = new TextView(this);
        priceText.setText(price);
        priceText.setTextSize(20);
        priceText.setTypeface(null, android.graphics.Typeface.BOLD);
        priceText.setTextColor(0xFF4CAF50);
        
        TextView originalPriceText = new TextView(this);
        originalPriceText.setText(originalPrice);
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
    
    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (flashRunnable != null) {
            handler.removeCallbacks(flashRunnable);
        }
    }
}
