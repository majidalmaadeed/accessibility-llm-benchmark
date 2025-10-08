using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;

namespace UIComponents
{
    public partial class SocialMediaFeed : Window
    {
        private List<Post> posts;
        private List<Post> allPosts;
        private string currentFilter = "All";
        private int unreadNotifications = 3;
        
        public SocialMediaFeed()
        {
            InitializeComponent();
            posts = new List<Post>();
            allPosts = new List<Post>();
            LoadSamplePosts();
            UpdatePostsDisplay();
            UpdateNotificationBadge();
        }
        
        private void LoadSamplePosts()
        {
            allPosts.Add(new Post
            {
                Id = "1",
                User = new User("user1", "John Doe", "@johndoe", "👨‍💻", true),
                Content = "Just finished building an amazing React Native app! The development process was challenging but incredibly rewarding. #ReactNative #MobileDev #Tech",
                Image = "📱",
                Location = "San Francisco, CA",
                Timestamp = "2h ago",
                Likes = 42,
                Comments = 8,
                Shares = 3,
                IsLiked = false,
                IsBookmarked = false,
                Privacy = "public"
            });
            
            allPosts.Add(new Post
            {
                Id = "2",
                User = new User("user2", "Sarah Wilson", "@sarahw", "👩‍🎨", false),
                Content = "Beautiful sunset from my office window today. Sometimes you need to stop and appreciate the little moments. 🌅",
                Image = "🌅",
                Location = "New York, NY",
                Timestamp = "4h ago",
                Likes = 28,
                Comments = 5,
                Shares = 1,
                IsLiked = true,
                IsBookmarked = false,
                Privacy = "public"
            });
            
            allPosts.Add(new Post
            {
                Id = "3",
                User = new User("user3", "Mike Chen", "@mikechen", "👨‍💼", true),
                Content = "Excited to announce our new product launch! After months of hard work, we're finally ready to share it with the world. #Startup #Innovation",
                Image = "🚀",
                Location = "Austin, TX",
                Timestamp = "6h ago",
                Likes = 156,
                Comments = 23,
                Shares = 12,
                IsLiked = false,
                IsBookmarked = true,
                Privacy = "public"
            });
            
            allPosts.Add(new Post
            {
                Id = "4",
                User = new User("user4", "Emma Davis", "@emmad", "👩‍🔬", false),
                Content = "Just read an amazing article about the future of AI in healthcare. The possibilities are endless! What are your thoughts on this?",
                Image = "🤖",
                Location = "Boston, MA",
                Timestamp = "8h ago",
                Likes = 73,
                Comments = 15,
                Shares = 7,
                IsLiked = true,
                IsBookmarked = false,
                Privacy = "public"
            });
            
            allPosts.Add(new Post
            {
                Id = "5",
                User = new User("user5", "Alex Rodriguez", "@alexr", "👨‍🎓", false),
                Content = "Coffee and code - the perfect combination for a productive day! ☕️💻",
                Image = "☕️",
                Location = "Seattle, WA",
                Timestamp = "10h ago",
                Likes = 34,
                Comments = 6,
                Shares = 2,
                IsLiked = false,
                IsBookmarked = false,
                Privacy = "public"
            });
            
            posts = new List<Post>(allPosts);
        }
        
        private void UpdatePostsDisplay()
        {
            PostsPanel.Children.Clear();
            
            foreach (var post in posts)
            {
                var postControl = CreatePostControl(post);
                PostsPanel.Children.Add(postControl);
            }
            
            PostCountText.Text = $"{posts.Count} posts";
        }
        
