using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Threading.Tasks;
using Xamarin.Forms;

namespace UIComponents
{
    public partial class SocialMediaFeedPage : ContentPage
    {
        private ObservableCollection<Post> posts = new ObservableCollection<Post>();
        private string currentFilter = "all";
        private int unreadNotifications = 3;
        private bool isLoading = false;

        public SocialMediaFeedPage()
        {
            InitializeComponent();
            BindingContext = this;
            LoadPosts();
        }

        public ObservableCollection<Post> Posts
        {
            get => posts;
            set
            {
                posts = value;
                OnPropertyChanged();
            }
        }

        private async void LoadPosts()
        {
            isLoading = true;
            LoadingIndicator.IsVisible = true;
            LoadingIndicator.IsRunning = true;

            // Simulate API call
            await Task.Delay(1000);

            var samplePosts = GetSamplePosts();
            Posts = new ObservableCollection<Post>(samplePosts);

            isLoading = false;
            LoadingIndicator.IsVisible = false;
            LoadingIndicator.IsRunning = false;
        }

        private List<Post> GetSamplePosts()
        {
            return new List<Post>
            {
                new Post
                {
                    Id = "1",
                    User = new User
                    {
                        Id = "user1",
                        Name = "John Doe",
                        Username = "@johndoe",
                        Avatar = "👨‍💻",
                        Verified = true
                    },
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
                },
                new Post
                {
                    Id = "2",
                    User = new User
                    {
                        Id = "user2",
                        Name = "Sarah Wilson",
                        Username = "@sarahw",
                        Avatar = "👩‍🎨",
                        Verified = false
                    },
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
                },
                new Post
                {
                    Id = "3",
                    User = new User
                    {
                        Id = "user3",
                        Name = "Mike Chen",
                        Username = "@mikechen",
                        Avatar = "👨‍💼",
                        Verified = true
                    },
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
                },
                new Post
                {
                    Id = "4",
                    User = new User
                    {
                        Id = "user4",
                        Name = "Emma Davis",
                        Username = "@emmad",
                        Avatar = "👩‍🔬",
                        Verified = false
                    },
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
                },
                new Post
                {
                    Id = "5",
                    User = new User
                    {
                        Id = "user5",
                        Name = "Alex Rodriguez",
                        Username = "@alexr",
                        Avatar = "👨‍🎓",
                        Verified = false
                    },
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
                }
            };
        }

        private void OnFilterChanged(object sender, EventArgs e)
        {
            if (sender is Button button && button.CommandParameter is string filter)
            {
                currentFilter = filter;
                UpdateFilterButtons();
                // In a real app, this would filter posts based on the selected filter
            }
        }

        private void UpdateFilterButtons()
        {
            // Reset all filter button colors
            var grid = Content as Grid;
            var filterGrid = grid.Children.OfType<Grid>().Skip(1).FirstOrDefault();
            if (filterGrid != null)
            {
                var buttons = filterGrid.Children.OfType<Button>().ToList();
                foreach (var button in buttons)
                {
                    if (button.CommandParameter is string filter)
                    {
                        if (filter == currentFilter)
                        {
                            button.BackgroundColor = Color.FromHex("#007AFF");
                            button.TextColor = Color.White;
                        }
                        else
                        {
                            button.BackgroundColor = Color.FromHex("#F0F0F0");
                            button.TextColor = Color.FromHex("#666");
                        }
                    }
                }
            }
        }

        private async void OnCreatePostClicked(object sender, EventArgs e)
        {
            await Navigation.PushModalAsync(new CreatePostPage());
        }

        private void OnNotificationsClicked(object sender, EventArgs e)
        {
            DisplayAlert("Notifications", $"You have {unreadNotifications} unread notifications", "OK");
        }

        private void OnTrendingClicked(object sender, EventArgs e)
        {
            DisplayAlert("Trending Topics", "Technology, Design, Programming, Startup, Innovation", "OK");
        }

        private void OnPostMenuClicked(object sender, EventArgs e)
        {
            if (sender is Button button && button.CommandParameter is string postId)
            {
                DisplayActionSheet("Post Options", "Cancel", null, "Share", "Report", "Hide");
            }
        }

        private void OnLikeClicked(object sender, EventArgs e)
        {
            if (sender is Button button && button.CommandParameter is string postId)
            {
                var post = Posts.FirstOrDefault(p => p.Id == postId);
                if (post != null)
                {
                    post.IsLiked = !post.IsLiked;
                    post.Likes += post.IsLiked ? 1 : -1;
                    post.OnPropertyChanged(nameof(post.LikeText));
                    post.OnPropertyChanged(nameof(post.LikeColor));
                }
            }
        }

        private void OnCommentClicked(object sender, EventArgs e)
        {
            if (sender is Button button && button.CommandParameter is string postId)
            {
                DisplayAlert("Comments", "Comments functionality would be implemented here", "OK");
            }
        }

        private void OnShareClicked(object sender, EventArgs e)
        {
            if (sender is Button button && button.CommandParameter is string postId)
            {
                var post = Posts.FirstOrDefault(p => p.Id == postId);
                if (post != null)
                {
                    DisplayAlert("Share Post", $"Share \"{post.Content.Substring(0, Math.Min(50, post.Content.Length))}...\"", "OK");
                }
            }
        }

        private void OnBookmarkClicked(object sender, EventArgs e)
        {
            if (sender is Button button && button.CommandParameter is string postId)
            {
                var post = Posts.FirstOrDefault(p => p.Id == postId);
                if (post != null)
                {
                    post.IsBookmarked = !post.IsBookmarked;
                    post.OnPropertyChanged(nameof(post.BookmarkText));
                    post.OnPropertyChanged(nameof(post.BookmarkColor));
                }
            }
        }

        public event PropertyChangedEventHandler PropertyChanged;
        protected virtual void OnPropertyChanged([System.Runtime.CompilerServices.CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }

    public class Post : INotifyPropertyChanged
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

        public bool HasImage => !string.IsNullOrEmpty(Image);
        public bool HasLocation => !string.IsNullOrEmpty(Location);

        public string LikeText => $"❤️ {Likes}";
        public Color LikeColor => IsLiked ? Color.Red : Color.FromHex("#666");

        public string CommentText => $"💬 {Comments}";
        public string ShareText => $"🔄 {Shares}";
        public string BookmarkText => IsBookmarked ? "🔖" : "🔖";
        public Color BookmarkColor => IsBookmarked ? Color.FromHex("#007AFF") : Color.FromHex("#666");

        public event PropertyChangedEventHandler PropertyChanged;
        protected virtual void OnPropertyChanged([System.Runtime.CompilerServices.CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }

    public class User
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public string Username { get; set; }
        public string Avatar { get; set; }
        public bool Verified { get; set; }
    }
}
