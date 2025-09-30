package com.example.accessibilityscenarios;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.VideoView;

public class UnlabeledMediaButtonActivity extends Activity {
    
    private VideoView videoView;
    private ImageButton playButton;
    private boolean isPlaying = false;
    
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
        
        // Video Player Section
        LinearLayout videoLayout = createVideoPlayer();
        mainLayout.addView(videoLayout);
        
        // Video Info
        LinearLayout infoLayout = createVideoInfo();
        mainLayout.addView(infoLayout);
        
        // Video List
        LinearLayout listLayout = createVideoList();
        mainLayout.addView(listLayout);
        
        scrollView.addView(mainLayout);
        setContentView(scrollView);
    }
    
    private LinearLayout createHeader() {
        LinearLayout headerLayout = new LinearLayout(this);
        headerLayout.setOrientation(LinearLayout.VERTICAL);
        headerLayout.setBackgroundColor(0xFF2196F3);
        headerLayout.setPadding(32, 32, 32, 32);
        
        TextView titleText = new TextView(this);
        titleText.setText("Video Player");
        titleText.setTextSize(24);
        titleText.setTextColor(0xFFFFFFFF);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        
        TextView subtitleText = new TextView(this);
        subtitleText.setText("Watch your favorite videos");
        subtitleText.setTextSize(16);
        subtitleText.setTextColor(0xE6FFFFFF);
        
        headerLayout.addView(titleText);
        headerLayout.addView(subtitleText);
        
        return headerLayout;
    }
    
    private LinearLayout createVideoPlayer() {
        LinearLayout videoLayout = new LinearLayout(this);
        videoLayout.setOrientation(LinearLayout.VERTICAL);
        videoLayout.setBackgroundColor(0xFFFFFFFF);
        videoLayout.setPadding(16, 16, 16, 16);
        
        // Video placeholder
        LinearLayout videoContainer = new LinearLayout(this);
        videoContainer.setBackgroundColor(0xFF333333);
        videoContainer.setMinimumHeight(200);
        videoContainer.setGravity(android.view.Gravity.CENTER);
        
        TextView videoPlaceholder = new TextView(this);
        videoPlaceholder.setText("Video Preview");
        videoPlaceholder.setTextColor(0xFFFFFFFF);
        videoPlaceholder.setTextSize(18);
        videoContainer.addView(videoPlaceholder);
        
        // Play/Pause button - MISSING ACCESSIBLE NAME
        playButton = new ImageButton(this);
        playButton.setImageResource(android.R.drawable.ic_media_play);
        playButton.setBackgroundColor(0xB3000000);
        playButton.setPadding(16, 16, 16, 16);
        playButton.setContentDescription(null); // MISSING: No accessible name
        playButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                isPlaying = !isPlaying;
                playButton.setImageResource(isPlaying ? 
                    android.R.drawable.ic_media_pause : 
                    android.R.drawable.ic_media_play);
            }
        });
        
        videoContainer.addView(playButton);
        videoLayout.addView(videoContainer);
        
        return videoLayout;
    }
    
    private LinearLayout createVideoInfo() {
        LinearLayout infoLayout = new LinearLayout(this);
        infoLayout.setOrientation(LinearLayout.VERTICAL);
        infoLayout.setBackgroundColor(0xFFFFFFFF);
        infoLayout.setPadding(16, 16, 16, 16);
        
        TextView titleText = new TextView(this);
        titleText.setText("Sample Video 1");
        titleText.setTextSize(18);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        
        TextView durationText = new TextView(this);
        durationText.setText("Duration: 3:45");
        durationText.setTextSize(14);
        durationText.setTextColor(0xFF666666);
        
        TextView qualityText = new TextView(this);
        qualityText.setText("Quality: 1080p");
        qualityText.setTextSize(14);
        qualityText.setTextColor(0xFF666666);
        
        infoLayout.addView(titleText);
        infoLayout.addView(durationText);
        infoLayout.addView(qualityText);
        
        return infoLayout;
    }
    
    private LinearLayout createVideoList() {
        LinearLayout listLayout = new LinearLayout(this);
        listLayout.setOrientation(LinearLayout.VERTICAL);
        listLayout.setBackgroundColor(0xFFFFFFFF);
        listLayout.setPadding(16, 16, 16, 16);
        
        TextView listTitle = new TextView(this);
        listTitle.setText("More Videos");
        listTitle.setTextSize(18);
        listTitle.setTypeface(null, android.graphics.Typeface.BOLD);
        listTitle.setPadding(0, 0, 0, 16);
        
        listLayout.addView(listTitle);
        
        String[] videos = {"Sample Video 1", "Sample Video 2", "Sample Video 3", "Sample Video 4"};
        
        for (String video : videos) {
            LinearLayout videoItem = createVideoListItem(video);
            listLayout.addView(videoItem);
        }
        
        return listLayout;
    }
    
    private LinearLayout createVideoListItem(String videoName) {
        LinearLayout itemLayout = new LinearLayout(this);
        itemLayout.setOrientation(LinearLayout.HORIZONTAL);
        itemLayout.setPadding(16, 16, 16, 16);
        itemLayout.setBackgroundColor(0xFFF8F9FA);
        itemLayout.setPadding(16, 16, 16, 16);
        
        // Video thumbnail placeholder
        LinearLayout thumbnail = new LinearLayout(this);
        thumbnail.setBackgroundColor(0xFFE0E0E0);
        thumbnail.setMinimumWidth(80);
        thumbnail.setMinimumHeight(60);
        thumbnail.setGravity(android.view.Gravity.CENTER);
        
        ImageButton playIcon = new ImageButton(this);
        playIcon.setImageResource(android.R.drawable.ic_media_play);
        playIcon.setBackgroundColor(android.graphics.Color.TRANSPARENT);
        playIcon.setContentDescription(null);
        thumbnail.addView(playIcon);
        
        LinearLayout textLayout = new LinearLayout(this);
        textLayout.setOrientation(LinearLayout.VERTICAL);
        textLayout.setPadding(16, 0, 0, 0);
        
        TextView nameText = new TextView(this);
        nameText.setText(videoName);
        nameText.setTextSize(16);
        nameText.setTypeface(null, android.graphics.Typeface.BOLD);
        
        TextView detailsText = new TextView(this);
        detailsText.setText("3:45 • 1080p");
        detailsText.setTextSize(14);
        detailsText.setTextColor(0xFF666666);
        
        textLayout.addView(nameText);
        textLayout.addView(detailsText);
        
        itemLayout.addView(thumbnail);
        itemLayout.addView(textLayout);
        
        return itemLayout;
    }
}
