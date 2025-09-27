using AccessibilityBenchmark.Models;
using System.Collections.ObjectModel;

namespace AccessibilityBenchmark.Views;

public partial class SocialFeedPage : ContentPage
{
    public ObservableCollection<SocialPost> Posts { get; set; } = new();

    public SocialFeedPage()
    {
        InitializeComponent();
        BindingContext = this;
        LoadPosts();
    }

    private void LoadPosts()
    {
        Posts.Clear();
        
        Posts.Add(new SocialPost 
        { 
            User = "John Doe", 
            Time = "2 hours ago", 
            Content = "Just finished working on a new project! #coding #development" 
        });
        
        Posts.Add(new SocialPost 
        { 
            User = "Jane Smith", 
            Time = "4 hours ago", 
            Content = "Beautiful sunset today! 🌅" 
        });
        
        Posts.Add(new SocialPost 
        { 
            User = "Mike Johnson", 
            Time = "6 hours ago", 
            Content = "Great meeting with the team today. Excited about the new features!" 
        });
    }

    private void OnAttachImageClicked(object sender, EventArgs e)
    {
        DisplayAlert("Social Feed", "Image attachment feature", "OK");
    }

    private void OnAttachVideoClicked(object sender, EventArgs e)
    {
        DisplayAlert("Social Feed", "Video attachment feature", "OK");
    }

    private void OnAddLocationClicked(object sender, EventArgs e)
    {
        DisplayAlert("Social Feed", "Location feature", "OK");
    }

    private void OnPostClicked(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(PostEditor.Text))
        {
            Posts.Insert(0, new SocialPost 
            { 
                User = "You", 
                Time = "Just now", 
                Content = PostEditor.Text 
            });
            PostEditor.Text = "";
            DisplayAlert("Social Feed", "Post published!", "OK");
        }
    }

    private void OnLikeClicked(object sender, EventArgs e)
    {
        DisplayAlert("Social Feed", "Post liked!", "OK");
    }

    private void OnCommentClicked(object sender, EventArgs e)
    {
        DisplayAlert("Social Feed", "Comment feature", "OK");
    }

    private void OnShareClicked(object sender, EventArgs e)
    {
        DisplayAlert("Social Feed", "Post shared!", "OK");
    }
}

public class SocialPost
{
    public string User { get; set; } = string.Empty;
    public string Time { get; set; } = string.Empty;
    public string Content { get; set; } = string.Empty;
}
