package com.example.accessibilityscenarios;

import android.app.Activity;
import android.os.Bundle;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.Switch;
import android.widget.TextView;

public class MissingPageTitleActivity extends Activity {
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        ScrollView scrollView = new ScrollView(this);
        LinearLayout mainLayout = new LinearLayout(this);
        mainLayout.setOrientation(LinearLayout.VERTICAL);
        mainLayout.setBackgroundColor(0xFFF5F5F5);
        
        LinearLayout headerLayout = createHeader();
        mainLayout.addView(headerLayout);
        
        LinearLayout settingsLayout = createSettingsList();
        mainLayout.addView(settingsLayout);
        
        scrollView.addView(mainLayout);
        setContentView(scrollView);
    }
    
    private LinearLayout createHeader() {
        LinearLayout headerLayout = new LinearLayout(this);
        headerLayout.setOrientation(LinearLayout.HORIZONTAL);
        headerLayout.setBackgroundColor(0xFF1976D2);
        headerLayout.setPadding(16, 16, 16, 16);
        
        ImageButton backButton = new ImageButton(this);
        backButton.setImageResource(android.R.drawable.ic_menu_revert);
        backButton.setBackgroundColor(android.graphics.Color.TRANSPARENT);
        backButton.setContentDescription("Back");
        backButton.setPadding(8, 8, 8, 8);
        
        // MISSING: No descriptive page title
        TextView titleText = new TextView(this);
        titleText.setText("Settings"); // TOO GENERIC: Should be more descriptive
        titleText.setTextSize(24);
        titleText.setTextColor(0xFFFFFFFF);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        titleText.setPadding(16, 0, 0, 0);
        
        headerLayout.addView(backButton);
        headerLayout.addView(titleText);
        
        return headerLayout;
    }
    
    private LinearLayout createSettingsList() {
        LinearLayout settingsLayout = new LinearLayout(this);
        settingsLayout.setOrientation(LinearLayout.VERTICAL);
        settingsLayout.setPadding(16, 16, 16, 16);
        
        String[][] settings = {
            {"Account Information", "Manage your personal account details", "👤", "false"},
            {"Notifications", "Configure notification preferences", "🔔", "true"},
            {"Privacy Settings", "Control your privacy and data sharing", "🔒", "false"},
            {"Theme", "Choose your preferred app theme", "🎨", "false"},
            {"Language", "Select your preferred language", "🌐", "false"},
            {"Data Usage", "Monitor and control data consumption", "📊", "true"}
        };
        
        for (String[] setting : settings) {
            LinearLayout settingItem = createSettingCard(setting[0], setting[1], setting[2], setting[3].equals("true"));
            settingsLayout.addView(settingItem);
        }
        
        return settingsLayout;
    }
    
    private LinearLayout createSettingCard(String title, String description, String icon, boolean hasToggle) {
        LinearLayout cardLayout = new LinearLayout(this);
        cardLayout.setOrientation(LinearLayout.HORIZONTAL);
        cardLayout.setBackgroundColor(0xFFFFFFFF);
        cardLayout.setPadding(16, 16, 16, 16);
        
        TextView iconText = new TextView(this);
        iconText.setText(icon);
        iconText.setTextSize(20);
        iconText.setPadding(0, 0, 16, 0);
        
        LinearLayout infoLayout = new LinearLayout(this);
        infoLayout.setOrientation(LinearLayout.VERTICAL);
        
        TextView titleText = new TextView(this);
        titleText.setText(title);
        titleText.setTextSize(16);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        titleText.setTextColor(0xFF1976D2);
        
        TextView descText = new TextView(this);
        descText.setText(description);
        descText.setTextSize(14);
        descText.setTextColor(0xFF666666);
        
        infoLayout.addView(titleText);
        infoLayout.addView(descText);
        
        cardLayout.addView(iconText);
        
        LinearLayout.LayoutParams infoParams = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        cardLayout.addView(infoLayout, infoParams);
        
        if (hasToggle) {
            Switch settingSwitch = new Switch(this);
            settingSwitch.setChecked(false);
            cardLayout.addView(settingSwitch);
        } else {
            TextView chevronText = new TextView(this);
            chevronText.setText(">");
            chevronText.setTextSize(16);
            chevronText.setTextColor(0xFF666666);
            cardLayout.addView(chevronText);
        }
        
        return cardLayout;
    }
}
