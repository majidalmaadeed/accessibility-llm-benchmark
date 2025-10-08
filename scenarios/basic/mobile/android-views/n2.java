package com.example.uicomponents;

import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

public class AutoPlayingBackgroundVideoActivity extends Activity {
    
    private boolean isVideoPlaying = true;
    private int videoTime = 0;
    private Handler handler = new Handler();
    private Runnable videoRunnable;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        // Create main layout with video background
        LinearLayout mainLayout = new LinearLayout(this);
        mainLayout.setOrientation(LinearLayout.VERTICAL);
        mainLayout.setBackgroundColor(0xFF1A1A1A); // Dark video background
        
        // Background Video - AUTOPLAYING WITHOUT USER CONTROL
        LinearLayout videoBackground = createVideoBackground();
        
        // Main Content
        ScrollView scrollView = new ScrollView(this);
        LinearLayout contentLayout = new LinearLayout(this);
        contentLayout.setOrientation(LinearLayout.VERTICAL);
        contentLayout.setPadding(32, 32, 32, 32);
        
        // Header
        LinearLayout headerLayout = createHeader();
        contentLayout.addView(headerLayout);
        
        // Features Section
        LinearLayout featuresLayout = createFeatures();
        contentLayout.addView(featuresLayout);
        
        scrollView.addView(contentLayout);
        
        // Video Controls - Hidden by default, no way to stop autoplay
        LinearLayout controlsLayout = createVideoControls();
        
        mainLayout.addView(videoBackground);
        mainLayout.addView(scrollView);
        mainLayout.addView(controlsLayout);
        
        setContentView(mainLayout);
        
