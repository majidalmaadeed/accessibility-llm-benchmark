package com.example.uicomponents;

import android.app.Activity;
import android.os.Bundle;
import android.widget.LinearLayout;
import android.widget.RadioButton;
import android.widget.ScrollView;
import android.widget.TextView;

public class UngroupedRadioButtonsActivity extends Activity {
    
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
        
        // Contact Method Selection - UNGROUPED RADIO BUTTONS
        LinearLayout contactLayout = createContactMethodSection();
        mainLayout.addView(contactLayout);
        
        // Newsletter Selection - UNGROUPED RADIO BUTTONS
        LinearLayout newsletterLayout = createNewsletterSection();
        mainLayout.addView(newsletterLayout);
        
        // Language Selection - UNGROUPED RADIO BUTTONS
        LinearLayout languageLayout = createLanguageSection();
        mainLayout.addView(languageLayout);
        
        scrollView.addView(mainLayout);
        setContentView(scrollView);
    }
    
    private LinearLayout createHeader() {
        LinearLayout headerLayout = new LinearLayout(this);
        headerLayout.setOrientation(LinearLayout.VERTICAL);
        headerLayout.setBackgroundColor(0xFF2196F3);
        headerLayout.setPadding(32, 32, 32, 32);
        
        TextView titleText = new TextView(this);
        titleText.setText("User Preferences");
        titleText.setTextSize(24);
        titleText.setTextColor(0xFFFFFFFF);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        
        TextView subtitleText = new TextView(this);
        subtitleText.setText("Customize your account settings");
        subtitleText.setTextSize(16);
        subtitleText.setTextColor(0xE6FFFFFF);
        
        headerLayout.addView(titleText);
        headerLayout.addView(subtitleText);
        
        return headerLayout;
    }
    
    private LinearLayout createContactMethodSection() {
        LinearLayout contactLayout = new LinearLayout(this);
        contactLayout.setOrientation(LinearLayout.VERTICAL);
        contactLayout.setBackgroundColor(0xFFFFFFFF);
        contactLayout.setPadding(16, 16, 16, 16);
        
        TextView titleText = new TextView(this);
        titleText.setText("Preferred Contact Method");
        titleText.setTextSize(18);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        titleText.setPadding(0, 0, 0, 12);
        
        contactLayout.addView(titleText);No fieldset grouping for related radio buttons
        LinearLayout optionsLayout = new LinearLayout(this);
        optionsLayout.setOrientation(LinearLayout.HORIZONTAL);
        
        RadioButton emailRadio = new RadioButton(this);
        emailRadio.setText("Email");
        emailRadio.setPadding(0, 0, 16, 0);
        
        RadioButton phoneRadio = new RadioButton(this);
        phoneRadio.setText("Phone");
        phoneRadio.setPadding(0, 0, 16, 0);
        
        RadioButton smsRadio = new RadioButton(this);
        smsRadio.setText("SMS");
        
        optionsLayout.addView(emailRadio);
        optionsLayout.addView(phoneRadio);
        optionsLayout.addView(smsRadio);
        
        contactLayout.addView(optionsLayout);
        
        return contactLayout;
    }
    
    private LinearLayout createNewsletterSection() {
        LinearLayout newsletterLayout = new LinearLayout(this);
        newsletterLayout.setOrientation(LinearLayout.VERTICAL);
        newsletterLayout.setBackgroundColor(0xFFFFFFFF);
        newsletterLayout.setPadding(16, 16, 16, 16);
        
        TextView titleText = new TextView(this);
        titleText.setText("Newsletter Frequency");
        titleText.setTextSize(18);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        titleText.setPadding(0, 0, 0, 12);
        
        newsletterLayout.addView(titleText);No fieldset grouping for related radio buttons
        RadioButton dailyRadio = new RadioButton(this);
        dailyRadio.setText("Daily");
        dailyRadio.setPadding(0, 0, 0, 8);
        
        RadioButton weeklyRadio = new RadioButton(this);
        weeklyRadio.setText("Weekly");
        weeklyRadio.setPadding(0, 0, 0, 8);
        
        RadioButton monthlyRadio = new RadioButton(this);
        monthlyRadio.setText("Monthly");
        monthlyRadio.setPadding(0, 0, 0, 8);
        
        RadioButton neverRadio = new RadioButton(this);
        neverRadio.setText("Never");
        
        newsletterLayout.addView(dailyRadio);
        newsletterLayout.addView(weeklyRadio);
        newsletterLayout.addView(monthlyRadio);
        newsletterLayout.addView(neverRadio);
        
        return newsletterLayout;
    }
    
    private LinearLayout createLanguageSection() {
        LinearLayout languageLayout = new LinearLayout(this);
        languageLayout.setOrientation(LinearLayout.VERTICAL);
        languageLayout.setBackgroundColor(0xFFFFFFFF);
        languageLayout.setPadding(16, 16, 16, 16);
        
        TextView titleText = new TextView(this);
        titleText.setText("Interface Language");
        titleText.setTextSize(18);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        titleText.setPadding(0, 0, 0, 12);
        
        languageLayout.addView(titleText);No fieldset grouping for related radio buttons
        LinearLayout optionsLayout = new LinearLayout(this);
        optionsLayout.setOrientation(LinearLayout.HORIZONTAL);
        
        RadioButton englishRadio = new RadioButton(this);
        englishRadio.setText("English");
        englishRadio.setPadding(0, 0, 16, 0);
        
        RadioButton spanishRadio = new RadioButton(this);
        spanishRadio.setText("Español");
        spanishRadio.setPadding(0, 0, 16, 0);
        
        RadioButton frenchRadio = new RadioButton(this);
        frenchRadio.setText("Français");
        
        optionsLayout.addView(englishRadio);
        optionsLayout.addView(spanishRadio);
        optionsLayout.addView(frenchRadio);
        
        languageLayout.addView(optionsLayout);
        
        return languageLayout;
    }
}
