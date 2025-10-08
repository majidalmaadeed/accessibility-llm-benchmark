package com.example.UIComponents;

import android.app.AlertDialog;
import android.content.Context;
import android.graphics.Color;
import android.graphics.Typeface;
import android.os.Bundle;
import android.text.Editable;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.Spanned;
import android.text.TextWatcher;
import android.text.style.BackgroundColorSpan;
import android.text.style.ForegroundColorSpan;
import android.text.style.StyleSpan;
import android.text.style.UnderlineSpan;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.*;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import java.util.ArrayList;
import java.util.List;

public class RichTextEditor extends AppCompatActivity {
    
    private EditText textEditor;
    private HorizontalScrollView toolbarScrollView;
    private LinearLayout toolbarLayout;
    private TextView wordCountLabel;
    private Button undoButton;
    private Button redoButton;
    private Button boldButton;
    private Button italicButton;
    private Button underlineButton;
    private Button fontSizeButton;
    private Button textColorButton;
    private Button backgroundColorButton;
    private Button leftAlignButton;
    private Button centerAlignButton;
    private Button rightAlignButton;
    private Button insertButton;
    private Button statsButton;
    
    private boolean isBold = false;
    private boolean isItalic = false;
    private boolean isUnderline = false;
    private int fontSize = 16;
    private int textColor = Color.BLACK;
    private int backgroundColor = Color.WHITE;
    private int alignment = 0; // 0=left, 1=center, 2=right
    private boolean showWordCount = false;
    private boolean isUndoAvailable = false;
    private boolean isRedoAvailable = false;
    
