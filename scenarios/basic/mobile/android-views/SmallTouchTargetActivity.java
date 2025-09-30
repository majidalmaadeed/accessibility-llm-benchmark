package com.example.accessibilityscenarios;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

public class SmallTouchTargetActivity extends Activity {
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        // Create main layout
        ScrollView scrollView = new ScrollView(this);
        LinearLayout mainLayout = new LinearLayout(this);
        mainLayout.setOrientation(LinearLayout.VERTICAL);
        mainLayout.setPadding(16, 16, 16, 16);
        mainLayout.setBackgroundColor(0xFFF5F5F5);
        
        // Header
        LinearLayout headerLayout = createHeader();
        mainLayout.addView(headerLayout);
        
        // Posts List
        LinearLayout postsLayout = createPostsList();
        mainLayout.addView(postsLayout);
        
        scrollView.addView(mainLayout);
        setContentView(scrollView);
    }
    
    private LinearLayout createHeader() {
        LinearLayout headerLayout = new LinearLayout(this);
        headerLayout.setOrientation(LinearLayout.HORIZONTAL);
        headerLayout.setBackgroundColor(0xFF1976D2);
        headerLayout.setPadding(16, 16, 16, 16);
        
        TextView titleText = new TextView(this);
        titleText.setText("Social Feed");
        titleText.setTextSize(24);
        titleText.setTextColor(0xFFFFFFFF);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        
        // Notifications button - SMALL TOUCH TARGET
        ImageButton notificationButton = new ImageButton(this);
        notificationButton.setImageResource(android.R.drawable.ic_dialog_info);
        notificationButton.setBackgroundColor(android.graphics.Color.TRANSPARENT);
        notificationButton.setContentDescription("Notifications");
        notificationButton.setPadding(8, 8, 8, 8);
        notificationButton.setMinimumWidth(20); // TOO SMALL: Only 20dp touch target
        notificationButton.setMinimumHeight(20); // TOO SMALL: Only 20dp touch target
        
        LinearLayout.LayoutParams titleParams = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        headerLayout.addView(titleText, titleParams);
        
        LinearLayout.LayoutParams buttonParams = new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.WRAP_CONTENT, 
            LinearLayout.LayoutParams.WRAP_CONTENT);
        headerLayout.addView(notificationButton, buttonParams);
        
        return headerLayout;
    }
    
    private LinearLayout createPostsList() {
        LinearLayout postsLayout = new LinearLayout(this);
        postsLayout.setOrientation(LinearLayout.VERTICAL);
        postsLayout.setBackgroundColor(0xFFFFFFFF);
        postsLayout.setPadding(16, 16, 16, 16);
        
        String[][] posts = {
            {"john_doe", "Just finished an amazing hike! The views were incredible.", "2 hours ago", "24", "8", "3"},
            {"sarah_wilson", "Working on a new project. Can't wait to share it with everyone!", "4 hours ago", "156", "23", "12"},
            {"mike_chen", "Coffee break time! ☕", "6 hours ago", "89", "15", "5"},
            {"emma_taylor", "Beautiful sunset from my balcony tonight.", "8 hours ago", "203", "31", "18"}
        };
        
        for (String[] post : posts) {
            LinearLayout postItem = createPostCard(post[0], post[1], post[2], post[3], post[4], post[5]);
            postsLayout.addView(postItem);
        }
        
        return postsLayout;
    }
    
    private LinearLayout createPostCard(String username, String content, String timestamp, 
                                     String likes, String comments, String shares) {
        LinearLayout cardLayout = new LinearLayout(this);
        cardLayout.setOrientation(LinearLayout.VERTICAL);
        cardLayout.setBackgroundColor(0xFFFFFFFF);
        cardLayout.setPadding(16, 16, 16, 16);
        
        // User Info
        LinearLayout userLayout = new LinearLayout(this);
        userLayout.setOrientation(LinearLayout.HORIZONTAL);
        userLayout.setPadding(0, 0, 0, 12);
        
        // Profile Picture
        LinearLayout profilePic = new LinearLayout(this);
        profilePic.setBackgroundColor(0xFFE0E0E0);
        profilePic.setMinimumWidth(40);
        profilePic.setMinimumHeight(40);
        profilePic.setGravity(android.view.Gravity.CENTER);
        
        TextView profileIcon = new TextView(this);
        profileIcon.setText("👤");
        profileIcon.setTextSize(20);
        profilePic.addView(profileIcon);
        
        LinearLayout userInfo = new LinearLayout(this);
        userInfo.setOrientation(LinearLayout.VERTICAL);
        userInfo.setPadding(12, 0, 0, 0);
        
        TextView usernameText = new TextView(this);
        usernameText.setText(username);
        usernameText.setTextSize(16);
        usernameText.setTypeface(null, android.graphics.Typeface.BOLD);
        
        TextView timestampText = new TextView(this);
        timestampText.setText(timestamp);
        timestampText.setTextSize(14);
        timestampText.setTextColor(0xFF666666);
        
        userInfo.addView(usernameText);
        userInfo.addView(timestampText);
        
        // More options button - SMALL TOUCH TARGET
        ImageButton moreButton = new ImageButton(this);
        moreButton.setImageResource(android.R.drawable.ic_menu_more);
        moreButton.setBackgroundColor(android.graphics.Color.TRANSPARENT);
        moreButton.setContentDescription("More options");
        moreButton.setPadding(4, 4, 4, 4);
        moreButton.setMinimumWidth(20); // TOO SMALL: Only 20dp touch target
        moreButton.setMinimumHeight(20); // TOO SMALL: Only 20dp touch target
        
        userLayout.addView(profilePic);
        userLayout.addView(userInfo);
        userLayout.addView(moreButton);
        
        // Post Content
        TextView contentText = new TextView(this);
        contentText.setText(content);
        contentText.setTextSize(16);
        contentText.setPadding(0, 0, 0, 16);
        
        // Action Buttons - SMALL TOUCH TARGETS
        LinearLayout actionsLayout = new LinearLayout(this);
        actionsLayout.setOrientation(LinearLayout.HORIZONTAL);
        
        // Like Button - SMALL TOUCH TARGET
        LinearLayout likeLayout = new LinearLayout(this);
        likeLayout.setOrientation(LinearLayout.HORIZONTAL);
        likeLayout.setPadding(0, 0, 16, 0);
        
        ImageButton likeButton = new ImageButton(this);
        likeButton.setImageResource(android.R.drawable.btn_star_big_on);
        likeButton.setBackgroundColor(android.graphics.Color.TRANSPARENT);
        likeButton.setContentDescription("Like");
        likeButton.setPadding(4, 4, 4, 4);
        likeButton.setMinimumWidth(24); // TOO SMALL: Only 24dp touch target
        likeButton.setMinimumHeight(24); // TOO SMALL: Only 24dp touch target
        
        TextView likesText = new TextView(this);
        likesText.setText(likes);
        likesText.setTextSize(14);
        likesText.setTextColor(0xFF666666);
        likesText.setPadding(4, 0, 0, 0);
        
        likeLayout.addView(likeButton);
        likeLayout.addView(likesText);
        
        // Comment Button - SMALL TOUCH TARGET
        LinearLayout commentLayout = new LinearLayout(this);
        commentLayout.setOrientation(LinearLayout.HORIZONTAL);
        commentLayout.setPadding(0, 0, 16, 0);
        
        ImageButton commentButton = new ImageButton(this);
        commentButton.setImageResource(android.R.drawable.ic_menu_edit);
        commentButton.setBackgroundColor(android.graphics.Color.TRANSPARENT);
        commentButton.setContentDescription("Comment");
        commentButton.setPadding(4, 4, 4, 4);
        commentButton.setMinimumWidth(24); // TOO SMALL: Only 24dp touch target
        commentButton.setMinimumHeight(24); // TOO SMALL: Only 24dp touch target
        
        TextView commentsText = new TextView(this);
        commentsText.setText(comments);
        commentsText.setTextSize(14);
        commentsText.setTextColor(0xFF666666);
        commentsText.setPadding(4, 0, 0, 0);
        
        commentLayout.addView(commentButton);
        commentLayout.addView(commentsText);
        
        // Share Button - SMALL TOUCH TARGET
        LinearLayout shareLayout = new LinearLayout(this);
        shareLayout.setOrientation(LinearLayout.HORIZONTAL);
        
        ImageButton shareButton = new ImageButton(this);
        shareButton.setImageResource(android.R.drawable.ic_menu_share);
        shareButton.setBackgroundColor(android.graphics.Color.TRANSPARENT);
        shareButton.setContentDescription("Share");
        shareButton.setPadding(4, 4, 4, 4);
        shareButton.setMinimumWidth(24); // TOO SMALL: Only 24dp touch target
        shareButton.setMinimumHeight(24); // TOO SMALL: Only 24dp touch target
        
        TextView sharesText = new TextView(this);
        sharesText.setText(shares);
        sharesText.setTextSize(14);
        sharesText.setTextColor(0xFF666666);
        sharesText.setPadding(4, 0, 0, 0);
        
        shareLayout.addView(shareButton);
        shareLayout.addView(sharesText);
        
        actionsLayout.addView(likeLayout);
        actionsLayout.addView(commentLayout);
        actionsLayout.addView(shareLayout);
        
        cardLayout.addView(userLayout);
        cardLayout.addView(contentText);
        cardLayout.addView(actionsLayout);
        
        return cardLayout;
    }
}