        private Border CreatePostControl(Post post)
        {
            var border = new Border
            {
                Background = Brushes.White,
                Margin = new Thickness(0, 0, 0, 15),
                Padding = new Thickness(15),
                CornerRadius = new CornerRadius(5),
                BorderBrush = Brushes.LightGray,
                BorderThickness = new Thickness(1)
            };
            
            var grid = new Grid();
            grid.RowDefinitions.Add(new RowDefinition { Height = GridLength.Auto });
            grid.RowDefinitions.Add(new RowDefinition { Height = GridLength.Auto });
            grid.RowDefinitions.Add(new RowDefinition { Height = GridLength.Auto });
            grid.RowDefinitions.Add(new RowDefinition { Height = GridLength.Auto });
            
            // Header with user info
            var headerGrid = new Grid();
            headerGrid.ColumnDefinitions.Add(new ColumnDefinition { Width = GridLength.Auto });
            headerGrid.ColumnDefinitions.Add(new ColumnDefinition { Width = new GridLength(1, GridUnitType.Star) });
            headerGrid.ColumnDefinitions.Add(new ColumnDefinition { Width = GridLength.Auto });
            
            var avatar = new TextBlock
            {
                Text = post.User.Avatar,
                FontSize = 24,
                VerticalAlignment = VerticalAlignment.Center,
                Margin = new Thickness(0, 0, 15, 0)
            };
            Grid.SetColumn(avatar, 0);
            headerGrid.Children.Add(avatar);
            
            var userInfoStack = new StackPanel();
            var nameText = new TextBlock
            {
                Text = post.User.Name,
                FontWeight = FontWeights.Bold,
                FontSize = 14
            };
            var usernameText = new TextBlock
            {
                Text = post.User.Username,
                FontSize = 12,
                Foreground = Brushes.Gray
            };
            var verifiedIcon = new TextBlock
            {
                Text = post.User.Verified ? "✓" : "",
                FontSize = 12,
                Foreground = Brushes.Blue,
                VerticalAlignment = VerticalAlignment.Center
            };
            
            var nameRow = new StackPanel { Orientation = Orientation.Horizontal };
            nameRow.Children.Add(nameText);
            nameRow.Children.Add(verifiedIcon);
            
            userInfoStack.Children.Add(nameRow);
            userInfoStack.Children.Add(usernameText);
            
            Grid.SetColumn(userInfoStack, 1);
            headerGrid.Children.Add(userInfoStack);
            
            var timestampText = new TextBlock
            {
                Text = post.Timestamp,
                FontSize = 12,
                Foreground = Brushes.Gray,
                VerticalAlignment = VerticalAlignment.Center
            };
            Grid.SetColumn(timestampText, 2);
            headerGrid.Children.Add(timestampText);
            
            Grid.SetRow(headerGrid, 0);
            grid.Children.Add(headerGrid);
            
            // Content
            var contentText = new TextBlock
            {
                Text = post.Content,
                FontSize = 14,
                TextWrapping = TextWrapping.Wrap,
                Margin = new Thickness(0, 10, 0, 10)
            };
            Grid.SetRow(contentText, 1);
            grid.Children.Add(contentText);
            
            // Image (if present)
            if (!string.IsNullOrEmpty(post.Image))
            {
                var imageText = new TextBlock
                {
                    Text = post.Image,
                    FontSize = 48,
                    HorizontalAlignment = HorizontalAlignment.Center,
                    Margin = new Thickness(0, 0, 0, 10)
                };
                Grid.SetRow(imageText, 2);
                grid.Children.Add(imageText);
            }
            
            // Location
            if (!string.IsNullOrEmpty(post.Location))
            {
                var locationText = new TextBlock
                {
                    Text = $"📍 {post.Location}",
                    FontSize = 12,
                    Foreground = Brushes.Gray,
                    Margin = new Thickness(0, 0, 0, 10)
                };
                Grid.SetRow(locationText, 2);
                grid.Children.Add(locationText);
            }
            
            // Actions
            var actionsGrid = new Grid();
            actionsGrid.ColumnDefinitions.Add(new ColumnDefinition { Width = new GridLength(1, GridUnitType.Star) });
            actionsGrid.ColumnDefinitions.Add(new ColumnDefinition { Width = new GridLength(1, GridUnitType.Star) });
            actionsGrid.ColumnDefinitions.Add(new ColumnDefinition { Width = new GridLength(1, GridUnitType.Star) });
            actionsGrid.ColumnDefinitions.Add(new ColumnDefinition { Width = new GridLength(1, GridUnitType.Star) });
            
            var likeButton = new Button
            {
                Content = $"❤️ {post.Likes}",
                Background = post.IsLiked ? Brushes.LightPink : Brushes.Transparent,
                Foreground = post.IsLiked ? Brushes.Red : Brushes.Gray,
                BorderThickness = new Thickness(0),
                FontSize = 12,
                Tag = post.Id
            };
            likeButton.Click += LikeButton_Click;
            Grid.SetColumn(likeButton, 0);
            actionsGrid.Children.Add(likeButton);
            
            var commentButton = new Button
            {
                Content = $"💬 {post.Comments}",
                Background = Brushes.Transparent,
                Foreground = Brushes.Gray,
                BorderThickness = new Thickness(0),
                FontSize = 12,
                Tag = post
            };
            commentButton.Click += CommentButton_Click;
            Grid.SetColumn(commentButton, 1);
            actionsGrid.Children.Add(commentButton);
            
            var shareButton = new Button
            {
                Content = $"🔄 {post.Shares}",
                Background = Brushes.Transparent,
                Foreground = Brushes.Gray,
                BorderThickness = new Thickness(0),
                FontSize = 12,
                Tag = post
            };
            shareButton.Click += ShareButton_Click;
            Grid.SetColumn(shareButton, 2);
            actionsGrid.Children.Add(shareButton);
            
            var bookmarkButton = new Button
            {
                Content = post.IsBookmarked ? "🔖" : "📌",
                Background = Brushes.Transparent,
                Foreground = post.IsBookmarked ? Brushes.Blue : Brushes.Gray,
                BorderThickness = new Thickness(0),
                FontSize = 12,
                Tag = post.Id
            };
            bookmarkButton.Click += BookmarkButton_Click;
            Grid.SetColumn(bookmarkButton, 3);
            actionsGrid.Children.Add(bookmarkButton);
            
            Grid.SetRow(actionsGrid, 3);
            grid.Children.Add(actionsGrid);
            
            border.Child = grid;
            return border;
        }
        
