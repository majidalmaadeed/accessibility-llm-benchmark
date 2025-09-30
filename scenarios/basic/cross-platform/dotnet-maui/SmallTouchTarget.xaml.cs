using Microsoft.Maui.Controls;

namespace AccessibilityScenarios
{
    public partial class SmallTouchTarget : ContentPage
    {
        public SmallTouchTarget()
        {
            InitializeComponent();
        }
        
        private void OnLikeClicked(object sender, EventArgs e)
        {
            DisplayAlert("Like", "Post liked!", "OK");
        }
        
        private void OnCommentClicked(object sender, EventArgs e)
        {
            DisplayAlert("Comment", "Opening comment section...", "OK");
        }
        
        private void OnShareClicked(object sender, EventArgs e)
        {
            DisplayAlert("Share", "Opening share options...", "OK");
        }
        
        private void OnMoreOptionsClicked(object sender, EventArgs e)
        {
            DisplayAlert("Options", "Showing more options...", "OK");
        }
    }
}
