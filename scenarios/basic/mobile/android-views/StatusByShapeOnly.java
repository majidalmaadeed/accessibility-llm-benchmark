package com.example.accessibilityscenarios;

import android.app.Activity;
import android.graphics.drawable.GradientDrawable;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

public class StatusByShapeOnlyActivity extends Activity {
    
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
        
        // Legend - Missing text descriptions
        LinearLayout legendLayout = createLegend();
        mainLayout.addView(legendLayout);
        
        // Documents List
        LinearLayout documentsLayout = createDocumentsList();
        mainLayout.addView(documentsLayout);
        
        scrollView.addView(mainLayout);
        setContentView(scrollView);
    }
    
    private LinearLayout createHeader() {
        LinearLayout headerLayout = new LinearLayout(this);
        headerLayout.setOrientation(LinearLayout.VERTICAL);
        headerLayout.setBackgroundColor(0xFF2196F3);
        headerLayout.setPadding(32, 32, 32, 32);
        
        TextView titleText = new TextView(this);
        titleText.setText("Document Management");
        titleText.setTextSize(24);
        titleText.setTextColor(0xFFFFFFFF);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        
        TextView subtitleText = new TextView(this);
        subtitleText.setText("Track document approval status");
        subtitleText.setTextSize(16);
        subtitleText.setTextColor(0xE6FFFFFF);
        
        headerLayout.addView(titleText);
        headerLayout.addView(subtitleText);
        
        return headerLayout;
    }
    
    private LinearLayout createLegend() {
        LinearLayout legendLayout = new LinearLayout(this);
        legendLayout.setOrientation(LinearLayout.VERTICAL);
        legendLayout.setBackgroundColor(0xFFFFFFFF);
        legendLayout.setPadding(16, 16, 16, 16);
        
        TextView legendTitle = new TextView(this);
        legendTitle.setText("Status Legend");
        legendTitle.setTextSize(16);
        legendTitle.setTypeface(null, android.graphics.Typeface.BOLD);
        legendTitle.setPadding(0, 0, 0, 12);
        
        legendLayout.addView(legendTitle);
        
        LinearLayout itemsLayout = new LinearLayout(this);
        itemsLayout.setOrientation(LinearLayout.HORIZONTAL);
        
        // STATUS BY SHAPE ONLY - No text descriptions
        LinearLayout approvedLayout = createLegendItem("circle", 0xFF4CAF50, "✓", "Approved");
        LinearLayout pendingLayout = createLegendItem("square", 0xFFFF9800, "⏰", "Pending");
        LinearLayout rejectedLayout = createLegendItem("square", 0xFFE53E3E, "✕", "Rejected");
        
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        itemsLayout.addView(approvedLayout, params);
        itemsLayout.addView(pendingLayout, params);
        itemsLayout.addView(rejectedLayout, params);
        
        legendLayout.addView(itemsLayout);
        
        return legendLayout;
    }
    
    private LinearLayout createLegendItem(String shape, int color, String icon, String text) {
        LinearLayout itemLayout = new LinearLayout(this);
        itemLayout.setOrientation(LinearLayout.VERTICAL);
        itemLayout.setGravity(android.view.Gravity.CENTER_HORIZONTAL);
        
        // Status indicator by shape only
        LinearLayout statusShape = new LinearLayout(this);
        statusShape.setMinimumWidth(48);
        statusShape.setMinimumHeight(48);
        statusShape.setGravity(android.view.Gravity.CENTER);
        
        GradientDrawable shapeDrawable = new GradientDrawable();
        shapeDrawable.setColor(color);
        if (shape.equals("circle")) {
            shapeDrawable.setCornerRadius(24); // Circle = Approved
        } else {
            shapeDrawable.setCornerRadius(8); // Square = Pending/Rejected
        }
        statusShape.setBackground(shapeDrawable);
        
        TextView iconText = new TextView(this);
        iconText.setText(icon);
        iconText.setTextColor(0xFFFFFFFF);
        iconText.setTextSize(16);
        statusShape.addView(iconText);
        
        TextView labelText = new TextView(this);
        labelText.setText(text); // MISSING: Should be programmatically associated
        labelText.setTextSize(12);
        labelText.setTextColor(0xFF666666);
        labelText.setPadding(0, 8, 0, 0);
        
        itemLayout.addView(statusShape);
        itemLayout.addView(labelText);
        
        return itemLayout;
    }
    
    private LinearLayout createDocumentsList() {
        LinearLayout documentsLayout = new LinearLayout(this);
        documentsLayout.setOrientation(LinearLayout.VERTICAL);
        documentsLayout.setBackgroundColor(0xFFFFFFFF);
        documentsLayout.setPadding(16, 16, 16, 16);
        
        String[][] documents = {
            {"Project Proposal.docx", "approved", "2024-01-15", "2.4 MB"},
            {"Budget Report.xlsx", "pending", "2024-01-14", "1.8 MB"},
            {"Meeting Notes.pdf", "rejected", "2024-01-13", "856 KB"},
            {"Contract Template.docx", "approved", "2024-01-12", "3.2 MB"},
            {"Invoice #12345.pdf", "pending", "2024-01-11", "1.1 MB"}
        };
        
        for (String[] doc : documents) {
            LinearLayout docItem = createDocumentCard(doc[0], doc[1], doc[2], doc[3]);
            documentsLayout.addView(docItem);
        }
        
        return documentsLayout;
    }
    
    private LinearLayout createDocumentCard(String name, String status, String date, String size) {
        LinearLayout cardLayout = new LinearLayout(this);
        cardLayout.setOrientation(LinearLayout.HORIZONTAL);
        cardLayout.setBackgroundColor(0xFFF8F9FA);
        cardLayout.setPadding(16, 16, 16, 16);
        
        // Document Icon
        TextView docIcon = new TextView(this);
        docIcon.setText("📄");
        docIcon.setTextSize(20);
        docIcon.setPadding(0, 0, 12, 0);
        
        // Document Info
        LinearLayout infoLayout = new LinearLayout(this);
        infoLayout.setOrientation(LinearLayout.VERTICAL);
        
        TextView nameText = new TextView(this);
        nameText.setText(name);
        nameText.setTextSize(16);
        nameText.setTypeface(null, android.graphics.Typeface.BOLD);
        
        TextView detailsText = new TextView(this);
        detailsText.setText(date + " • " + size);
        detailsText.setTextSize(12);
        detailsText.setTextColor(0xFF666666);
        
        infoLayout.addView(nameText);
        infoLayout.addView(detailsText);
        
        // Status Indicator - STATUS BY SHAPE ONLY
        LinearLayout statusShape = new LinearLayout(this);
        statusShape.setMinimumWidth(48);
        statusShape.setMinimumHeight(48);
        statusShape.setGravity(android.view.Gravity.CENTER);
        
        GradientDrawable shapeDrawable = new GradientDrawable();
        TextView statusIcon = new TextView(this);
        statusIcon.setTextColor(0xFFFFFFFF);
        statusIcon.setTextSize(16);
        
        if (status.equals("approved")) {
            shapeDrawable.setColor(0xFF4CAF50);
            shapeDrawable.setCornerRadius(24); // Circle shape
            statusIcon.setText("✓");
        } else if (status.equals("pending")) {
            shapeDrawable.setColor(0xFFFF9800);
            shapeDrawable.setCornerRadius(8); // Square shape
            statusIcon.setText("⏰");
        } else {
            shapeDrawable.setColor(0xFFE53E3E);
            shapeDrawable.setCornerRadius(8); // Square shape
            statusIcon.setText("✕");
        }
        
        statusShape.setBackground(shapeDrawable);
        statusShape.addView(statusIcon);
        statusShape.setContentDescription(null); // MISSING: No accessible description for status
        
        LinearLayout.LayoutParams iconParams = new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.WRAP_CONTENT, 
            LinearLayout.LayoutParams.WRAP_CONTENT);
        cardLayout.addView(docIcon, iconParams);
        
        LinearLayout.LayoutParams infoParams = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        cardLayout.addView(infoLayout, infoParams);
        
        LinearLayout.LayoutParams statusParams = new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.WRAP_CONTENT, 
            LinearLayout.LayoutParams.WRAP_CONTENT);
        cardLayout.addView(statusShape, statusParams);
        
        return cardLayout;
    }
}
