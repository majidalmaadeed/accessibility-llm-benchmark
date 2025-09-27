package com.example.accessibilitybenchmark;

import android.app.AlertDialog;
import android.content.Context;
import android.graphics.Color;
import android.graphics.Typeface;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import java.util.ArrayList;
import java.util.List;

public class SocialMediaFeed extends AppCompatActivity {
    
    private RecyclerView postsRecyclerView;
    private Spinner filterSpinner;
    private ProgressBar loadingIndicator;
    private TextView emptyStateText;
    private Button createPostButton;
    private ImageButton notificationsButton;
    private ImageButton trendingButton;
    
    private List<Post> posts = new ArrayList<>();
    private List<Post> allPosts = new ArrayList<>();
    private String currentFilter = "all";
    private int unreadNotifications = 3;
    private boolean isLoading = false;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_social_media_feed);
        
        initializeViews();
        setupFilterSpinner();
        loadSamplePosts();
    }
    
    private void initializeViews() {
        postsRecyclerView = findViewById(R.id.postsRecyclerView);
        filterSpinner = findViewById(R.id.filterSpinner);
        loadingIndicator = findViewById(R.id.loadingIndicator);
        emptyStateText = findViewById(R.id.emptyStateText);
        createPostButton = findViewById(R.id.createPostButton);
        notificationsButton = findViewById(R.id.notificationsButton);
        trendingButton = findViewById(R.id.trendingButton);
        
        // Setup RecyclerView
        postsRecyclerView.setLayoutManager(new LinearLayoutManager(this));
        
        // Setup click listeners
        createPostButton.setOnClickListener(v -> showCreatePostDialog());
        notificationsButton.setOnClickListener(v -> showNotifications());
        trendingButton.setOnClickListener(v -> showTrending());
        
        // Setup notification badge
        updateNotificationBadge();
    }
    
    private void setupFilterSpinner() {
        String[] filters = {"All", "Following", "Trending"};
        ArrayAdapter<String> adapter = new ArrayAdapter<>(this, android.R.layout.simple_spinner_item, filters);
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        filterSpinner.setAdapter(adapter);
        
        filterSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                currentFilter = filters[position].toLowerCase();
                filterPosts();
            }
            
            @Override
            public void onNothingSelected(AdapterView<?> parent) {}
        });
    }
    
    private void loadSamplePosts() {
        allPosts.add(new Post(
            "1",
            new User("user1", "John Doe", "@johndoe", "👨‍💻", true),
            "Just finished building an amazing React Native app! The development process was challenging but incredibly rewarding. #ReactNative #MobileDev #Tech",
            "📱",
            "San Francisco, CA",
            "2h ago",
            42,
            8,
            3,
            false,
            false,
            "public"
        ));
        
        allPosts.add(new Post(
            "2",
            new User("user2", "Sarah Wilson", "@sarahw", "👩‍🎨", false),
            "Beautiful sunset from my office window today. Sometimes you need to stop and appreciate the little moments. 🌅",
            "🌅",
            "New York, NY",
            "4h ago",
            28,
            5,
            1,
            true,
            false,
            "public"
        ));
        
        allPosts.add(new Post(
            "3",
            new User("user3", "Mike Chen", "@mikechen", "👨‍💼", true),
            "Excited to announce our new product launch! After months of hard work, we're finally ready to share it with the world. #Startup #Innovation",
            "🚀",
            "Austin, TX",
            "6h ago",
            156,
            23,
            12,
            false,
            true,
            "public"
        ));
        
        allPosts.add(new Post(
            "4",
            new User("user4", "Emma Davis", "@emmad", "👩‍🔬", false),
            "Just read an amazing article about the future of AI in healthcare. The possibilities are endless! What are your thoughts on this?",
            "🤖",
            "Boston, MA",
            "8h ago",
            73,
            15,
            7,
            true,
            false,
            "public"
        ));
        
        allPosts.add(new Post(
            "5",
            new User("user5", "Alex Rodriguez", "@alexr", "👨‍🎓", false),
            "Coffee and code - the perfect combination for a productive day! ☕️💻",
            "☕️",
            "Seattle, WA",
            "10h ago",
            34,
            6,
            2,
            false,
            false,
            "public"
        ));
        
        posts = new ArrayList<>(allPosts);
        updatePostsDisplay();
    }
    
    private void filterPosts() {
        // In a real implementation, this would filter posts based on the selected filter
        posts = new ArrayList<>(allPosts);
        updatePostsDisplay();
    }
    
    private void updatePostsDisplay() {
        if (posts.isEmpty()) {
            postsRecyclerView.setVisibility(View.GONE);
            emptyStateText.setVisibility(View.VISIBLE);
        } else {
            postsRecyclerView.setVisibility(View.VISIBLE);
            emptyStateText.setVisibility(View.GONE);
            
            PostAdapter adapter = new PostAdapter(posts, this::onPostClick, this::onLikeClick, 
                                               this::onCommentClick, this::onShareClick, this::onBookmarkClick);
            postsRecyclerView.setAdapter(adapter);
        }
    }
    
    private void onPostClick(Post post) {
        showPostDetails(post);
    }
    
    private void onLikeClick(String postId) {
        for (Post post : posts) {
            if (post.getId().equals(postId)) {
                post.setLiked(!post.isLiked());
                post.setLikes(post.isLiked() ? post.getLikes() + 1 : post.getLikes() - 1);
                break;
            }
        }
        updatePostsDisplay();
    }
    
    private void onCommentClick(Post post) {
        showPostDetails(post);
    }
    
    private void onShareClick(Post post) {
        Toast.makeText(this, "Sharing: " + post.getTitle(), Toast.LENGTH_SHORT).show();
    }
    
    private void onBookmarkClick(String postId) {
        for (Post post : posts) {
            if (post.getId().equals(postId)) {
                post.setBookmarked(!post.isBookmarked());
                break;
            }
        }
        updatePostsDisplay();
    }
    
    private void showPostDetails(Post post) {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle(post.getUser().getName());
        
        StringBuilder message = new StringBuilder();
        message.append(post.getContent()).append("\n\n");
        message.append("Time: ").append(post.getTimestamp()).append("\n");
        if (!post.getLocation().isEmpty()) {
            message.append("Location: ").append(post.getLocation()).append("\n");
        }
        message.append("Likes: ").append(post.getLikes()).append("\n");
        message.append("Comments: ").append(post.getComments()).append("\n");
        message.append("Shares: ").append(post.getShares());
        
        builder.setMessage(message.toString());
        builder.setPositiveButton("Close", null);
        builder.show();
    }
    
    private void showCreatePostDialog() {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle("Create Post");
        
        View dialogView = LayoutInflater.from(this).inflate(R.layout.dialog_create_post, null);
        
        EditText contentEditText = dialogView.findViewById(R.id.contentEditText);
        EditText locationEditText = dialogView.findViewById(R.id.locationEditText);
        Spinner privacySpinner = dialogView.findViewById(R.id.privacySpinner);
        CheckBox allDayCheckBox = dialogView.findViewById(R.id.allDayCheckBox);
        
        // Setup privacy spinner
        String[] privacyOptions = {"public", "friends", "private"};
        ArrayAdapter<String> privacyAdapter = new ArrayAdapter<>(this, android.R.layout.simple_spinner_item, privacyOptions);
        privacyAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        privacySpinner.setAdapter(privacyAdapter);
        
        builder.setView(dialogView);
        builder.setPositiveButton("Post", (dialog, which) -> {
            String content = contentEditText.getText().toString();
            if (TextUtils.isEmpty(content.trim())) return;
            
            Post newPost = new Post(
                String.valueOf(System.currentTimeMillis()),
                new User("current-user", "You", "@you", "👤", false),
                content,
                "",
                locationEditText.getText().toString(),
                "now",
                0,
                0,
                0,
                false,
                false,
                privacyOptions[privacySpinner.getSelectedItemPosition()]
            );
            
            posts.add(0, newPost);
            allPosts.add(0, newPost);
            updatePostsDisplay();
        });
        builder.setNegativeButton("Cancel", null);
        builder.show();
    }
    
    private void showNotifications() {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle("Notifications");
        builder.setMessage("You have " + unreadNotifications + " unread notifications");
        builder.setPositiveButton("OK", null);
        builder.show();
    }
    
    private void showTrending() {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle("Trending");
        builder.setMessage("Top trending topics:\n#ReactNative\n#MobileDev\n#Tech\n#Startup\n#Innovation");
        builder.setPositiveButton("OK", null);
        builder.show();
    }
    
    private void updateNotificationBadge() {
        if (unreadNotifications > 0) {
            notificationsButton.setBackgroundColor(Color.RED);
            notificationsButton.setColorFilter(Color.WHITE);
        } else {
            notificationsButton.setBackgroundColor(Color.TRANSPARENT);
            notificationsButton.setColorFilter(Color.BLACK);
        }
    }
    
    // Post Adapter
    private static class PostAdapter extends RecyclerView.Adapter<PostAdapter.ViewHolder> {
        private List<Post> posts;
        private OnPostClickListener onPostClickListener;
        private OnLikeClickListener onLikeClickListener;
        private OnCommentClickListener onCommentClickListener;
        private OnShareClickListener onShareClickListener;
        private OnBookmarkClickListener onBookmarkClickListener;
        
        public interface OnPostClickListener {
            void onPostClick(Post post);
        }
        
        public interface OnLikeClickListener {
            void onLikeClick(String postId);
        }
        
        public interface OnCommentClickListener {
            void onCommentClick(Post post);
        }
        
        public interface OnShareClickListener {
            void onShareClick(Post post);
        }
        
        public interface OnBookmarkClickListener {
            void onBookmarkClick(String postId);
        }
        
        public PostAdapter(List<Post> posts, OnPostClickListener onPostClickListener, 
                          OnLikeClickListener onLikeClickListener, OnCommentClickListener onCommentClickListener,
                          OnShareClickListener onShareClickListener, OnBookmarkClickListener onBookmarkClickListener) {
            this.posts = posts;
            this.onPostClickListener = onPostClickListener;
            this.onLikeClickListener = onLikeClickListener;
            this.onCommentClickListener = onCommentClickListener;
            this.onShareClickListener = onShareClickListener;
            this.onBookmarkClickListener = onBookmarkClickListener;
        }
        
        @Override
        public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_post, parent, false);
            return new ViewHolder(view);
        }
        
        @Override
        public void onBindViewHolder(ViewHolder holder, int position) {
            Post post = posts.get(position);
            holder.bind(post, onPostClickListener, onLikeClickListener, onCommentClickListener, 
                       onShareClickListener, onBookmarkClickListener);
        }
        
        @Override
        public int getItemCount() {
            return posts.size();
        }
        
        static class ViewHolder extends RecyclerView.ViewHolder {
            private TextView userAvatar;
            private TextView userName;
            private TextView userUsername;
            private TextView verifiedIcon;
            private TextView timestamp;
            private TextView contentText;
            private TextView imageText;
            private TextView locationText;
            private Button likeButton;
            private Button commentButton;
            private Button shareButton;
            private Button bookmarkButton;
            
            public ViewHolder(View itemView) {
                super(itemView);
                userAvatar = itemView.findViewById(R.id.userAvatar);
                userName = itemView.findViewById(R.id.userName);
                userUsername = itemView.findViewById(R.id.userUsername);
                verifiedIcon = itemView.findViewById(R.id.verifiedIcon);
                timestamp = itemView.findViewById(R.id.timestamp);
                contentText = itemView.findViewById(R.id.contentText);
                imageText = itemView.findViewById(R.id.imageText);
                locationText = itemView.findViewById(R.id.locationText);
                likeButton = itemView.findViewById(R.id.likeButton);
                commentButton = itemView.findViewById(R.id.commentButton);
                shareButton = itemView.findViewById(R.id.shareButton);
                bookmarkButton = itemView.findViewById(R.id.bookmarkButton);
            }
            
            public void bind(Post post, OnPostClickListener onPostClickListener, 
                           OnLikeClickListener onLikeClickListener, OnCommentClickListener onCommentClickListener,
                           OnShareClickListener onShareClickListener, OnBookmarkClickListener onBookmarkClickListener) {
                // User info
                userAvatar.setText(post.getUser().getAvatar());
                userName.setText(post.getUser().getName());
                userUsername.setText(post.getUser().getUsername());
                verifiedIcon.setText(post.getUser().isVerified() ? "✓" : "");
                verifiedIcon.setVisibility(post.getUser().isVerified() ? View.VISIBLE : View.GONE);
                timestamp.setText(post.getTimestamp());
                
                // Content
                contentText.setText(post.getContent());
                imageText.setText(post.getImage().isEmpty() ? "" : post.getImage());
                imageText.setVisibility(post.getImage().isEmpty() ? View.GONE : View.VISIBLE);
                locationText.setText(post.getLocation().isEmpty() ? "" : "📍 " + post.getLocation());
                locationText.setVisibility(post.getLocation().isEmpty() ? View.GONE : View.VISIBLE);
                
                // Actions
                likeButton.setText("❤️ " + post.getLikes());
                likeButton.setTextColor(post.isLiked() ? Color.RED : Color.GRAY);
                commentButton.setText("💬 " + post.getComments());
                shareButton.setText("🔄 " + post.getShares());
                bookmarkButton.setText(post.isBookmarked() ? "🔖" : "📌");
                bookmarkButton.setTextColor(post.isBookmarked() ? Color.BLUE : Color.GRAY);
                
                // Click listeners
                itemView.setOnClickListener(v -> onPostClickListener.onPostClick(post));
                likeButton.setOnClickListener(v -> onLikeClickListener.onLikeClick(post.getId()));
                commentButton.setOnClickListener(v -> onCommentClickListener.onCommentClick(post));
                shareButton.setOnClickListener(v -> onShareClickListener.onShareClick(post));
                bookmarkButton.setOnClickListener(v -> onBookmarkClickListener.onBookmarkClick(post.getId()));
            }
        }
    }
    
    // Data classes
    public static class User {
        private String id;
        private String name;
        private String username;
        private String avatar;
        private boolean verified;
        
        public User(String id, String name, String username, String avatar, boolean verified) {
            this.id = id;
            this.name = name;
            this.username = username;
            this.avatar = avatar;
            this.verified = verified;
        }
        
        // Getters
        public String getId() { return id; }
        public String getName() { return name; }
        public String getUsername() { return username; }
        public String getAvatar() { return avatar; }
        public boolean isVerified() { return verified; }
    }
    
    public static class Post {
        private String id;
        private User user;
        private String content;
        private String image;
        private String location;
        private String timestamp;
        private int likes;
        private int comments;
        private int shares;
        private boolean isLiked;
        private boolean isBookmarked;
        private String privacy;
        
        public Post(String id, User user, String content, String image, String location, 
                   String timestamp, int likes, int comments, int shares, boolean isLiked, 
                   boolean isBookmarked, String privacy) {
            this.id = id;
            this.user = user;
            this.content = content;
            this.image = image;
            this.location = location;
            this.timestamp = timestamp;
            this.likes = likes;
            this.comments = comments;
            this.shares = shares;
            this.isLiked = isLiked;
            this.isBookmarked = isBookmarked;
            this.privacy = privacy;
        }
        
        // Getters and setters
        public String getId() { return id; }
        public User getUser() { return user; }
        public String getContent() { return content; }
        public String getImage() { return image; }
        public String getLocation() { return location; }
        public String getTimestamp() { return timestamp; }
        public int getLikes() { return likes; }
        public int getComments() { return comments; }
        public int getShares() { return shares; }
        public boolean isLiked() { return isLiked; }
        public boolean isBookmarked() { return isBookmarked; }
        public String getPrivacy() { return privacy; }
        public String getTitle() { return content.length() > 50 ? content.substring(0, 50) + "..." : content; }
        
        public void setLiked(boolean liked) { this.isLiked = liked; }
        public void setBookmarked(boolean bookmarked) { this.isBookmarked = bookmarked; }
        public void setLikes(int likes) { this.likes = likes; }
    }
}