    private List<String> history = new ArrayList<>();
    private int historyIndex = 0;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_rich_text_editor);
        
        initializeViews();
        setupToolbar();
        setupTextEditor();
        updateHistory();
    }
    
    private void initializeViews() {
        textEditor = findViewById(R.id.textEditor);
        toolbarScrollView = findViewById(R.id.toolbarScrollView);
        toolbarLayout = findViewById(R.id.toolbarLayout);
        wordCountLabel = findViewById(R.id.wordCountLabel);
        
        // Toolbar buttons
        undoButton = findViewById(R.id.undoButton);
        redoButton = findViewById(R.id.redoButton);
        boldButton = findViewById(R.id.boldButton);
        italicButton = findViewById(R.id.italicButton);
        underlineButton = findViewById(R.id.underlineButton);
        fontSizeButton = findViewById(R.id.fontSizeButton);
        textColorButton = findViewById(R.id.textColorButton);
        backgroundColorButton = findViewById(R.id.backgroundColorButton);
        leftAlignButton = findViewById(R.id.leftAlignButton);
        centerAlignButton = findViewById(R.id.centerAlignButton);
        rightAlignButton = findViewById(R.id.rightAlignButton);
        insertButton = findViewById(R.id.insertButton);
        statsButton = findViewById(R.id.statsButton);
    }
    
    private void setupToolbar() {
        // Undo/Redo
        undoButton.setOnClickListener(v -> undo());
        redoButton.setOnClickListener(v -> redo());
        
        // Formatting
        boldButton.setOnClickListener(v -> toggleBold());
        italicButton.setOnClickListener(v -> toggleItalic());
        underlineButton.setOnClickListener(v -> toggleUnderline());
        
        // Font and colors
        fontSizeButton.setOnClickListener(v -> showFontSizePicker());
        textColorButton.setOnClickListener(v -> showTextColorPicker());
        backgroundColorButton.setOnClickListener(v -> showBackgroundColorPicker());
        
        // Alignment
        leftAlignButton.setOnClickListener(v -> setAlignment(0));
        centerAlignButton.setOnClickListener(v -> setAlignment(1));
        rightAlignButton.setOnClickListener(v -> setAlignment(2));
        
        // Insert and stats
        insertButton.setOnClickListener(v -> showInsertMenu());
        statsButton.setOnClickListener(v -> toggleWordCount());
        
        updateButtonStates();
    }
    
    private void setupTextEditor() {
        textEditor.setTextSize(fontSize);
        textEditor.setTextColor(textColor);
        textEditor.setBackgroundColor(backgroundColor);
        
        textEditor.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {}
            
            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                updateWordCount();
            }
            
            @Override
            public void afterTextChanged(Editable s) {
                updateHistory();
            }
        });
    }
    
    private void updateHistory() {
        String content = textEditor.getText().toString();
        
        // Remove any future history if we're not at the end
        if (historyIndex < history.size() - 1) {
            history = history.subList(0, historyIndex + 1);
        }
        
        history.add(content);
        historyIndex = history.size() - 1;
        
        isUndoAvailable = historyIndex > 0;
        isRedoAvailable = historyIndex < history.size() - 1;
        
        updateButtonStates();
    }
    
    private void updateButtonStates() {
        undoButton.setEnabled(isUndoAvailable);
        undoButton.setAlpha(isUndoAvailable ? 1.0f : 0.5f);
        
        redoButton.setEnabled(isRedoAvailable);
        redoButton.setAlpha(isRedoAvailable ? 1.0f : 0.5f);
        
        // Formatting buttons
        boldButton.setBackgroundColor(isBold ? Color.parseColor("#E3F2FD") : Color.TRANSPARENT);
        italicButton.setBackgroundColor(isItalic ? Color.parseColor("#E3F2FD") : Color.TRANSPARENT);
        underlineButton.setBackgroundColor(isUnderline ? Color.parseColor("#E3F2FD") : Color.TRANSPARENT);
        
        // Alignment buttons
        leftAlignButton.setBackgroundColor(alignment == 0 ? Color.parseColor("#E3F2FD") : Color.TRANSPARENT);
        centerAlignButton.setBackgroundColor(alignment == 1 ? Color.parseColor("#E3F2FD") : Color.TRANSPARENT);
        rightAlignButton.setBackgroundColor(alignment == 2 ? Color.parseColor("#E3F2FD") : Color.TRANSPARENT);
        
        // Font size and colors
        fontSizeButton.setText(fontSize + "pt");
        textColorButton.setBackgroundColor(textColor);
        backgroundColorButton.setBackgroundColor(backgroundColor);
        
        updateWordCount();
    }
    
    private void updateWordCount() {
        String content = textEditor.getText().toString();
        String[] words = content.trim().split("\\s+");
        int wordCount = words.length == 1 && words[0].isEmpty() ? 0 : words.length;
        int charCount = content.length();
        
        wordCountLabel.setText("Words: " + wordCount + " | Characters: " + charCount);
        wordCountLabel.setVisibility(showWordCount ? View.VISIBLE : View.GONE);
    }
    
    private void undo() {
        if (historyIndex > 0) {
            historyIndex--;
            textEditor.setText(history.get(historyIndex));
            isUndoAvailable = historyIndex > 0;
            isRedoAvailable = true;
            updateButtonStates();
        }
    }
    
    private void redo() {
        if (historyIndex < history.size() - 1) {
            historyIndex++;
            textEditor.setText(history.get(historyIndex));
            isUndoAvailable = true;
            isRedoAvailable = historyIndex < history.size() - 1;
            updateButtonStates();
        }
    }
    
    private void toggleBold() {
        isBold = !isBold;
        applyFormatting();
        updateButtonStates();
    }
    
    private void toggleItalic() {
        isItalic = !isItalic;
        applyFormatting();
        updateButtonStates();
    }
    
    private void toggleUnderline() {
        isUnderline = !isUnderline;
        applyFormatting();
        updateButtonStates();
    }
    
    private void applyFormatting() {
        String content = textEditor.getText().toString();
        SpannableString spannable = new SpannableString(content);
        
        // Apply formatting to entire text
        int start = 0;
        int end = content.length();
        
        if (isBold) {
            spannable.setSpan(new StyleSpan(Typeface.BOLD), start, end, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
        }
        if (isItalic) {
            spannable.setSpan(new StyleSpan(Typeface.ITALIC), start, end, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
        }
        if (isUnderline) {
            spannable.setSpan(new UnderlineSpan(), start, end, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
        }
        
        spannable.setSpan(new ForegroundColorSpan(textColor), start, end, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
        spannable.setSpan(new BackgroundColorSpan(backgroundColor), start, end, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
        
        textEditor.setText(spannable);
    }
    
    private void setAlignment(int align) {
        alignment = align;
        switch (align) {
            case 0: // Left
                textEditor.setGravity(android.view.Gravity.START);
                break;
            case 1: // Center
                textEditor.setGravity(android.view.Gravity.CENTER);
                break;
            case 2: // Right
                textEditor.setGravity(android.view.Gravity.END);
                break;
        }
        updateButtonStates();
    }
    
    private void showFontSizePicker() {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle("Font Size");
        
        List<Integer> fontSizes = new ArrayList<>();
        for (int i = 12; i <= 48; i += 2) {
            fontSizes.add(i);
        }
        
        String[] sizeStrings = new String[fontSizes.size()];
        for (int i = 0; i < fontSizes.size(); i++) {
            sizeStrings[i] = fontSizes.get(i) + "pt";
        }
        
        builder.setItems(sizeStrings, (dialog, which) -> {
            fontSize = fontSizes.get(which);
            textEditor.setTextSize(fontSize);
            updateButtonStates();
        });
        
        builder.setNegativeButton("Cancel", null);
        builder.show();
    }
    
    private void showTextColorPicker() {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle("Text Color");
        
        String[] colors = {"Black", "Gray", "Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"};
        int[] colorValues = {Color.BLACK, Color.GRAY, Color.RED, Color.parseColor("#FF9800"), Color.YELLOW, 
                           Color.GREEN, Color.BLUE, Color.parseColor("#9C27B0"), Color.parseColor("#E91E63")};
        
        builder.setItems(colors, (dialog, which) -> {
            textColor = colorValues[which];
            textEditor.setTextColor(textColor);
            updateButtonStates();
        });
        
        builder.setNegativeButton("Cancel", null);
        builder.show();
    }
    
    private void showBackgroundColorPicker() {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle("Background Color");
        
        String[] colors = {"White", "Light Gray", "Light Blue", "Light Green", "Light Yellow", "Light Pink"};
        int[] colorValues = {Color.WHITE, Color.parseColor("#F5F5F5"), Color.parseColor("#E3F2FD"), 
                           Color.parseColor("#E8F5E8"), Color.parseColor("#FFFDE7"), Color.parseColor("#FCE4EC")};
        
        builder.setItems(colors, (dialog, which) -> {
            backgroundColor = colorValues[which];
            textEditor.setBackgroundColor(backgroundColor);
            updateButtonStates();
        });
        
        builder.setNegativeButton("Cancel", null);
        builder.show();
    }
    
    private void showInsertMenu() {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle("Insert");
        
        String[] items = {"Image", "Link", "Table", "List"};
        
        builder.setItems(items, (dialog, which) -> {
            String content = textEditor.getText().toString();
            String insertText = "";
            
            switch (which) {
                case 0: // Image
                    insertText = "\n[Image placeholder]\n";
                    break;
                case 1: // Link
                    insertText = "\n[Link placeholder]\n";
                    break;
                case 2: // Table
                    insertText = "\n[Table placeholder]\n";
                    break;
                case 3: // List
                    insertText = "\n• List item\n";
                    break;
            }
            
            textEditor.setText(content + insertText);
            textEditor.setSelection(textEditor.getText().length());
        });
        
        builder.setNegativeButton("Cancel", null);
        builder.show();
    }
    
    private void toggleWordCount() {
        showWordCount = !showWordCount;
        wordCountLabel.setVisibility(showWordCount ? View.VISIBLE : View.GONE);
    }
}
