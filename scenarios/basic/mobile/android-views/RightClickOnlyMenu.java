package com.example.accessibilityscenarios;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.view.ContextMenu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

public class RightClickOnlyMenuActivity extends Activity {
    
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
        
        LinearLayout toolbarLayout = createToolbar();
        mainLayout.addView(toolbarLayout);
        
        LinearLayout filesLayout = createFilesList();
        mainLayout.addView(filesLayout);
        
        LinearLayout footerLayout = createFooter();
        mainLayout.addView(footerLayout);
        
        scrollView.addView(mainLayout);
        setContentView(scrollView);
    }
    
    private LinearLayout createHeader() {
        LinearLayout headerLayout = new LinearLayout(this);
        headerLayout.setOrientation(LinearLayout.VERTICAL);
        headerLayout.setBackgroundColor(0xFF2196F3);
        headerLayout.setPadding(32, 32, 32, 32);
        
        TextView titleText = new TextView(this);
        titleText.setText("File Manager");
        titleText.setTextSize(24);
        titleText.setTextColor(0xFFFFFFFF);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        
        TextView subtitleText = new TextView(this);
        subtitleText.setText("Manage your files and documents");
        subtitleText.setTextSize(16);
        subtitleText.setTextColor(0xE6FFFFFF);
        
        headerLayout.addView(titleText);
        headerLayout.addView(subtitleText);
        
        return headerLayout;
    }
    
    private LinearLayout createToolbar() {
        LinearLayout toolbarLayout = new LinearLayout(this);
        toolbarLayout.setOrientation(LinearLayout.HORIZONTAL);
        toolbarLayout.setBackgroundColor(0xFFFFFFFF);
        toolbarLayout.setPadding(16, 16, 16, 16);
        
        Button newButton = new Button(this);
        newButton.setText("New File");
        newButton.setBackgroundColor(0xFF4CAF50);
        newButton.setTextColor(0xFFFFFFFF);
        newButton.setPadding(12, 12, 12, 12);
        
        Button uploadButton = new Button(this);
        uploadButton.setText("Upload");
        uploadButton.setBackgroundColor(0xFF2196F3);
        uploadButton.setTextColor(0xFFFFFFFF);
        uploadButton.setPadding(12, 12, 12, 12);
        
        Button downloadButton = new Button(this);
        downloadButton.setText("Download");
        downloadButton.setBackgroundColor(0xFFFF9800);
        downloadButton.setTextColor(0xFFFFFFFF);
        downloadButton.setPadding(12, 12, 12, 12);
        
        LinearLayout.LayoutParams buttonParams = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        buttonParams.setMargins(0, 0, 8, 0);
        toolbarLayout.addView(newButton, buttonParams);
        toolbarLayout.addView(uploadButton, buttonParams);
        
        LinearLayout.LayoutParams downloadParams = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        toolbarLayout.addView(downloadButton, downloadParams);
        
        return toolbarLayout;
    }
    
    private LinearLayout createFilesList() {
        LinearLayout filesLayout = new LinearLayout(this);
        filesLayout.setOrientation(LinearLayout.VERTICAL);
        filesLayout.setBackgroundColor(0xFFFFFFFF);
        filesLayout.setPadding(16, 16, 16, 16);
        
        TextView filesTitle = new TextView(this);
        filesTitle.setText("Files");
        filesTitle.setTextSize(18);
        filesTitle.setTypeface(null, android.graphics.Typeface.BOLD);
        filesTitle.setTextColor(0xFF1976D2);
        filesTitle.setPadding(0, 0, 0, 16);
        
        filesLayout.addView(filesTitle);
        
        String[][] files = {
            {"Project Proposal.docx", "Document", "2.4 MB", "2024-01-15"},
            {"Budget Report.xlsx", "Spreadsheet", "1.8 MB", "2024-01-14"},
            {"Meeting Notes.pdf", "Document", "856 KB", "2024-01-13"},
            {"Contract Template.docx", "Document", "3.2 MB", "2024-01-12"},
            {"Invoice #12345.pdf", "Document", "1.1 MB", "2024-01-11"}
        };
        
        for (String[] file : files) {
            LinearLayout fileItem = createFileItemCard(file[0], file[1], file[2], file[3]);
            filesLayout.addView(fileItem);
        }
        
        return filesLayout;
    }
    
    private LinearLayout createFileItemCard(final String name, String type, String size, String date) {
        LinearLayout cardLayout = new LinearLayout(this);
        cardLayout.setOrientation(LinearLayout.HORIZONTAL);
        cardLayout.setBackgroundColor(0xFFFFFFFF);
        cardLayout.setPadding(16, 16, 16, 16);
        
        // File Icon
        TextView iconText = new TextView(this);
        if (type.equals("Document")) {
            iconText.setText("📄");
        } else if (type.equals("Spreadsheet")) {
            iconText.setText("📊");
        } else {
            iconText.setText("📁");
        }
        iconText.setTextSize(20);
        iconText.setPadding(0, 0, 12, 0);
        
        // File Info
        LinearLayout infoLayout = new LinearLayout(this);
        infoLayout.setOrientation(LinearLayout.VERTICAL);
        
        TextView nameText = new TextView(this);
        nameText.setText(name);
        nameText.setTextSize(16);
        nameText.setTypeface(null, android.graphics.Typeface.BOLD);
        nameText.setTextColor(0xFF1976D2);
        
        TextView detailsText = new TextView(this);
        detailsText.setText(type + " • " + size);
        detailsText.setTextSize(14);
        detailsText.setTextColor(0xFF666666);
        
        TextView dateText = new TextView(this);
        dateText.setText("Modified: " + date);
        dateText.setTextSize(12);
        dateText.setTextColor(0xFF666666);
        
        infoLayout.addView(nameText);
        infoLayout.addView(detailsText);
        infoLayout.addView(dateText);
        
        // More Options Button - RIGHT-CLICK ONLY MENU
        TextView moreButton = new TextView(this);
        moreButton.setText("⋯");
        moreButton.setTextSize(20);
        moreButton.setTextColor(0xFF666666);
        moreButton.setPadding(16, 16, 16, 16);
        
        // Register for context menu - RIGHT-CLICK ONLY
        registerForContextMenu(cardLayout);
        
        cardLayout.addView(iconText);
        
        LinearLayout.LayoutParams infoParams = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        cardLayout.addView(infoLayout, infoParams);
        
        cardLayout.addView(moreButton);
        
        return cardLayout;
    }
    
    private LinearLayout createFooter() {
        LinearLayout footerLayout = new LinearLayout(this);
        footerLayout.setOrientation(LinearLayout.VERTICAL);
        footerLayout.setBackgroundColor(0xFFE3F2FD);
        footerLayout.setPadding(16, 16, 16, 16);
        
        TextView instructionsTitle = new TextView(this);
        instructionsTitle.setText("Instructions");
        instructionsTitle.setTextSize(16);
        instructionsTitle.setTypeface(null, android.graphics.Typeface.BOLD);
        instructionsTitle.setTextColor(0xFF1976D2);
        instructionsTitle.setPadding(0, 0, 0, 8);
        
        TextView instructionsText = new TextView(this);
        instructionsText.setText("Right-click on files for additional options");
        instructionsText.setTextSize(14);
        instructionsText.setTextColor(0xFF1976D2);
        
        TextView warningText = new TextView(this);
        warningText.setText("⚠️ Some functions are only available via right-click menu");
        warningText.setTextSize(12);
        warningText.setTextColor(0xFFFF9800);
        warningText.setPadding(0, 4, 0, 0);
        
        footerLayout.addView(instructionsTitle);
        footerLayout.addView(instructionsText);
        footerLayout.addView(warningText);
        
        return footerLayout;
    }
    
    @Override
    public void onCreateContextMenu(ContextMenu menu, View v, ContextMenu.ContextMenuInfo menuInfo) {
        super.onCreateContextMenu(menu, v, menuInfo);
        
        // Essential functions only available via right-click
        menu.setHeaderTitle("File Options");
        menu.add(0, 1, 0, "Delete");
        menu.add(0, 2, 0, "Rename");
        menu.add(0, 3, 0, "Move to Trash");
        menu.add(0, 4, 0, "Properties");
        menu.add(0, 5, 0, "Copy Path");
    }
    
    @Override
    public boolean onContextItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case 1:
                showDeleteDialog();
                return true;
            case 2:
                showRenameDialog();
                return true;
            case 3:
                showMoveToTrashDialog();
                return true;
            case 4:
                showPropertiesDialog();
                return true;
            case 5:
                showCopyPathDialog();
                return true;
            default:
                return super.onContextItemSelected(item);
        }
    }
    
    private void showDeleteDialog() {
        new AlertDialog.Builder(this)
                .setTitle("Delete File")
                .setMessage("Are you sure you want to permanently delete this file?")
                .setPositiveButton("Delete", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        // Delete file logic
                    }
                })
                .setNegativeButton("Cancel", null)
                .show();
    }
    
    private void showRenameDialog() {
        new AlertDialog.Builder(this)
                .setTitle("Rename File")
                .setMessage("Enter new file name:")
                .setPositiveButton("Rename", null)
                .setNegativeButton("Cancel", null)
                .show();
    }
    
    private void showMoveToTrashDialog() {
        new AlertDialog.Builder(this)
                .setTitle("Move to Trash")
                .setMessage("Move this file to trash?")
                .setPositiveButton("Move to Trash", null)
                .setNegativeButton("Cancel", null)
                .show();
    }
    
    private void showPropertiesDialog() {
        new AlertDialog.Builder(this)
                .setTitle("File Properties")
                .setMessage("File details and properties will be displayed here.")
                .setPositiveButton("OK", null)
                .show();
    }
    
    private void showCopyPathDialog() {
        new AlertDialog.Builder(this)
                .setTitle("Path Copied")
                .setMessage("File path copied to clipboard")
                .setPositiveButton("OK", null)
                .show();
    }
}
