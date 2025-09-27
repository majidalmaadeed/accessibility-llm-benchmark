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

public class MultiStepWizardActivity extends Activity {
    
    private LinearLayout stepContainer;
    private LinearLayout formContainer;
    private LinearLayout navigationContainer;
    private ProgressBar progressBar;
    private TextView stepTitle;
    private TextView stepDescription;
    private Button previousButton;
    private Button nextButton;
    private Button submitButton;
    private TextView progressText;
    
    private int currentStep = 1;
    private int totalSteps = 5;
    private Map<String, String> formData;
    private Map<String, String> errors;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_multi_step_wizard);
        
        initializeViews();
        setupData();
        setupListeners();
        showStep(1);
    }
    
    private void initializeViews() {
        stepContainer = findViewById(R.id.stepContainer);
        formContainer = findViewById(R.id.formContainer);
        navigationContainer = findViewById(R.id.navigationContainer);
        progressBar = findViewById(R.id.progressBar);
        stepTitle = findViewById(R.id.stepTitle);
        stepDescription = findViewById(R.id.stepDescription);
        previousButton = findViewById(R.id.previousButton);
        nextButton = findViewById(R.id.nextButton);
        submitButton = findViewById(R.id.submitButton);
        progressText = findViewById(R.id.progressText);
        
        formData = new HashMap<>();
        errors = new HashMap<>();
    }
    
    private void setupData() {
        // Initialize form data
        formData.put("firstName", "");
        formData.put("lastName", "");
        formData.put("email", "");
        formData.put("phone", "");
        formData.put("dateOfBirth", "");
        formData.put("street", "");
        formData.put("city", "");
        formData.put("state", "");
        formData.put("zipCode", "");
        formData.put("country", "");
        formData.put("newsletter", "false");
        formData.put("notifications", "false");
        formData.put("theme", "light");
        formData.put("language", "en");
        formData.put("cardNumber", "");
        formData.put("expiryDate", "");
        formData.put("cvv", "");
        formData.put("billingAddress", "");
    }
    
    private void setupListeners() {
        previousButton.setOnClickListener(v -> {
            if (currentStep > 1) {
                showStep(currentStep - 1);
            }
        });
        
        nextButton.setOnClickListener(v -> {
            if (validateCurrentStep()) {
                if (currentStep < totalSteps) {
                    showStep(currentStep + 1);
                }
            }
        });
        
        submitButton.setOnClickListener(v -> {
            if (validateCurrentStep()) {
                submitForm();
            }
        });
    }
    
    private void showStep(int step) {
        currentStep = step;
        updateProgress();
        updateStepInfo();
        clearFormContainer();
        loadStepContent(step);
        updateNavigationButtons();
    }
    
    private void updateProgress() {
        int progress = (currentStep * 100) / totalSteps;
        progressBar.setProgress(progress);
        progressText.setText("Step " + currentStep + " of " + totalSteps);
    }
    
    private void updateStepInfo() {
        String[] titles = {
            "Personal Information",
            "Address Details", 
            "Preferences",
            "Payment Information",
            "Review & Confirm"
        };
        
        String[] descriptions = {
            "Tell us about yourself",
            "Where should we send your items?",
            "Customize your experience",
            "Secure payment information",
            "Review your information"
        };
        
        stepTitle.setText(titles[currentStep - 1]);
        stepDescription.setText(descriptions[currentStep - 1]);
    }
    
    private void clearFormContainer() {
        formContainer.removeAllViews();
    }
    
    private void loadStepContent(int step) {
        switch (step) {
            case 1:
                loadPersonalInfoStep();
                break;
            case 2:
                loadAddressStep();
                break;
            case 3:
                loadPreferencesStep();
                break;
            case 4:
                loadPaymentStep();
                break;
            case 5:
                loadReviewStep();
                break;
        }
    }
    
    private void loadPersonalInfoStep() {
        LinearLayout layout = new LinearLayout(this);
        layout.setOrientation(LinearLayout.VERTICAL);
        layout.setPadding(16, 16, 16, 16);
        
        // First Name
        TextView firstNameLabel = createLabel("First Name *");
        EditText firstNameInput = createEditText("firstName", "Enter your first name");
        layout.addView(firstNameLabel);
        layout.addView(firstNameInput);
        
        // Last Name
        TextView lastNameLabel = createLabel("Last Name *");
        EditText lastNameInput = createEditText("lastName", "Enter your last name");
        layout.addView(lastNameLabel);
        layout.addView(lastNameInput);
        
        // Email
        TextView emailLabel = createLabel("Email Address *");
        EditText emailInput = createEditText("email", "Enter your email address");
        emailInput.setInputType(android.text.InputType.TYPE_TEXT_VARIATION_EMAIL_ADDRESS);
        layout.addView(emailLabel);
        layout.addView(emailInput);
        
        // Phone
        TextView phoneLabel = createLabel("Phone Number");
        EditText phoneInput = createEditText("phone", "Enter your phone number");
        phoneInput.setInputType(android.text.InputType.TYPE_CLASS_PHONE);
        layout.addView(phoneLabel);
        layout.addView(phoneInput);
        
        // Date of Birth
        TextView dobLabel = createLabel("Date of Birth");
        EditText dobInput = createEditText("dateOfBirth", "MM/DD/YYYY");
        layout.addView(dobLabel);
        layout.addView(dobInput);
        
        formContainer.addView(layout);
    }
    
    private void loadAddressStep() {
        LinearLayout layout = new LinearLayout(this);
        layout.setOrientation(LinearLayout.VERTICAL);
        layout.setPadding(16, 16, 16, 16);
        
        // Street Address
        TextView streetLabel = createLabel("Street Address *");
        EditText streetInput = createEditText("street", "Enter your street address");
        layout.addView(streetLabel);
        layout.addView(streetInput);
        
        // City
        TextView cityLabel = createLabel("City *");
        EditText cityInput = createEditText("city", "Enter your city");
        layout.addView(cityLabel);
        layout.addView(cityInput);
        
        // State and ZIP Row
        LinearLayout stateZipRow = new LinearLayout(this);
        stateZipRow.setOrientation(LinearLayout.HORIZONTAL);
        
        LinearLayout stateContainer = new LinearLayout(this);
        stateContainer.setOrientation(LinearLayout.VERTICAL);
        stateContainer.setLayoutParams(new LinearLayout.LayoutParams(0, LinearLayout.LayoutParams.WRAP_CONTENT, 1));
        
        TextView stateLabel = createLabel("State *");
        EditText stateInput = createEditText("state", "State");
        stateContainer.addView(stateLabel);
        stateContainer.addView(stateInput);
        
        LinearLayout zipContainer = new LinearLayout(this);
        zipContainer.setOrientation(LinearLayout.VERTICAL);
        zipContainer.setLayoutParams(new LinearLayout.LayoutParams(0, LinearLayout.LayoutParams.WRAP_CONTENT, 1));
        zipContainer.setPadding(16, 0, 0, 0);
        
        TextView zipLabel = createLabel("ZIP Code *");
        EditText zipInput = createEditText("zipCode", "ZIP");
        zipContainer.addView(zipLabel);
        zipContainer.addView(zipInput);
        
        stateZipRow.addView(stateContainer);
        stateZipRow.addView(zipContainer);
        layout.addView(stateZipRow);
        
        // Country
        TextView countryLabel = createLabel("Country *");
        Spinner countrySpinner = createSpinner("country", new String[]{"United States", "Canada", "United Kingdom", "Australia", "Germany"});
        layout.addView(countryLabel);
        layout.addView(countrySpinner);
        
        formContainer.addView(layout);
    }
    
    private void loadPreferencesStep() {
        LinearLayout layout = new LinearLayout(this);
        layout.setOrientation(LinearLayout.VERTICAL);
        layout.setPadding(16, 16, 16, 16);
        
        // Newsletter
        CheckBox newsletterCheckbox = new CheckBox(this);
        newsletterCheckbox.setText("Subscribe to newsletter");
        newsletterCheckbox.setChecked("true".equals(formData.get("newsletter")));
        newsletterCheckbox.setOnCheckedChangeListener((buttonView, isChecked) -> {
            formData.put("newsletter", String.valueOf(isChecked));
        });
        layout.addView(newsletterCheckbox);
        
        // Notifications
        CheckBox notificationsCheckbox = new CheckBox(this);
        notificationsCheckbox.setText("Enable push notifications");
        notificationsCheckbox.setChecked("true".equals(formData.get("notifications")));
        notificationsCheckbox.setOnCheckedChangeListener((buttonView, isChecked) -> {
            formData.put("notifications", String.valueOf(isChecked));
        });
        layout.addView(notificationsCheckbox);
        
        // Theme
        TextView themeLabel = createLabel("Theme Preference");
        Spinner themeSpinner = createSpinner("theme", new String[]{"Light", "Dark", "Auto"});
        layout.addView(themeLabel);
        layout.addView(themeSpinner);
        
        // Language
        TextView languageLabel = createLabel("Language");
        Spinner languageSpinner = createSpinner("language", new String[]{"English", "Spanish", "French", "German", "Chinese"});
        layout.addView(languageLabel);
        layout.addView(languageSpinner);
        
        formContainer.addView(layout);
    }
    
    private void loadPaymentStep() {
        LinearLayout layout = new LinearLayout(this);
        layout.setOrientation(LinearLayout.VERTICAL);
        layout.setPadding(16, 16, 16, 16);
        
        // Card Number
        TextView cardLabel = createLabel("Card Number *");
        EditText cardInput = createEditText("cardNumber", "1234 5678 9012 3456");
        cardInput.setInputType(android.text.InputType.TYPE_CLASS_NUMBER);
        layout.addView(cardLabel);
        layout.addView(cardInput);
        
        // Expiry and CVV Row
        LinearLayout expiryCvvRow = new LinearLayout(this);
        expiryCvvRow.setOrientation(LinearLayout.HORIZONTAL);
        
        LinearLayout expiryContainer = new LinearLayout(this);
        expiryContainer.setOrientation(LinearLayout.VERTICAL);
        expiryContainer.setLayoutParams(new LinearLayout.LayoutParams(0, LinearLayout.LayoutParams.WRAP_CONTENT, 1));
        
        TextView expiryLabel = createLabel("Expiry Date *");
        EditText expiryInput = createEditText("expiryDate", "MM/YY");
        expiryContainer.addView(expiryLabel);
        expiryContainer.addView(expiryInput);
        
        LinearLayout cvvContainer = new LinearLayout(this);
        cvvContainer.setOrientation(LinearLayout.VERTICAL);
        cvvContainer.setLayoutParams(new LinearLayout.LayoutParams(0, LinearLayout.LayoutParams.WRAP_CONTENT, 1));
        cvvContainer.setPadding(16, 0, 0, 0);
        
        TextView cvvLabel = createLabel("CVV *");
        EditText cvvInput = createEditText("cvv", "123");
        cvvInput.setInputType(android.text.InputType.TYPE_CLASS_NUMBER);
        cvvContainer.addView(cvvLabel);
        cvvContainer.addView(cvvInput);
        
        expiryCvvRow.addView(expiryContainer);
        expiryCvvRow.addView(cvvContainer);
        layout.addView(expiryCvvRow);
        
        // Billing Address
        TextView billingLabel = createLabel("Billing Address");
        EditText billingInput = createEditText("billingAddress", "Same as shipping address");
        layout.addView(billingLabel);
        layout.addView(billingInput);
        
        formContainer.addView(layout);
    }
    
    private void loadReviewStep() {
        LinearLayout layout = new LinearLayout(this);
        layout.setOrientation(LinearLayout.VERTICAL);
        layout.setPadding(16, 16, 16, 16);
        
        // Personal Info Review
        addReviewSection(layout, "Personal Information", 
            "Name: " + formData.get("firstName") + " " + formData.get("lastName") + "\n" +
            "Email: " + formData.get("email") + "\n" +
            "Phone: " + formData.get("phone") + "\n" +
            "Date of Birth: " + formData.get("dateOfBirth"));
        
        // Address Review
        addReviewSection(layout, "Address", 
            formData.get("street") + "\n" +
            formData.get("city") + ", " + formData.get("state") + " " + formData.get("zipCode") + "\n" +
            formData.get("country"));
        
        // Preferences Review
        addReviewSection(layout, "Preferences", 
            "Newsletter: " + (formData.get("newsletter").equals("true") ? "Yes" : "No") + "\n" +
            "Notifications: " + (formData.get("notifications").equals("true") ? "Yes" : "No") + "\n" +
            "Theme: " + formData.get("theme") + "\n" +
            "Language: " + formData.get("language"));
        
        // Payment Review
        addReviewSection(layout, "Payment", 
            "Card: **** **** **** " + formData.get("cardNumber").substring(Math.max(0, formData.get("cardNumber").length() - 4)) + "\n" +
            "Expiry: " + formData.get("expiryDate") + "\n" +
            "Billing: " + formData.get("billingAddress"));
        
        formContainer.addView(layout);
    }
    
    private void addReviewSection(LinearLayout parent, String title, String content) {
        TextView titleView = new TextView(this);
        titleView.setText(title);
        titleView.setTextSize(16);
        titleView.setTextColor(Color.BLACK);
        titleView.setTypeface(null, android.graphics.Typeface.BOLD);
        titleView.setPadding(0, 16, 0, 8);
        parent.addView(titleView);
        
        TextView contentView = new TextView(this);
        contentView.setText(content);
        contentView.setTextSize(14);
        contentView.setTextColor(Color.GRAY);
        contentView.setPadding(16, 0, 0, 16);
        parent.addView(contentView);
    }
    
    private TextView createLabel(String text) {
        TextView label = new TextView(this);
        label.setText(text);
        label.setTextSize(14);
        label.setTextColor(Color.BLACK);
        label.setPadding(0, 16, 0, 8);
        return label;
    }
    
    private EditText createEditText(String key, String hint) {
        EditText editText = new EditText(this);
        editText.setHint(hint);
        editText.setText(formData.get(key));
        editText.setPadding(12, 12, 12, 12);
        editText.setBackgroundResource(android.R.drawable.edit_text);
        editText.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {}
            
            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {}
            
            @Override
            public void afterTextChanged(Editable s) {
                formData.put(key, s.toString());
            }
        });
        return editText;
    }
    
    private Spinner createSpinner(String key, String[] options) {
        Spinner spinner = new Spinner(this);
        ArrayAdapter<String> adapter = new ArrayAdapter<>(this, android.R.layout.simple_spinner_item, options);
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spinner.setAdapter(adapter);
        
        // Set current value if exists
        String currentValue = formData.get(key);
        for (int i = 0; i < options.length; i++) {
            if (options[i].equalsIgnoreCase(currentValue)) {
                spinner.setSelection(i);
                break;
            }
        }
        
        spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                formData.put(key, options[position]);
            }
            
            @Override
            public void onNothingSelected(AdapterView<?> parent) {}
        });
        
        return spinner;
    }
    
    private boolean validateCurrentStep() {
        errors.clear();
        boolean isValid = true;
        
        switch (currentStep) {
            case 1:
                if (formData.get("firstName").trim().isEmpty()) {
                    errors.put("firstName", "First name is required");
                    isValid = false;
                }
                if (formData.get("lastName").trim().isEmpty()) {
                    errors.put("lastName", "Last name is required");
                    isValid = false;
                }
                if (formData.get("email").trim().isEmpty()) {
                    errors.put("email", "Email is required");
                    isValid = false;
                }
                break;
            case 2:
                if (formData.get("street").trim().isEmpty()) {
                    errors.put("street", "Street address is required");
                    isValid = false;
                }
                if (formData.get("city").trim().isEmpty()) {
                    errors.put("city", "City is required");
                    isValid = false;
                }
                if (formData.get("state").trim().isEmpty()) {
                    errors.put("state", "State is required");
                    isValid = false;
                }
                if (formData.get("zipCode").trim().isEmpty()) {
                    errors.put("zipCode", "ZIP code is required");
                    isValid = false;
                }
                break;
            case 4:
                if (formData.get("cardNumber").trim().isEmpty()) {
                    errors.put("cardNumber", "Card number is required");
                    isValid = false;
                }
                if (formData.get("expiryDate").trim().isEmpty()) {
                    errors.put("expiryDate", "Expiry date is required");
                    isValid = false;
                }
                if (formData.get("cvv").trim().isEmpty()) {
                    errors.put("cvv", "CVV is required");
                    isValid = false;
                }
                break;
        }
        
        if (!isValid) {
            showValidationErrors();
        }
        
        return isValid;
    }
    
    private void showValidationErrors() {
        StringBuilder errorMessage = new StringBuilder("Please fix the following errors:\n");
        for (String error : errors.values()) {
            errorMessage.append("• ").append(error).append("\n");
        }
        
        Toast.makeText(this, errorMessage.toString(), Toast.LENGTH_LONG).show();
    }
    
    private void updateNavigationButtons() {
        previousButton.setEnabled(currentStep > 1);
        
        if (currentStep < totalSteps) {
            nextButton.setVisibility(View.VISIBLE);
            submitButton.setVisibility(View.GONE);
        } else {
            nextButton.setVisibility(View.GONE);
            submitButton.setVisibility(View.VISIBLE);
        }
    }
    
    private void submitForm() {
        // Simulate form submission
        Toast.makeText(this, "Form submitted successfully!", Toast.LENGTH_LONG).show();
        
        // Reset form
        currentStep = 1;
        formData.clear();
        setupData();
        showStep(1);
    }
}
