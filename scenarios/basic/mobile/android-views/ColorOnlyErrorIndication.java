package com.example.accessibilityscenarios;

import android.app.Activity;
import android.graphics.drawable.GradientDrawable;
import android.os.Bundle;
import android.text.InputType;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

public class ColorOnlyErrorIndicationActivity extends Activity {
    
    private EditText nameField, emailField, passwordField, confirmPasswordField, phoneField;
    private boolean showErrors = false;
    
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
        titleText.setText("User Registration");
        titleText.setTextSize(24);
        titleText.setTextColor(0xFFFFFFFF);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        
        TextView subtitleText = new TextView(this);
        subtitleText.setText("Create your account");
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
        
        // Name Field - COLOR ONLY ERROR INDICATION
        LinearLayout nameLayout = createFormField("Full Name *", "Enter your full name", false);
        nameField = (EditText) nameLayout.getChildAt(1);
        formLayout.addView(nameLayout);
        
        // Email Field - COLOR ONLY ERROR INDICATION
        LinearLayout emailLayout = createFormField("Email Address *", "Enter your email", false);
        emailField = (EditText) emailLayout.getChildAt(1);
        formLayout.addView(emailLayout);
        
        // Password Field - COLOR ONLY ERROR INDICATION
        LinearLayout passwordLayout = createFormField("Password *", "Enter your password", true);
        passwordField = (EditText) passwordLayout.getChildAt(1);
        formLayout.addView(passwordLayout);
        
        // Confirm Password Field - COLOR ONLY ERROR INDICATION
        LinearLayout confirmPasswordLayout = createFormField("Confirm Password *", "Confirm your password", true);
        confirmPasswordField = (EditText) confirmPasswordLayout.getChildAt(1);
        formLayout.addView(confirmPasswordLayout);
        
        // Phone Field - COLOR ONLY ERROR INDICATION
        LinearLayout phoneLayout = createFormField("Phone Number *", "Enter your phone number", false);
        phoneField = (EditText) phoneLayout.getChildAt(1);
        formLayout.addView(phoneLayout);
        
        // Submit Button
        Button submitButton = new Button(this);
        submitButton.setText("Create Account");
        submitButton.setBackgroundColor(0xFF2196F3);
        submitButton.setTextColor(0xFFFFFFFF);
        submitButton.setPadding(16, 16, 16, 16);
        submitButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                validateForm();
            }
        });
        
        LinearLayout.LayoutParams submitParams = new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
        submitParams.setMargins(0, 20, 0, 0);
        formLayout.addView(submitButton, submitParams);
        
        return formLayout;
    }
    
    private LinearLayout createFormField(String label, String hint, boolean isPassword) {
        LinearLayout fieldLayout = new LinearLayout(this);
        fieldLayout.setOrientation(LinearLayout.VERTICAL);
        fieldLayout.setPadding(0, 0, 0, 16);
        
        TextView labelText = new TextView(this);
        labelText.setText(label);
        labelText.setTextSize(16);
        labelText.setTypeface(null, android.graphics.Typeface.BOLD);
        labelText.setTextColor(0xFF1976D2);
        labelText.setPadding(0, 0, 0, 8);
        
        EditText inputField = new EditText(this);
        inputField.setHint(hint);
        inputField.setPadding(16, 16, 16, 16);
        inputField.setBackgroundColor(0xFFF0F0F0);
        
        if (isPassword) {
            inputField.setInputType(InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_VARIATION_PASSWORD);
        }
        
        fieldLayout.addView(labelText);
        fieldLayout.addView(inputField);
        
        return fieldLayout;
    }
    
    private void validateForm() {
        showErrors = true;
        
        // Simulate validation
        String name = nameField.getText().toString();
        String email = emailField.getText().toString();
        String password = passwordField.getText().toString();
        String confirmPassword = confirmPasswordField.getText().toString();
        String phone = phoneField.getText().toString();
        
        boolean hasNameError = name.isEmpty();
        boolean hasEmailError = email.isEmpty() || !email.contains("@");
        boolean hasPasswordError = password.length() < 8;
        boolean hasConfirmPasswordError = !password.equals(confirmPassword);
        boolean hasPhoneError = phone.isEmpty() || phone.length() < 10;
        
        // Update field appearance with color-only error indication
        updateFieldBorder(nameField, hasNameError);
        updateFieldBorder(emailField, hasEmailError);
        updateFieldBorder(passwordField, hasPasswordError);
        updateFieldBorder(confirmPasswordField, hasConfirmPasswordError);
        updateFieldBorder(phoneField, hasPhoneError);
        // MISSING: No text description of error, only color indication
    }
    
    private void updateFieldBorder(EditText field, boolean hasError) {
        GradientDrawable border = new GradientDrawable();
        border.setCornerRadius(8);
        border.setStroke(4, hasError && showErrors ? 0xFFE53E3E : 0xFF2196F3);
        border.setColor(0xFFF0F0F0);
        field.setBackground(border);
    }
}
