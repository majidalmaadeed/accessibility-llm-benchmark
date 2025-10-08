using System;
using System.Collections.ObjectModel;
using System.ComponentModel;
using Xamarin.Forms;

namespace AccessibilityTest
{
    public partial class SmallTouchTarget : ContentPage
    {
        public ObservableCollection<PostItem> Posts { get; set; }

        public SmallTouchTarget()
        {
            InitializeComponent();
            BindingContext = this;
            
            // Initialize posts
            Posts = new ObservableCollection<PostItem>
            {
                new PostItem
                {
                    Username = "john_doe",
                    UserAvatar = "https://via.placeholder.com/40x40",
                    PostImage = "https://via.placeholder.com/400x300",
                    Caption = "Beautiful sunset from my hike today! 🏔️ #nature #photography",
                    Likes = "42 likes",
                    Comments = "View all 8 comments",
                    TimeAgo = "2h"
                },
                new PostItem
                {
                    Username = "sarah_j",
                    UserAvatar = "https://via.placeholder.com/40x40",
                    PostImage = "https://via.placeholder.com/400x300",
                    Caption = "Just finished reading an amazing book! Highly recommend it to everyone.",
                    Likes = "28 likes",
                    Comments = "View all 12 comments",
                    TimeAgo = "4h"
                },
                new PostItem
                {
                    Username = "mike_chen",
                    UserAvatar = "https://via.placeholder.com/40x40",
                    PostImage = "https://via.placeholder.com/400x300",
                    Caption = "Working on a new project. Can't wait to share the results!",
                    Likes = "15 likes",
                    Comments = "View all 3 comments",
                    TimeAgo = "6h"
                }
            };
        }

        private void OnLikeClicked(object sender, EventArgs e)
        {
            DisplayAlert("Like", "Post liked!", "OK");
        }

        private void OnCommentClicked(object sender, EventArgs e)
        {
            DisplayAlert("Comment", "Opening comments...", "OK");
        }

        private void OnShareClicked(object sender, EventArgs e)
        {
            DisplayAlert("Share", "Sharing post...", "OK");
        }
    }

    public class PostItem : INotifyPropertyChanged
    {
        public string Username { get; set; }
        public string UserAvatar { get; set; }
        public string PostImage { get; set; }
        public string Caption { get; set; }
        public string Likes { get; set; }
        public string Comments { get; set; }
        public string TimeAgo { get; set; }

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
