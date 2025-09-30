package com.example.accessibilityscenarios;

import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

public class LowContrastWarningTextActivity extends Activity {
    
    private TextView warningText;
    private TextView sessionTimeText;
    private int sessionTimeLeft = 15;
    private Handler handler = new Handler();
    private Runnable countdownRunnable;
    
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
        
        // Session Warning - LOW CONTRAST
        LinearLayout warningLayout = createSessionWarning();
        mainLayout.addView(warningLayout);
        
        // Account Overview
        LinearLayout accountLayout = createAccountOverview();
        mainLayout.addView(accountLayout);
        
        // Quick Actions
        LinearLayout actionsLayout = createQuickActions();
        mainLayout.addView(actionsLayout);
        
        scrollView.addView(mainLayout);
        setContentView(scrollView);
        
        // Start countdown
        startCountdown();
    }
    
    private void startCountdown() {
        countdownRunnable = new Runnable() {
            @Override
            public void run() {
                if (sessionTimeLeft > 0) {
                    sessionTimeLeft--;
                    sessionTimeText.setText("Your session will expire in " + sessionTimeLeft + " seconds. Please save your work and refresh the page to continue.");
                    
                    if (sessionTimeLeft <= 5) {
                        warningText.setVisibility(View.VISIBLE);
                    } else {
                        warningText.setVisibility(View.GONE);
                    }
                    
                    handler.postDelayed(this, 1000);
                }
            }
        };
        handler.post(countdownRunnable);
    }
    
    private LinearLayout createHeader() {
        LinearLayout headerLayout = new LinearLayout(this);
        headerLayout.setOrientation(LinearLayout.VERTICAL);
        headerLayout.setBackgroundColor(0xFF2196F3);
        headerLayout.setPadding(32, 32, 32, 32);
        
        TextView titleText = new TextView(this);
        titleText.setText("Secure Banking Portal");
        titleText.setTextSize(24);
        titleText.setTextColor(0xFFFFFFFF);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        
        TextView subtitleText = new TextView(this);
        subtitleText.setText("Manage your accounts safely");
        subtitleText.setTextSize(16);
        subtitleText.setTextColor(0xE6FFFFFF);
        
        headerLayout.addView(titleText);
        headerLayout.addView(subtitleText);
        
        return headerLayout;
    }
    
    private LinearLayout createSessionWarning() {
        LinearLayout warningLayout = new LinearLayout(this);
        warningLayout.setOrientation(LinearLayout.HORIZONTAL);
        warningLayout.setBackgroundColor(0xFFF8F8F8); // Very light background
        warningLayout.setPadding(16, 16, 16, 16);
        
        TextView warningIcon = new TextView(this);
        warningIcon.setText("⚠️");
        warningIcon.setTextSize(20);
        warningIcon.setPadding(0, 0, 16, 0);
        
        warningText = new TextView(this);
        warningText.setText("Your session will expire in " + sessionTimeLeft + " seconds. Please save your work and refresh the page to continue.");
        warningText.setTextSize(14);
        warningText.setTextColor(0xFFCCCCCC); // Very light gray - LOW CONTRAST
        warningText.setVisibility(View.GONE);
        
        sessionTimeText = new TextView(this);
        sessionTimeText.setText("Your session will expire in " + sessionTimeLeft + " seconds. Please save your work and refresh the page to continue.");
        sessionTimeText.setTextSize(14);
        sessionTimeText.setTextColor(0xFFCCCCCC); // Very light gray - LOW CONTRAST
        
        warningLayout.addView(warningIcon);
        warningLayout.addView(warningText);
        
        return warningLayout;
    }
    
    private LinearLayout createAccountOverview() {
        LinearLayout accountLayout = new LinearLayout(this);
        accountLayout.setOrientation(LinearLayout.VERTICAL);
        accountLayout.setBackgroundColor(0xFFFFFFFF);
        accountLayout.setPadding(20, 20, 20, 20);
        
        TextView titleText = new TextView(this);
        titleText.setText("Account Overview");
        titleText.setTextSize(20);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        titleText.setPadding(0, 0, 0, 16);
        
        accountLayout.addView(titleText);
        
        String[][] accounts = {
            {"Checking Account", "$12,450.00", "****1234"},
            {"Savings Account", "$45,230.00", "****5678"},
            {"Credit Card", "-$2,340.00", "****9012"}
        };
        
        for (String[] account : accounts) {
            LinearLayout accountItem = createAccountItem(account[0], account[1], account[2]);
            accountLayout.addView(accountItem);
        }
        
        return accountLayout;
    }
    
    private LinearLayout createAccountItem(String name, String balance, String accountNumber) {
        LinearLayout itemLayout = new LinearLayout(this);
        itemLayout.setOrientation(LinearLayout.HORIZONTAL);
        itemLayout.setBackgroundColor(0xFFF8F9FA);
        itemLayout.setPadding(16, 16, 16, 16);
        
        TextView iconText = new TextView(this);
        iconText.setText("🏦");
        iconText.setTextSize(20);
        iconText.setPadding(0, 0, 16, 0);
        
        LinearLayout textLayout = new LinearLayout(this);
        textLayout.setOrientation(LinearLayout.VERTICAL);
        
        TextView nameText = new TextView(this);
        nameText.setText(name);
        nameText.setTextSize(16);
        nameText.setTypeface(null, android.graphics.Typeface.BOLD);
        
        TextView accountText = new TextView(this);
        accountText.setText("ID: " + accountNumber);
        accountText.setTextSize(14);
        accountText.setTextColor(0xFF666666);
        
        textLayout.addView(nameText);
        textLayout.addView(accountText);
        
        TextView balanceText = new TextView(this);
        balanceText.setText(balance);
        balanceText.setTextSize(18);
        balanceText.setTypeface(null, android.graphics.Typeface.BOLD);
        if (balance.startsWith("-")) {
            balanceText.setTextColor(0xFFE53E3E);
        } else {
            balanceText.setTextColor(0xFF38A169);
        }
        
        itemLayout.addView(iconText);
        itemLayout.addView(textLayout);
        itemLayout.addView(balanceText);
        
        return itemLayout;
    }
    
    private LinearLayout createQuickActions() {
        LinearLayout actionsLayout = new LinearLayout(this);
        actionsLayout.setOrientation(LinearLayout.VERTICAL);
        actionsLayout.setBackgroundColor(0xFFFFFFFF);
        actionsLayout.setPadding(20, 20, 20, 20);
        
        TextView titleText = new TextView(this);
        titleText.setText("Quick Actions");
        titleText.setTextSize(20);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        titleText.setPadding(0, 0, 0, 16);
        
        actionsLayout.addView(titleText);
        
        LinearLayout buttonLayout = new LinearLayout(this);
        buttonLayout.setOrientation(LinearLayout.HORIZONTAL);
        
        String[] actions = {"Transfer", "Pay Bills", "Deposit"};
        int[] colors = {0xFF2196F3, 0xFF4CAF50, 0xFFFF9800};
        
        for (int i = 0; i < actions.length; i++) {
            Button actionButton = new Button(this);
            actionButton.setText(actions[i]);
            actionButton.setBackgroundColor(colors[i]);
            actionButton.setTextColor(0xFFFFFFFF);
            actionButton.setPadding(16, 16, 16, 16);
            
            LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(0, 
                LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
            if (i > 0) {
                params.setMargins(8, 0, 0, 0);
            }
            buttonLayout.addView(actionButton, params);
        }
        
        actionsLayout.addView(buttonLayout);
        
        return actionsLayout;
    }
    
    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (countdownRunnable != null) {
            handler.removeCallbacks(countdownRunnable);
        }
    }
}
