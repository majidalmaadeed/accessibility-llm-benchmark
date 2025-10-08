package com.example.uicomponents;

import android.app.Activity;
import android.app.Dialog;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

public class KeyboardTrapInWidgetActivity extends Activity {
    
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
        
        LinearLayout scheduleLayout = createScheduleSection();
        mainLayout.addView(scheduleLayout);
        
        LinearLayout appointmentsLayout = createAppointmentsList();
        mainLayout.addView(appointmentsLayout);
        
        scrollView.addView(mainLayout);
        setContentView(scrollView);
    }
    
    private LinearLayout createHeader() {
        LinearLayout headerLayout = new LinearLayout(this);
        headerLayout.setOrientation(LinearLayout.VERTICAL);
        headerLayout.setBackgroundColor(0xFF2196F3);
        headerLayout.setPadding(32, 32, 32, 32);
        
        TextView titleText = new TextView(this);
        titleText.setText("Appointment Scheduler");
        titleText.setTextSize(24);
        titleText.setTextColor(0xFFFFFFFF);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        
        TextView subtitleText = new TextView(this);
        subtitleText.setText("Schedule and manage your appointments");
        subtitleText.setTextSize(16);
        subtitleText.setTextColor(0xE6FFFFFF);
        
        headerLayout.addView(titleText);
        headerLayout.addView(subtitleText);
        
        return headerLayout;
    }
    
    private LinearLayout createScheduleSection() {
        LinearLayout scheduleLayout = new LinearLayout(this);
        scheduleLayout.setOrientation(LinearLayout.HORIZONTAL);
        scheduleLayout.setBackgroundColor(0xFFFFFFFF);
        scheduleLayout.setPadding(16, 16, 16, 16);
        
        TextView scheduleText = new TextView(this);
        scheduleText.setText("Schedule New Appointment");
        scheduleText.setTextSize(18);
        scheduleText.setTypeface(null, android.graphics.Typeface.BOLD);
        scheduleText.setTextColor(0xFF1976D2);
        
        Button newAppointmentButton = new Button(this);
        newAppointmentButton.setText("New Appointment");
        newAppointmentButton.setBackgroundColor(0xFF4CAF50);
        newAppointmentButton.setTextColor(0xFFFFFFFF);
        newAppointmentButton.setPadding(16, 16, 16, 16);
        newAppointmentButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                showDatePicker();
            }
        });
        
        LinearLayout.LayoutParams textParams = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        scheduleLayout.addView(scheduleText, textParams);
        
        LinearLayout.LayoutParams buttonParams = new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.WRAP_CONTENT, 
            LinearLayout.LayoutParams.WRAP_CONTENT);
        scheduleLayout.addView(newAppointmentButton, buttonParams);
        
        return scheduleLayout;
    }
    
    private LinearLayout createAppointmentsList() {
        LinearLayout appointmentsLayout = new LinearLayout(this);
        appointmentsLayout.setOrientation(LinearLayout.VERTICAL);
        appointmentsLayout.setBackgroundColor(0xFFFFFFFF);
        appointmentsLayout.setPadding(16, 16, 16, 16);
        
        String[][] appointments = {
            {"Doctor's Appointment", "2024-01-20", "10:00 AM", "30 minutes"},
            {"Team Meeting", "2024-01-22", "2:00 PM", "1 hour"},
            {"Dentist Visit", "2024-01-25", "3:30 PM", "45 minutes"}
        };
        
        for (String[] appointment : appointments) {
            LinearLayout appointmentItem = createAppointmentCard(appointment[0], appointment[1], appointment[2], appointment[3]);
            appointmentsLayout.addView(appointmentItem);
        }
        
        return appointmentsLayout;
    }
    
    private LinearLayout createAppointmentCard(String title, String date, String time, String duration) {
        LinearLayout cardLayout = new LinearLayout(this);
        cardLayout.setOrientation(LinearLayout.HORIZONTAL);
        cardLayout.setBackgroundColor(0xFFFFFFFF);
        cardLayout.setPadding(16, 16, 16, 16);
        
        TextView iconText = new TextView(this);
        iconText.setText("📅");
        iconText.setTextSize(20);
        iconText.setPadding(0, 0, 12, 0);
        
        LinearLayout infoLayout = new LinearLayout(this);
        infoLayout.setOrientation(LinearLayout.VERTICAL);
        
        TextView titleText = new TextView(this);
        titleText.setText(title);
        titleText.setTextSize(16);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        titleText.setTextColor(0xFF1976D2);
        
        TextView dateText = new TextView(this);
        dateText.setText("Date: " + date);
        dateText.setTextSize(14);
        dateText.setTextColor(0xFF666666);
        
        TextView timeText = new TextView(this);
        timeText.setText("Time: " + time);
        timeText.setTextSize(14);
        timeText.setTextColor(0xFF666666);
        
        TextView durationText = new TextView(this);
        durationText.setText("Duration: " + duration);
        durationText.setTextSize(12);
        durationText.setTextColor(0xFF666666);
        
        infoLayout.addView(titleText);
        infoLayout.addView(dateText);
        infoLayout.addView(timeText);
        infoLayout.addView(durationText);
        
        cardLayout.addView(iconText);
        
        LinearLayout.LayoutParams infoParams = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        cardLayout.addView(infoLayout, infoParams);
        
        return cardLayout;
    }
    
    // Custom Date Picker Widget - KEYBOARD TRAP
    private void showDatePicker() {
        final Dialog dialog = new Dialog(this);
        dialog.setContentView(createDatePickerDialog());
        dialog.setTitle("Select Date and Time");
        dialog.show();
    }
    
    private LinearLayout createDatePickerDialog() {
        LinearLayout dialogLayout = new LinearLayout(this);
        dialogLayout.setOrientation(LinearLayout.VERTICAL);
        dialogLayout.setPadding(20, 20, 20, 20);
        
        TextView titleText = new TextView(this);
        titleText.setText("Select Date and Time");
        titleText.setTextSize(20);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        titleText.setTextColor(0xFF1976D2);
        titleText.setPadding(0, 0, 0, 20);
        
        // Date Selection - KEYBOARD TRAP
        TextView dateLabel = new TextView(this);
        dateLabel.setText("Date");
        dateLabel.setTextSize(16);
        dateLabel.setTypeface(null, android.graphics.Typeface.BOLD);
        dateLabel.setTextColor(0xFF1976D2);
        dateLabel.setPadding(0, 0, 0, 8);
        
        LinearLayout dateLayout = new LinearLayout(this);
        dateLayout.setOrientation(LinearLayout.HORIZONTAL);
        
        // Custom date picker that traps keyboard focus
        EditText monthField = new EditText(this);
        monthField.setHint("Month");
        monthField.setText("01");
        monthField.setPadding(8, 8, 8, 8);
        
        EditText dayField = new EditText(this);
        dayField.setHint("Day");
        dayField.setText("01");
        dayField.setPadding(8, 8, 8, 8);
        
        EditText yearField = new EditText(this);
        yearField.setHint("Year");
        yearField.setText("2024");
        yearField.setPadding(8, 8, 8, 8);
        
        LinearLayout.LayoutParams fieldParams = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        fieldParams.setMargins(0, 0, 8, 0);
        dateLayout.addView(monthField, fieldParams);
        dateLayout.addView(dayField, fieldParams);
        dateLayout.addView(yearField, fieldParams);
        
        // Time Selection - KEYBOARD TRAP
        TextView timeLabel = new TextView(this);
        timeLabel.setText("Time");
        timeLabel.setTextSize(16);
        timeLabel.setTypeface(null, android.graphics.Typeface.BOLD);
        timeLabel.setTextColor(0xFF1976D2);
        timeLabel.setPadding(0, 16, 0, 8);
        
        LinearLayout timeLayout = new LinearLayout(this);
        timeLayout.setOrientation(LinearLayout.HORIZONTAL);
        
        EditText hourField = new EditText(this);
        hourField.setHint("Hour");
        hourField.setText("10");
        hourField.setPadding(8, 8, 8, 8);
        
        EditText minuteField = new EditText(this);
        minuteField.setHint("Minute");
        minuteField.setText("00");
        minuteField.setPadding(8, 8, 8, 8);
        
        EditText periodField = new EditText(this);
        periodField.setHint("Period");
        periodField.setText("AM");
        periodField.setPadding(8, 8, 8, 8);
        
        LinearLayout.LayoutParams timeFieldParams = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        timeFieldParams.setMargins(0, 0, 8, 0);
        timeLayout.addView(hourField, timeFieldParams);
        timeLayout.addView(minuteField, timeFieldParams);
        timeLayout.addView(periodField, timeFieldParams);
        
        // Action Buttons - KEYBOARD TRAP
        LinearLayout buttonLayout = new LinearLayout(this);
        buttonLayout.setOrientation(LinearLayout.HORIZONTAL);
        buttonLayout.setPadding(0, 20, 0, 0);
        
        Button cancelButton = new Button(this);
        cancelButton.setText("Cancel");
        cancelButton.setBackgroundColor(0xFFFFFFFF);
        cancelButton.setTextColor(0xFF2196F3);
        cancelButton.setPadding(16, 16, 16, 16);
        
        Button confirmButton = new Button(this);
        confirmButton.setText("Confirm");
        confirmButton.setBackgroundColor(0xFF4CAF50);
        confirmButton.setTextColor(0xFFFFFFFF);
        confirmButton.setPadding(16, 16, 16, 16);
        
        LinearLayout.LayoutParams buttonParams = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        buttonParams.setMargins(0, 0, 8, 0);
        buttonLayout.addView(cancelButton, buttonParams);
        
        LinearLayout.LayoutParams confirmParams = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        confirmParams.setMargins(8, 0, 0, 0);
        buttonLayout.addView(confirmButton, confirmParams);
        
        dialogLayout.addView(titleText);
        dialogLayout.addView(dateLabel);
        dialogLayout.addView(dateLayout);
        dialogLayout.addView(timeLabel);
        dialogLayout.addView(timeLayout);
        dialogLayout.addView(buttonLayout);
        
        return dialogLayout;
    }
}