        // Start video simulation
        startVideoPlayback();
    }
    
    private void startVideoPlayback() {
        videoRunnable = new Runnable() {
            @Override
            public void run() {
                if (isVideoPlaying) {
                    videoTime++;
                    handler.postDelayed(this, 1000);
                }
            }
        };
        handler.post(videoRunnable);
    }
    
    private LinearLayout createVideoBackground() {
        LinearLayout videoLayout = new LinearLayout(this);
        videoLayout.setOrientation(LinearLayout.VERTICAL);
        videoLayout.setBackgroundColor(0xFF2D2D2D);
        videoLayout.setGravity(android.view.Gravity.CENTER);
        videoLayout.setMinimumHeight(200);
        
        TextView videoIndicator = new TextView(this);
        videoIndicator.setText("▶ Background Video Playing");
        videoIndicator.setTextColor(0xB3FFFFFF);
        videoIndicator.setTextSize(16);
        
        TextView timeIndicator = new TextView(this);
        timeIndicator.setText("Time: 0s");
        timeIndicator.setTextColor(0x80FFFFFF);
        timeIndicator.setTextSize(12);
        
        videoLayout.addView(videoIndicator);
        videoLayout.addView(timeIndicator);
        
        return videoLayout;
    }
    
    private LinearLayout createHeader() {
        LinearLayout headerLayout = new LinearLayout(this);
        headerLayout.setOrientation(LinearLayout.VERTICAL);
        headerLayout.setBackgroundColor(0xF5FFFFFF); // Semi-transparent white
        headerLayout.setPadding(32, 32, 32, 32);
        
        TextView titleText = new TextView(this);
        titleText.setText("Welcome to Our Platform");
        titleText.setTextSize(28);
        titleText.setTextColor(0xFF1976D2);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        
        TextView subtitleText = new TextView(this);
        subtitleText.setText("Experience the future of business management");
        subtitleText.setTextSize(18);
        subtitleText.setTextColor(0xFF666666);
        
        headerLayout.addView(titleText);
        headerLayout.addView(subtitleText);
        
        return headerLayout;
    }
    
    private LinearLayout createFeatures() {
        LinearLayout featuresLayout = new LinearLayout(this);
        featuresLayout.setOrientation(LinearLayout.VERTICAL);
        featuresLayout.setBackgroundColor(0xF5FFFFFF); // Semi-transparent white
        featuresLayout.setPadding(32, 32, 32, 32);
        
        TextView featuresTitle = new TextView(this);
        featuresTitle.setText("Key Features");
        featuresTitle.setTextSize(24);
        featuresTitle.setTypeface(null, android.graphics.Typeface.BOLD);
        featuresTitle.setTextColor(0xFF1976D2);
        featuresTitle.setPadding(0, 0, 0, 16);
        
        featuresLayout.addView(featuresTitle);
        
        String[][] features = {
            {"Advanced Analytics", "Get detailed insights into your business performance with our comprehensive analytics dashboard."},
            {"Real-time Collaboration", "Work together with your team in real-time using our collaborative tools and features."},
            {"Secure Cloud Storage", "Store your data securely in the cloud with enterprise-grade encryption and backup."},
            {"Mobile Optimization", "Access your data and tools from anywhere with our mobile-optimized interface."}
        };
        
        for (String[] feature : features) {
            LinearLayout featureItem = createFeatureItem(feature[0], feature[1]);
            featuresLayout.addView(featureItem);
        }
        
        return featuresLayout;
    }
    
    private LinearLayout createFeatureItem(String title, String description) {
        LinearLayout featureLayout = new LinearLayout(this);
        featureLayout.setOrientation(LinearLayout.HORIZONTAL);
        featureLayout.setPadding(0, 8, 0, 8);
        
        TextView iconText = new TextView(this);
        iconText.setText("✓");
        iconText.setTextSize(24);
        iconText.setTextColor(0xFF1976D2);
        iconText.setPadding(0, 0, 16, 0);
        
        LinearLayout textLayout = new LinearLayout(this);
        textLayout.setOrientation(LinearLayout.VERTICAL);
        
        TextView titleText = new TextView(this);
        titleText.setText(title);
        titleText.setTextSize(18);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        titleText.setTextColor(0xFF1976D2);
        
        TextView descText = new TextView(this);
        descText.setText(description);
        descText.setTextSize(14);
        descText.setTextColor(0xFF666666);
        
        textLayout.addView(titleText);
        textLayout.addView(descText);
        
        featureLayout.addView(iconText);
        featureLayout.addView(textLayout);
        
        return featureLayout;
    }
    
    private LinearLayout createVideoControls() {
        LinearLayout controlsLayout = new LinearLayout(this);
        controlsLayout.setOrientation(LinearLayout.HORIZONTAL);
        controlsLayout.setBackgroundColor(0xB3000000);
        controlsLayout.setPadding(16, 16, 16, 16);
        controlsLayout.setGravity(android.view.Gravity.END);
        
        ImageButton playPauseButton = new ImageButton(this);
        playPauseButton.setImageResource(isVideoPlaying ? 
            android.R.drawable.ic_media_pause : 
            android.R.drawable.ic_media_play);
        playPauseButton.setBackgroundColor(android.graphics.Color.TRANSPARENT);
        playPauseButton.setContentDescription(isVideoPlaying ? "Pause video" : "Play video");
        playPauseButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                isVideoPlaying = !isVideoPlaying;
                playPauseButton.setImageResource(isVideoPlaying ? 
                    android.R.drawable.ic_media_pause : 
                    android.R.drawable.ic_media_play);
                playPauseButton.setContentDescription(isVideoPlaying ? "Pause video" : "Play video");
            }
        });
        
        TextView controlText = new TextView(this);
        controlText.setText(isVideoPlaying ? "Pause" : "Play");
        controlText.setTextColor(0xFFFFFFFF);
        controlText.setTextSize(12);
        controlText.setPadding(8, 0, 0, 0);
        
        controlsLayout.addView(playPauseButton);
        controlsLayout.addView(controlText);
        
        return controlsLayout;
    }
    
    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (videoRunnable != null) {
            handler.removeCallbacks(videoRunnable);
        }
    }
}
