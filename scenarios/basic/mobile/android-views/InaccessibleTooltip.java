package com.example.accessibilityscenarios;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

public class InaccessibleTooltipActivity extends Activity {
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        ScrollView scrollView = new ScrollView(this);
        LinearLayout mainLayout = new LinearLayout(this);
        mainLayout.setOrientation(LinearLayout.VERTICAL);
        mainLayout.setPadding(32, 32, 32, 32);
        mainLayout.setBackgroundColor(0xFFF5F5F5);
        
        LinearLayout headerLayout = createHeader();
        mainLayout.addView(headerLayout);
        
        LinearLayout formLayout = createForm();
        mainLayout.addView(formLayout);
        
        scrollView.addView(mainLayout);
        setContentView(scrollView);
    }
    
    private LinearLayout createHeader() {
        LinearLayout headerLayout = new LinearLayout(this);
        headerLayout.setOrientation(LinearLayout.VERTICAL);
        headerLayout.setBackgroundColor(0xFF2196F3);
        headerLayout.setPadding(32, 32, 32, 32);
        
        TextView titleText = new TextView(this);
        titleText.setText("Account Registration");
        titleText.setTextSize(24);
        titleText.setTextColor(0xFFFFFFFF);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        
        TextView subtitleText = new TextView(this);
        subtitleText.setText("Create your account to get started");
        subtitleText.setTextSize(16);
        subtitleText.setTextColor(0xE6FFFFFF);
        
        headerLayout.addView(titleText);
        headerLayout.addView(subtitleText);
        
        return headerLayout;
    }
    
    private LinearLayout createForm() {
        LinearLayout formLayout = new LinearLayout(this);
        formLayout.setOrientation(LinearLayout.VERTICAL);
        formLayout.setBackgroundColor(0xFFFFFFFF);
        formLayout.setPadding(20, 20, 20, 20);
        
        TextView formTitle = new TextView(this);
        formTitle.setText("Personal Information");
        formTitle.setTextSize(20);
        formTitle.setTypeface(null, android.graphics.Typeface.BOLD);
        formTitle.setTextColor(0xFF1976D2);
        formTitle.setPadding(0, 0, 0, 20);
        
        formLayout.addView(formTitle);
        
        String[][] fields = {
            {"Email Address", "Enter your email", "We'll use this to send you important updates and notifications about your account."},
            {"Password", "Enter your password", "Password must be at least 8 characters long and contain uppercase, lowercase, and numbers."},
            {"Phone Number", "Enter your phone number", "Include country code. Example: +1 (555) 123-4567"},
            {"Date of Birth", "MM/DD/YYYY", "You must be at least 18 years old to create an account."},
            {"Security Question", "Select a security question", "Choose a question that only you know the answer to. This helps secure your account."}
        };
        
        for (String[] field : fields) {
            LinearLayout fieldLayout = createFormField(field[0], field[1], field[2]);
            formLayout.addView(fieldLayout);
        }
        
        Button submitButton = new Button(this);
        submitButton.setText("Create Account");
        submitButton.setBackgroundColor(0xFF2196F3);
        submitButton.setTextColor(0xFFFFFFFF);
        submitButton.setPadding(16, 16, 16, 16);
        
        LinearLayout.LayoutParams submitParams = new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
        submitParams.setMargins(0, 20, 0, 0);
        formLayout.addView(submitButton, submitParams);
        
        return formLayout;
    }
    
    private LinearLayout createFormField(String label, String placeholder, String helpText) {
        LinearLayout fieldLayout = new LinearLayout(this);
        fieldLayout.setOrientation(LinearLayout.VERTICAL);
        fieldLayout.setPadding(0, 0, 0, 16);
        
        // Field Label and Help Icon
        LinearLayout labelLayout = new LinearLayout(this);
        labelLayout.setOrientation(LinearLayout.HORIZONTAL);
        labelLayout.setPadding(0, 0, 0, 8);
        
        TextView labelText = new TextView(this);
        labelText.setText(label);
        labelText.setTextSize(16);
        labelText.setTypeface(null, android.graphics.Typeface.BOLD);
        labelText.setTextColor(0xFF1976D2);
        
        // Help Icon - INACCESSIBLE TOOLTIP
        ImageButton helpButton = new ImageButton(this);
        helpButton.setImageResource(android.R.drawable.ic_menu_help);
        helpButton.setBackgroundColor(android.graphics.Color.TRANSPARENT);
        helpButton.setContentDescription(null); // MISSING: No accessible description
        helpButton.setPadding(8, 8, 8, 8);
        helpButton.setMinimumWidth(40);
        helpButton.setMinimumHeight(40);
        
        // Tooltip - Only shows on hover/click, not keyboard accessible
        final TextView tooltipText = new TextView(this);
        tooltipText.setText(helpText);
        tooltipText.setTextSize(12);
        tooltipText.setTextColor(0xFFFFFFFF);
        tooltipText.setBackgroundColor(0xFF424242);
        tooltipText.setPadding(8, 8, 8, 8);
        tooltipText.setVisibility(View.GONE);
        
        helpButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (tooltipText.getVisibility() == View.GONE) {
                    tooltipText.setVisibility(View.VISIBLE);
                } else {
                    tooltipText.setVisibility(View.GONE);
                }
            }
        });
        
        labelLayout.addView(labelText);
        labelLayout.addView(helpButton);
        
        // Input Field
        EditText inputField = new EditText(this);
        inputField.setHint(placeholder);
        inputField.setPadding(16, 16, 16, 16);
        inputField.setBackgroundColor(0xFFF0F0F0);
        
        fieldLayout.addView(labelLayout);
        fieldLayout.addView(inputField);
        fieldLayout.addView(tooltipText);
        
        return fieldLayout;
    }
}
