package com.accessibilityapp;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.*;
import android.widget.CompoundButton.OnCheckedChangeListener;
import android.graphics.Color;
import android.text.TextWatcher;
import android.text.Editable;
import android.view.LayoutInflater;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import java.util.*;
import java.text.DecimalFormat;

public class ShoppingCartSystemActivity extends Activity {
    
    private ListView cartItemsList;
    private LinearLayout summaryContainer;
    private TextView subtotalText;
    private TextView taxText;
    private TextView shippingText;
    private TextView totalText;
    private EditText promoCodeInput;
    private Button applyPromoButton;
    private Spinner shippingSpinner;
    private Button checkoutButton;
    private Button clearCartButton;
    private TextView itemCountText;
    private ProgressBar loadingIndicator;
    
    private List<CartItem> cartItems;
    private CartAdapter adapter;
    private double subtotal = 0.0;
    private double tax = 0.0;
    private double shipping = 0.0;
    private double discount = 0.0;
    private String appliedPromoCode = "";
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_shopping_cart_system);
        
        initializeViews();
        setupData();
        setupListeners();
        updateDisplay();
    }
    
    private void initializeViews() {
        cartItemsList = findViewById(R.id.cartItemsList);
        summaryContainer = findViewById(R.id.summaryContainer);
        subtotalText = findViewById(R.id.subtotalText);
        taxText = findViewById(R.id.taxText);
        shippingText = findViewById(R.id.shippingText);
        totalText = findViewById(R.id.totalText);
        promoCodeInput = findViewById(R.id.promoCodeInput);
        applyPromoButton = findViewById(R.id.applyPromoButton);
        shippingSpinner = findViewById(R.id.shippingSpinner);
        checkoutButton = findViewById(R.id.checkoutButton);
        clearCartButton = findViewById(R.id.clearCartButton);
        itemCountText = findViewById(R.id.itemCountText);
        loadingIndicator = findViewById(R.id.loadingIndicator);
        
        setupShippingSpinner();
    }
    
    private void setupShippingSpinner() {
        String[] shippingOptions = {"Standard (5-7 days) - $5.99", "Express (2-3 days) - $9.99", "Overnight - $19.99"};
        ArrayAdapter<String> shippingAdapter = new ArrayAdapter<>(this, 
            android.R.layout.simple_spinner_item, shippingOptions);
        shippingAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        shippingSpinner.setAdapter(shippingAdapter);
    }
    
    private void setupData() {
        cartItems = new ArrayList<>();
        cartItems.add(new CartItem(1, "Wireless Headphones", 99.99, 1, "https://example.com/headphones.jpg"));
        cartItems.add(new CartItem(2, "Smartphone Case", 24.99, 2, "https://example.com/case.jpg"));
        cartItems.add(new CartItem(3, "USB-C Cable", 12.99, 3, "https://example.com/cable.jpg"));
        cartItems.add(new CartItem(4, "Bluetooth Speaker", 79.99, 1, "https://example.com/speaker.jpg"));
        
        adapter = new CartAdapter(this, cartItems);
        cartItemsList.setAdapter(adapter);
        
        calculateTotals();
    }
    
    private void setupListeners() {
        promoCodeInput.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {}
            
            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                applyPromoButton.setEnabled(s.length() > 0);
            }
            
            @Override
            public void afterTextChanged(Editable s) {}
        });
        
        applyPromoButton.setOnClickListener(v -> applyPromoCode());
        
        shippingSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                String[] shippingValues = {"5.99", "9.99", "19.99"};
                shipping = Double.parseDouble(shippingValues[position]);
                calculateTotals();
            }
            
            @Override
            public void onNothingSelected(AdapterView<?> parent) {}
        });
        
        checkoutButton.setOnClickListener(v -> proceedToCheckout());
        clearCartButton.setOnClickListener(v -> clearCart());
    }
    
    private void applyPromoCode() {
        String promoCode = promoCodeInput.getText().toString().trim();
        
        if (promoCode.isEmpty()) {
            Toast.makeText(this, "Please enter a promo code", Toast.LENGTH_SHORT).show();
            return;
        }
        
        // Simulate promo code validation
        if (promoCode.equalsIgnoreCase("SAVE10")) {
            discount = subtotal * 0.10;
            appliedPromoCode = promoCode;
            Toast.makeText(this, "Promo code applied! 10% discount", Toast.LENGTH_SHORT).show();
        } else if (promoCode.equalsIgnoreCase("FREESHIP")) {
            shipping = 0.0;
            appliedPromoCode = promoCode;
            Toast.makeText(this, "Free shipping applied!", Toast.LENGTH_SHORT).show();
        } else {
            Toast.makeText(this, "Invalid promo code", Toast.LENGTH_SHORT).show();
            return;
        }
        
        calculateTotals();
        promoCodeInput.setText("");
    }
    
    private void updateQuantity(int itemId, int newQuantity) {
        for (CartItem item : cartItems) {
            if (item.getId() == itemId) {
                if (newQuantity <= 0) {
                    cartItems.remove(item);
                } else {
                    item.setQuantity(newQuantity);
                }
                break;
            }
        }
        
        adapter.notifyDataSetChanged();
        calculateTotals();
    }
    
    private void removeItem(int itemId) {
        cartItems.removeIf(item -> item.getId() == itemId);
        adapter.notifyDataSetChanged();
        calculateTotals();
    }
    
    private void calculateTotals() {
        subtotal = 0.0;
        for (CartItem item : cartItems) {
            subtotal += item.getPrice() * item.getQuantity();
        }
        
        tax = subtotal * 0.08; // 8% tax
        
        double total = subtotal + tax + shipping - discount;
        
        updateSummaryDisplay(subtotal, tax, shipping, discount, total);
        updateItemCount();
    }
    
    private void updateSummaryDisplay(double subtotal, double tax, double shipping, double discount, double total) {
        DecimalFormat df = new DecimalFormat("$#0.00");
        
        subtotalText.setText("Subtotal: " + df.format(subtotal));
        taxText.setText("Tax: " + df.format(tax));
        shippingText.setText("Shipping: " + df.format(shipping));
        
        if (discount > 0) {
            TextView discountText = findViewById(R.id.discountText);
            if (discountText == null) {
                discountText = new TextView(this);
                discountText.setId(R.id.discountText);
                discountText.setTextColor(Color.GREEN);
                discountText.setTextSize(14);
                LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(
                    LinearLayout.LayoutParams.MATCH_PARENT, 
                    LinearLayout.LayoutParams.WRAP_CONTENT
                );
                params.setMargins(0, 8, 0, 8);
                discountText.setLayoutParams(params);
                
                // Insert before total
                int totalIndex = summaryContainer.indexOfChild(totalText);
                summaryContainer.addView(discountText, totalIndex);
            }
            discountText.setText("Discount (" + appliedPromoCode + "): -" + df.format(discount));
        } else {
            TextView discountText = findViewById(R.id.discountText);
            if (discountText != null) {
                summaryContainer.removeView(discountText);
            }
        }
        
        totalText.setText("Total: " + df.format(total));
    }
    
    private void updateItemCount() {
        int totalItems = 0;
        for (CartItem item : cartItems) {
            totalItems += item.getQuantity();
        }
        itemCountText.setText(totalItems + " items in cart");
    }
    
    private void updateDisplay() {
        adapter.notifyDataSetChanged();
        calculateTotals();
    }
    
    private void proceedToCheckout() {
        if (cartItems.isEmpty()) {
            Toast.makeText(this, "Your cart is empty", Toast.LENGTH_SHORT).show();
            return;
        }
        
        loadingIndicator.setVisibility(View.VISIBLE);
        
        // Simulate checkout process
        new android.os.Handler().postDelayed(() -> {
            loadingIndicator.setVisibility(View.GONE);
            Toast.makeText(this, "Redirecting to checkout...", Toast.LENGTH_LONG).show();
        }, 2000);
    }
    
    private void clearCart() {
        cartItems.clear();
        adapter.notifyDataSetChanged();
        calculateTotals();
        Toast.makeText(this, "Cart cleared", Toast.LENGTH_SHORT).show();
    }
    
    // Cart Item class
    public static class CartItem {
        private int id;
        private String name;
        private double price;
        private int quantity;
        private String imageUrl;
        
        public CartItem(int id, String name, double price, int quantity, String imageUrl) {
            this.id = id;
            this.name = name;
            this.price = price;
            this.quantity = quantity;
            this.imageUrl = imageUrl;
        }
        
        // Getters and setters
        public int getId() { return id; }
        public String getName() { return name; }
        public double getPrice() { return price; }
        public int getQuantity() { return quantity; }
        public void setQuantity(int quantity) { this.quantity = quantity; }
        public String getImageUrl() { return imageUrl; }
        public double getTotalPrice() { return price * quantity; }
    }
    
    // Cart Adapter
    private class CartAdapter extends BaseAdapter {
        private Activity context;
        private List<CartItem> items;
        
        public CartAdapter(Activity context, List<CartItem> items) {
            this.context = context;
            this.items = items;
        }
        
        @Override
        public int getCount() {
            return items.size();
        }
        
        @Override
        public Object getItem(int position) {
            return items.get(position);
        }
        
        @Override
        public long getItemId(int position) {
            return items.get(position).getId();
        }
        
        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            if (convertView == null) {
                convertView = getLayoutInflater().inflate(R.layout.item_cart, parent, false);
            }
            
            CartItem item = items.get(position);
            
            TextView nameText = convertView.findViewById(R.id.itemName);
            TextView priceText = convertView.findViewById(R.id.itemPrice);
            TextView quantityText = convertView.findViewById(R.id.quantityText);
            TextView totalText = convertView.findViewById(R.id.itemTotal);
            Button removeButton = convertView.findViewById(R.id.removeButton);
            Button decreaseButton = convertView.findViewById(R.id.decreaseButton);
            Button increaseButton = convertView.findViewById(R.id.increaseButton);
            
            nameText.setText(item.getName());
            priceText.setText("$" + String.format("%.2f", item.getPrice()));
            quantityText.setText(String.valueOf(item.getQuantity()));
            totalText.setText("$" + String.format("%.2f", item.getTotalPrice()));
            
            decreaseButton.setOnClickListener(v -> {
                int newQuantity = item.getQuantity() - 1;
                updateQuantity(item.getId(), newQuantity);
            });
            
            increaseButton.setOnClickListener(v -> {
                int newQuantity = item.getQuantity() + 1;
                updateQuantity(item.getId(), newQuantity);
            });
            
            removeButton.setOnClickListener(v -> removeItem(item.getId()));
            
            return convertView;
        }
    }
}