        private void LikeButton_Click(object sender, RoutedEventArgs e)
        {
            if (sender is Button button && button.Tag is string postId)
            {
                var post = posts.FirstOrDefault(p => p.Id == postId);
                if (post != null)
                {
                    post.IsLiked = !post.IsLiked;
                    post.Likes += post.IsLiked ? 1 : -1;
                    UpdatePostsDisplay();
                }
            }
        }
        
        private void CommentButton_Click(object sender, RoutedEventArgs e)
        {
            if (sender is Button button && button.Tag is Post post)
            {
                MessageBox.Show($"Comments for: {post.User.Name}\n\n{post.Content}", 
                              "Comments", MessageBoxButton.OK, MessageBoxImage.Information);
            }
        }
        
        private void ShareButton_Click(object sender, RoutedEventArgs e)
        {
            if (sender is Button button && button.Tag is Post post)
            {
                MessageBox.Show($"Sharing: {post.Title}", "Share", MessageBoxButton.OK, MessageBoxImage.Information);
            }
        }
        
        private void BookmarkButton_Click(object sender, RoutedEventArgs e)
        {
            if (sender is Button button && button.Tag is string postId)
            {
                var post = posts.FirstOrDefault(p => p.Id == postId);
                if (post != null)
                {
                    post.IsBookmarked = !post.IsBookmarked;
                    UpdatePostsDisplay();
                }
            }
        }
        
        private void CreatePostTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            CreatePostButton.IsEnabled = !string.IsNullOrWhiteSpace(CreatePostTextBox.Text);
        }
        
        private void CreatePostButton_Click(object sender, RoutedEventArgs e)
        {
            var content = CreatePostTextBox.Text.Trim();
            if (string.IsNullOrEmpty(content)) return;
            
            var newPost = new Post
            {
                Id = DateTime.Now.Ticks.ToString(),
                User = new User("current-user", "You", "@you", "👤", false),
                Content = content,
                Image = "",
                Location = "",
                Timestamp = "now",
                Likes = 0,
                Comments = 0,
                Shares = 0,
                IsLiked = false,
                IsBookmarked = false,
                Privacy = "public"
            };
            
            posts.Insert(0, newPost);
            allPosts.Insert(0, newPost);
            CreatePostTextBox.Text = "";
            UpdatePostsDisplay();
        }
        
        private void FilterComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (FilterComboBox.SelectedItem is ComboBoxItem selectedItem)
            {
                currentFilter = selectedItem.Content.ToString();
                FilterPosts();
            }
        }
        
        private void FilterPosts()
        {
            // In a real implementation, this would filter posts based on the selected filter
            posts = new List<Post>(allPosts);
            UpdatePostsDisplay();
        }
        
        private void NotificationsButton_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show($"You have {unreadNotifications} unread notifications", 
                          "Notifications", MessageBoxButton.OK, MessageBoxImage.Information);
        }
        
        private void TrendingButton_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Top trending topics:\n#ReactNative\n#MobileDev\n#Tech\n#Startup\n#Innovation", 
                          "Trending", MessageBoxButton.OK, MessageBoxImage.Information);
        }
        
        private void UpdateNotificationBadge()
        {
            var notificationBadge = NotificationsButton.Template.FindName("NotificationBadge", NotificationsButton) as Ellipse;
            if (notificationBadge != null)
            {
                notificationBadge.Visibility = unreadNotifications > 0 ? Visibility.Visible : Visibility.Collapsed;
            }
        }
    }
    
    public class User
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public string Username { get; set; }
        public string Avatar { get; set; }
        public bool Verified { get; set; }
        
        public User(string id, string name, string username, string avatar, bool verified)
        {
            Id = id;
            Name = name;
            Username = username;
            Avatar = avatar;
            Verified = verified;
        }
    }
    
    public class Post
    {
        public string Id { get; set; }
        public User User { get; set; }
        public string Content { get; set; }
        public string Image { get; set; }
        public string Location { get; set; }
        public string Timestamp { get; set; }
        public int Likes { get; set; }
        public int Comments { get; set; }
        public int Shares { get; set; }
        public bool IsLiked { get; set; }
        public bool IsBookmarked { get; set; }
        public string Privacy { get; set; }
        
        public string Title => Content.Length > 50 ? Content.Substring(0, 50) + "..." : Content;
    }
}
