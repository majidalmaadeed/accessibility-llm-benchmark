package com.example.accessibilityscenarios;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

public class MissingLanguageAttributeActivity extends Activity {
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        // Create main layout
        ScrollView scrollView = new ScrollView(this);
        LinearLayout mainLayout = new LinearLayout(this);
        mainLayout.setOrientation(LinearLayout.VERTICAL);
        mainLayout.setPadding(32, 32, 32, 32);
        mainLayout.setBackgroundColor(0xFFF5F5F5);
        
        // Header - Mixed languages without proper language attributes
        LinearLayout headerLayout = createHeader();
        mainLayout.addView(headerLayout);
        
        // Language Toggle - Missing proper language attributes
        LinearLayout languageLayout = createLanguageToggle();
        mainLayout.addView(languageLayout);
        
        // Articles List
        LinearLayout articlesLayout = createArticlesList();
        mainLayout.addView(articlesLayout);
        
        scrollView.addView(mainLayout);
        setContentView(scrollView);
    }
    
    private LinearLayout createHeader() {
        LinearLayout headerLayout = new LinearLayout(this);
        headerLayout.setOrientation(LinearLayout.VERTICAL);
        headerLayout.setBackgroundColor(0xFF1976D2);
        headerLayout.setPadding(32, 32, 32, 32);
        
        // MISSING: No language attribute for mixed content
        TextView titleText = new TextView(this);
        titleText.setText("News Portal / Portail d'actualités");
        titleText.setTextSize(24);
        titleText.setTextColor(0xFFFFFFFF);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        
        // MISSING: No language attribute for mixed content
        TextView subtitleText = new TextView(this);
        subtitleText.setText("Latest News / Dernières nouvelles");
        subtitleText.setTextSize(16);
        subtitleText.setTextColor(0xE6FFFFFF);
        
        headerLayout.addView(titleText);
        headerLayout.addView(subtitleText);
        
        return headerLayout;
    }
    
    private LinearLayout createLanguageToggle() {
        LinearLayout languageLayout = new LinearLayout(this);
        languageLayout.setOrientation(LinearLayout.HORIZONTAL);
        languageLayout.setBackgroundColor(0xFFFFFFFF);
        languageLayout.setPadding(16, 16, 16, 16);
        
        // MISSING: No language attribute for language selection
        TextView languageLabel = new TextView(this);
        languageLabel.setText("Language / Langue:");
        languageLabel.setTextSize(16);
        languageLabel.setTypeface(null, android.graphics.Typeface.BOLD);
        languageLabel.setPadding(0, 0, 16, 0);
        
        Button englishButton = new Button(this);
        englishButton.setText("English");
        englishButton.setBackgroundColor(0xFF1976D2);
        englishButton.setTextColor(0xFFFFFFFF);
        englishButton.setPadding(16, 16, 16, 16);
        
        Button frenchButton = new Button(this);
        frenchButton.setText("Français");
        frenchButton.setBackgroundColor(0xFFFFFFFF);
        frenchButton.setTextColor(0xFF1976D2);
        frenchButton.setPadding(16, 16, 16, 16);
        
        LinearLayout.LayoutParams labelParams = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        languageLayout.addView(languageLabel, labelParams);
        
        LinearLayout.LayoutParams buttonParams = new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.WRAP_CONTENT, 
            LinearLayout.LayoutParams.WRAP_CONTENT);
        buttonParams.setMargins(8, 0, 0, 0);
        languageLayout.addView(englishButton, buttonParams);
        languageLayout.addView(frenchButton, buttonParams);
        
        return languageLayout;
    }
    
    private LinearLayout createArticlesList() {
        LinearLayout articlesLayout = new LinearLayout(this);
        articlesLayout.setOrientation(LinearLayout.VERTICAL);
        articlesLayout.setBackgroundColor(0xFFFFFFFF);
        articlesLayout.setPadding(16, 16, 16, 16);
        
        String[][] articles = {
            {"Understanding Machine Learning", "Machine learning is revolutionizing the way we approach data analysis and decision making. This comprehensive guide covers the fundamentals...", "Technology", "5 min read", "Dr. Sarah Johnson", "en"},
            {"Bienvenue sur notre portail d'actualités", "Restez informé des dernières nouvelles et événements du monde entier.", "Général", "7 min read", "Mike Chen", "fr"},
            {"Breaking News: Technology Update", "New developments in artificial intelligence are changing the industry.", "Technology", "4 min read", "Emily Davis", "en"},
            {"Actualités: Mise à jour technologique", "Les nouveaux développements en intelligence artificielle transforment l'industrie.", "Technologie", "6 min read", "David Wilson", "fr"}
        };
        
        for (String[] article : articles) {
            LinearLayout articleItem = createArticleCard(article[0], article[1], article[2], article[3], article[4], article[5]);
            articlesLayout.addView(articleItem);
        }
        
        return articlesLayout;
    }
    
    private LinearLayout createArticleCard(String title, String excerpt, String category, 
                                        String readTime, String author, String language) {
        LinearLayout cardLayout = new LinearLayout(this);
        cardLayout.setOrientation(LinearLayout.VERTICAL);
        cardLayout.setBackgroundColor(0xFFFFFFFF);
        cardLayout.setPadding(16, 16, 16, 16);
        
        // Category and Language - Mixed content without language attributes
        LinearLayout metaLayout = new LinearLayout(this);
        metaLayout.setOrientation(LinearLayout.HORIZONTAL);
        metaLayout.setPadding(0, 0, 0, 8);
        
        // MISSING: No language attribute for category
        TextView categoryText = new TextView(this);
        categoryText.setText(category);
        categoryText.setTextSize(12);
        categoryText.setTextColor(0xFF1976D2);
        categoryText.setBackgroundColor(0x1A1976D2);
        categoryText.setPadding(8, 4, 8, 4);
        
        // MISSING: No language attribute for language indicator
        TextView languageText = new TextView(this);
        languageText.setText(language.equals("en") ? "English" : "Français");
        languageText.setTextSize(12);
        languageText.setTextColor(0xFF666666);
        languageText.setPadding(16, 0, 0, 0);
        
        metaLayout.addView(categoryText);
        metaLayout.addView(languageText);
        
        // Article Title - Missing language attribute
        TextView titleText = new TextView(this);
        titleText.setText(title);
        titleText.setTextSize(18);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        titleText.setPadding(0, 0, 0, 8);
        
        // Article Content - Missing language attribute
        TextView excerptText = new TextView(this);
        excerptText.setText(excerpt);
        excerptText.setTextSize(14);
        excerptText.setTextColor(0xFF666666);
        excerptText.setPadding(0, 0, 0, 12);
        
        // Author and Actions - Mixed language labels
        LinearLayout footerLayout = new LinearLayout(this);
        footerLayout.setOrientation(LinearLayout.HORIZONTAL);
        
        TextView authorText = new TextView(this);
        authorText.setText("By " + author);
        authorText.setTextSize(12);
        authorText.setTextColor(0xFF666666);
        
        LinearLayout buttonLayout = new LinearLayout(this);
        buttonLayout.setOrientation(LinearLayout.HORIZONTAL);
        buttonLayout.setPadding(16, 0, 0, 0);
        
        // MISSING: No language attribute for button text
        Button readMoreButton = new Button(this);
        readMoreButton.setText(language.equals("en") ? "Read More" : "Lire la suite");
        readMoreButton.setBackgroundColor(0xFF1976D2);
        readMoreButton.setTextColor(0xFFFFFFFF);
        readMoreButton.setPadding(16, 8, 16, 8);
        
        // MISSING: No language attribute for button text
        Button shareButton = new Button(this);
        shareButton.setText(language.equals("en") ? "Share" : "Partager");
        shareButton.setBackgroundColor(0xFFFFFFFF);
        shareButton.setTextColor(0xFF1976D2);
        shareButton.setPadding(16, 8, 16, 8);
        
        LinearLayout.LayoutParams authorParams = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        footerLayout.addView(authorText, authorParams);
        
        LinearLayout.LayoutParams readMoreParams = new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.WRAP_CONTENT, 
            LinearLayout.LayoutParams.WRAP_CONTENT);
        readMoreParams.setMargins(0, 0, 8, 0);
        buttonLayout.addView(readMoreButton, readMoreParams);
        
        LinearLayout.LayoutParams shareParams = new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.WRAP_CONTENT, 
            LinearLayout.LayoutParams.WRAP_CONTENT);
        buttonLayout.addView(shareButton, shareParams);
        
        footerLayout.addView(buttonLayout);
        
        cardLayout.addView(metaLayout);
        cardLayout.addView(titleText);
        cardLayout.addView(excerptText);
        cardLayout.addView(footerLayout);
        
        return cardLayout;
    }
}
