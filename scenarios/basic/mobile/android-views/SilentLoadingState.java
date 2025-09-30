package com.example.accessibilityscenarios;

import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.ScrollView;
import android.widget.TextView;
import java.util.ArrayList;
import java.util.List;

public class SilentLoadingStateActivity extends Activity {
    
    private boolean isLoading = false;
    private List<String> dataItems = new ArrayList<>();
    private LinearLayout contentLayout;
    private ProgressBar progressBar;
    private TextView loadingText;
    private Handler handler = new Handler();
    
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
        
        LinearLayout buttonsLayout = createActionButtons();
        mainLayout.addView(buttonsLayout);
        
        LinearLayout dataLayout = createDataSection();
        mainLayout.addView(dataLayout);
        
        scrollView.addView(mainLayout);
        setContentView(scrollView);
    }
    
    private LinearLayout createHeader() {
        LinearLayout headerLayout = new LinearLayout(this);
        headerLayout.setOrientation(LinearLayout.VERTICAL);
        headerLayout.setBackgroundColor(0xFF2196F3);
        headerLayout.setPadding(32, 32, 32, 32);
        
        TextView titleText = new TextView(this);
        titleText.setText("Project Dashboard");
        titleText.setTextSize(24);
        titleText.setTextColor(0xFFFFFFFF);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        
        TextView subtitleText = new TextView(this);
        subtitleText.setText("Track your project progress");
        subtitleText.setTextSize(16);
        subtitleText.setTextColor(0xE6FFFFFF);
        
        headerLayout.addView(titleText);
        headerLayout.addView(subtitleText);
        
        return headerLayout;
    }
    
    private LinearLayout createActionButtons() {
        LinearLayout buttonsLayout = new LinearLayout(this);
        buttonsLayout.setOrientation(LinearLayout.HORIZONTAL);
        buttonsLayout.setBackgroundColor(0xFFFFFFFF);
        buttonsLayout.setPadding(16, 16, 16, 16);
        
        Button loadButton = new Button(this);
        loadButton.setText("Load Data");
        loadButton.setBackgroundColor(0xFF4CAF50);
        loadButton.setTextColor(0xFFFFFFFF);
        loadButton.setPadding(16, 16, 16, 16);
        loadButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                loadData();
            }
        });
        
        Button clearButton = new Button(this);
        clearButton.setText("Clear Data");
        clearButton.setBackgroundColor(0xFFE53E3E);
        clearButton.setTextColor(0xFFFFFFFF);
        clearButton.setPadding(16, 16, 16, 16);
        clearButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                clearData();
            }
        });
        
        LinearLayout.LayoutParams buttonParams = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        buttonParams.setMargins(0, 0, 8, 0);
        buttonsLayout.addView(loadButton, buttonParams);
        
        LinearLayout.LayoutParams clearParams = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        clearParams.setMargins(8, 0, 0, 0);
        buttonsLayout.addView(clearButton, clearParams);
        
        return buttonsLayout;
    }
    
    private LinearLayout createDataSection() {
        LinearLayout dataLayout = new LinearLayout(this);
        dataLayout.setOrientation(LinearLayout.VERTICAL);
        dataLayout.setBackgroundColor(0xFFFFFFFF);
        dataLayout.setPadding(16, 16, 16, 16);
        
        TextView sectionTitle = new TextView(this);
        sectionTitle.setText("Project List");
        sectionTitle.setTextSize(18);
        sectionTitle.setTypeface(null, android.graphics.Typeface.BOLD);
        sectionTitle.setTextColor(0xFF1976D2);
        sectionTitle.setPadding(0, 0, 0, 16);
        
        dataLayout.addView(sectionTitle);
        
        // Loading State - SILENT (No screen reader announcement)
        LinearLayout loadingLayout = new LinearLayout(this);
        loadingLayout.setOrientation(LinearLayout.VERTICAL);
        loadingLayout.setGravity(android.view.Gravity.CENTER);
        loadingLayout.setMinimumHeight(200);
        
        progressBar = new ProgressBar(this);
        progressBar.setVisibility(View.GONE);
        
        loadingText = new TextView(this);
        loadingText.setText("Loading projects...");
        loadingText.setTextSize(16);
        loadingText.setTextColor(0xFF666666);
        loadingText.setGravity(android.view.Gravity.CENTER);
        loadingText.setVisibility(View.GONE);
        // MISSING: No screen reader announcement for loading state
        
        loadingLayout.addView(progressBar);
        loadingLayout.addView(loadingText);
        
        // Empty State
        LinearLayout emptyLayout = new LinearLayout(this);
        emptyLayout.setOrientation(LinearLayout.VERTICAL);
        emptyLayout.setGravity(android.view.Gravity.CENTER);
        emptyLayout.setMinimumHeight(200);
        
        TextView emptyIcon = new TextView(this);
        emptyIcon.setText("📂");
        emptyIcon.setTextSize(32);
        emptyIcon.setGravity(android.view.Gravity.CENTER);
        
        TextView emptyText = new TextView(this);
        emptyText.setText("No projects found");
        emptyText.setTextSize(16);
        emptyText.setTextColor(0xFF666666);
        emptyText.setGravity(android.view.Gravity.CENTER);
        emptyText.setPadding(0, 8, 0, 0);
        
        TextView emptySubtext = new TextView(this);
        emptySubtext.setText("Click 'Load Data' to fetch projects");
        emptySubtext.setTextSize(14);
        emptySubtext.setTextColor(0xFF666666);
        emptySubtext.setGravity(android.view.Gravity.CENTER);
        
        emptyLayout.addView(emptyIcon);
        emptyLayout.addView(emptyText);
        emptyLayout.addView(emptySubtext);
        
        // Content Layout
        contentLayout = new LinearLayout(this);
        contentLayout.setOrientation(LinearLayout.VERTICAL);
        contentLayout.setVisibility(View.GONE);
        
        dataLayout.addView(loadingLayout);
        dataLayout.addView(emptyLayout);
        dataLayout.addView(contentLayout);
        
        return dataLayout;
    }
    
    private void loadData() {
        if (isLoading) return;
        
        isLoading = true;
        progressBar.setVisibility(View.VISIBLE);
        loadingText.setVisibility(View.VISIBLE);
        contentLayout.setVisibility(View.GONE);
        
        // Simulate API call delay
        handler.postDelayed(new Runnable() {
            @Override
            public void run() {
                dataItems.clear();
                dataItems.add("Project Alpha - In Progress - 2024-01-15");
                dataItems.add("Project Beta - Completed - 2024-01-10");
                dataItems.add("Project Gamma - Planning - 2024-01-20");
                dataItems.add("Project Delta - In Progress - 2024-01-12");
                
                updateDataDisplay();
                
                progressBar.setVisibility(View.GONE);
                loadingText.setVisibility(View.GONE);
                contentLayout.setVisibility(View.VISIBLE);
                
                isLoading = false;
            }
        }, 2000);
    }
    
    private void clearData() {
        dataItems.clear();
        contentLayout.setVisibility(View.GONE);
    }
    
    private void updateDataDisplay() {
        contentLayout.removeAllViews();
        
        for (String item : dataItems) {
            TextView itemText = new TextView(this);
            itemText.setText("• " + item);
            itemText.setTextSize(14);
            itemText.setTextColor(0xFF333333);
            itemText.setPadding(0, 8, 0, 8);
            contentLayout.addView(itemText);
        }
    }
}
