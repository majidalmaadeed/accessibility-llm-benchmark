package com.example.uicomponents;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

public class GenericLinkTextActivity extends Activity {
    
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
        
        TextView titleText = new TextView(this);
        titleText.setText("Tech Blog");
        titleText.setTextSize(24);
        titleText.setTextColor(0xFFFFFFFF);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        
        TextView subtitleText = new TextView(this);
        subtitleText.setText("Latest insights and trends");
        subtitleText.setTextSize(16);
        subtitleText.setTextColor(0xE6FFFFFF);
        
        headerLayout.addView(titleText);
        headerLayout.addView(subtitleText);
        
        return headerLayout;
    }
    
    private LinearLayout createArticlesList() {
        LinearLayout articlesLayout = new LinearLayout(this);
        articlesLayout.setOrientation(LinearLayout.VERTICAL);
        articlesLayout.setBackgroundColor(0xFFFFFFFF);
        articlesLayout.setPadding(16, 16, 16, 16);
        
        String[][] articles = {
            {"Understanding Machine Learning", "Machine learning is revolutionizing the way we approach data analysis and decision making. This comprehensive guide covers the fundamentals...", "Technology", "5 min read", "Dr. Sarah Johnson"},
            {"The Future of Renewable Energy", "As climate change becomes an increasingly pressing issue, renewable energy sources are gaining momentum. Solar and wind power...", "Environment", "7 min read", "Mike Chen"},
            {"Digital Marketing Trends 2024", "The digital marketing landscape is constantly evolving. From AI-powered personalization to voice search optimization...", "Marketing", "4 min read", "Emily Davis"},
            {"Cybersecurity Best Practices", "With cyber threats on the rise, organizations must implement robust security measures. Learn about the latest strategies...", "Security", "6 min read", "David Wilson"}
        };
        
        for (String[] article : articles) {
            LinearLayout articleItem = createArticleCard(article[0], article[1], article[2], article[3], article[4]);
            articlesLayout.addView(articleItem);
        }
        
        return articlesLayout;
    }
    
    private LinearLayout createArticleCard(String title, String excerpt, String category, String readTime, String author) {
        LinearLayout cardLayout = new LinearLayout(this);
        cardLayout.setOrientation(LinearLayout.VERTICAL);
        cardLayout.setBackgroundColor(0xFFFFFFFF);
        cardLayout.setPadding(16, 16, 16, 16);
        
        // Category and Read Time
        LinearLayout metaLayout = new LinearLayout(this);
        metaLayout.setOrientation(LinearLayout.HORIZONTAL);
        metaLayout.setPadding(0, 0, 0, 8);
        
        TextView categoryText = new TextView(this);
        categoryText.setText(category);
        categoryText.setTextSize(12);
        categoryText.setTextColor(0xFF1976D2);
        categoryText.setBackgroundColor(0x1A1976D2);
        categoryText.setPadding(8, 4, 8, 4);
        
        TextView readTimeText = new TextView(this);
        readTimeText.setText(readTime);
        readTimeText.setTextSize(12);
        readTimeText.setTextColor(0xFF666666);
        readTimeText.setPadding(16, 0, 0, 0);
        
        metaLayout.addView(categoryText);
        metaLayout.addView(readTimeText);
        
        // Article Title
        TextView titleText = new TextView(this);
        titleText.setText(title);
        titleText.setTextSize(18);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        titleText.setPadding(0, 0, 0, 8);
        
        // Article Excerpt
        TextView excerptText = new TextView(this);
        excerptText.setText(excerpt);
        excerptText.setTextSize(14);
        excerptText.setTextColor(0xFF666666);
        excerptText.setPadding(0, 0, 0, 12);
        
        // Author and Actions
        LinearLayout footerLayout = new LinearLayout(this);
        footerLayout.setOrientation(LinearLayout.HORIZONTAL);
        
        TextView authorText = new TextView(this);
        authorText.setText("By " + author);
        authorText.setTextSize(12);
        authorText.setTextColor(0xFF666666);
        
        LinearLayout buttonLayout = new LinearLayout(this);
        buttonLayout.setOrientation(LinearLayout.HORIZONTAL);
        buttonLayout.setPadding(16, 0, 0, 0);
        
        // Generic link text - MISSING CONTEXT
        Button readMoreButton = new Button(this);
        readMoreButton.setText("Read more"); // GENERIC: No context about destination
        readMoreButton.setBackgroundColor(0xFF1976D2);
        readMoreButton.setTextColor(0xFFFFFFFF);
        readMoreButton.setPadding(16, 8, 16, 8);
        
        // Another generic link
        Button shareButton = new Button(this);
        shareButton.setText("Click here"); // GENERIC: No context about destination
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
