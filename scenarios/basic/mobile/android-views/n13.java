package com.example.uicomponents;

import android.app.Activity;
import android.os.Bundle;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

public class InsufficientButtonSpacingActivity extends Activity {
    
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
        
        LinearLayout tasksLayout = createTasksList();
        mainLayout.addView(tasksLayout);
        
        scrollView.addView(mainLayout);
        setContentView(scrollView);
    }
    
    private LinearLayout createHeader() {
        LinearLayout headerLayout = new LinearLayout(this);
        headerLayout.setOrientation(LinearLayout.VERTICAL);
        headerLayout.setBackgroundColor(0xFF2196F3);
        headerLayout.setPadding(32, 32, 32, 32);
        
        TextView titleText = new TextView(this);
        titleText.setText("Task Manager");
        titleText.setTextSize(24);
        titleText.setTextColor(0xFFFFFFFF);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        
        TextView subtitleText = new TextView(this);
        subtitleText.setText("Manage your daily tasks efficiently");
        subtitleText.setTextSize(16);
        subtitleText.setTextColor(0xE6FFFFFF);
        
        headerLayout.addView(titleText);
        headerLayout.addView(subtitleText);
        
        return headerLayout;
    }
    
    private LinearLayout createTasksList() {
        LinearLayout tasksLayout = new LinearLayout(this);
        tasksLayout.setOrientation(LinearLayout.VERTICAL);
        tasksLayout.setBackgroundColor(0xFFFFFFFF);
        tasksLayout.setPadding(16, 16, 16, 16);
        
        String[][] tasks = {
            {"Review Project Proposal", "Review the Q1 project proposal and provide feedback", "High", "2024-01-20"},
            {"Update Documentation", "Update API documentation for the new features", "Medium", "2024-01-22"},
            {"Team Meeting", "Weekly team standup meeting", "Low", "2024-01-18"},
            {"Code Review", "Review pull requests from the development team", "High", "2024-01-19"}
        };
        
        for (String[] task : tasks) {
            LinearLayout taskItem = createTaskCard(task[0], task[1], task[2], task[3]);
            tasksLayout.addView(taskItem);
        }
        
        return tasksLayout;
    }
    
    private LinearLayout createTaskCard(String title, String description, String priority, String dueDate) {
        LinearLayout cardLayout = new LinearLayout(this);
        cardLayout.setOrientation(LinearLayout.VERTICAL);
        cardLayout.setBackgroundColor(0xFFFFFFFF);
        cardLayout.setPadding(16, 16, 16, 16);
        
        LinearLayout headerRow = new LinearLayout(this);
        headerRow.setOrientation(LinearLayout.HORIZONTAL);
        
        TextView titleText = new TextView(this);
        titleText.setText(title);
        titleText.setTextSize(18);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        
        TextView priorityText = new TextView(this);
        priorityText.setText(priority);
        priorityText.setTextSize(12);
        int priorityColor = priority.equals("High") ? 0xFFE53E3E : 
                          priority.equals("Medium") ? 0xFFFF9800 : 0xFF4CAF50;
        priorityText.setTextColor(priorityColor);
        priorityText.setBackgroundColor(priorityColor & 0x1AFFFFFF);
        priorityText.setPadding(8, 4, 8, 4);
        
        LinearLayout.LayoutParams titleParams = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        headerRow.addView(titleText, titleParams);
        headerRow.addView(priorityText);
        
        TextView descText = new TextView(this);
        descText.setText(description);
        descText.setTextSize(14);
        descText.setTextColor(0xFF666666);
        descText.setPadding(0, 8, 0, 8);
        
        TextView dueDateText = new TextView(this);
        dueDateText.setText("Due: " + dueDate);
        dueDateText.setTextSize(12);
        dueDateText.setTextColor(0xFF666666);
        dueDateText.setPadding(0, 0, 0, 12);
        
        // Action Buttons - INSUFFICIENT SPACING
        LinearLayout buttonsLayout = new LinearLayout(this);
        buttonsLayout.setOrientation(LinearLayout.HORIZONTAL);
        
        Button completeButton = new Button(this);
        completeButton.setText("Complete");
        completeButton.setBackgroundColor(0xFF4CAF50);
        completeButton.setTextColor(0xFFFFFFFF);
        completeButton.setPadding(12, 12, 12, 12);
        
        Button editButton = new Button(this);
        editButton.setText("Edit");
        editButton.setBackgroundColor(0xFFFFFFFF);
        editButton.setTextColor(0xFF2196F3);
        editButton.setPadding(12, 12, 12, 12);
        
        Button shareButton = new Button(this);
        shareButton.setText("Share");
        shareButton.setBackgroundColor(0xFFFFFFFF);
        shareButton.setTextColor(0xFF2196F3);
        shareButton.setPadding(12, 12, 12, 12);
        
        Button deleteButton = new Button(this);
        deleteButton.setText("Delete");
        deleteButton.setBackgroundColor(0xFFFFFFFF);
        deleteButton.setTextColor(0xFFE53E3E);
        deleteButton.setPadding(12, 12, 12, 12);
        
        LinearLayout.LayoutParams buttonParams = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        buttonParams.setMargins(2, 0, 2, 0); // TOO SMALL: Only 2dp spacing instead of minimum 44dp
        
        buttonsLayout.addView(completeButton, buttonParams);
        buttonsLayout.addView(editButton, buttonParams);
        buttonsLayout.addView(shareButton, buttonParams);
        buttonsLayout.addView(deleteButton, buttonParams);
        
        cardLayout.addView(headerRow);
        cardLayout.addView(descText);
        cardLayout.addView(dueDateText);
        cardLayout.addView(buttonsLayout);
        
        return cardLayout;
    }
}
