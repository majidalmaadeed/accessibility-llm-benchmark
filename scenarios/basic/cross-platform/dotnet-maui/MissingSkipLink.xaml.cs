using Microsoft.Maui.Controls;

namespace AccessibilityScenarios
{
    public partial class MissingSkipLink : ContentPage
    {
        public MissingSkipLink()
        {
            InitializeComponent();
        }
        
        private void OnExploreSolutionsClicked(object sender, EventArgs e)
        {
            DisplayAlert("Explore Solutions", "Redirecting to solutions page...", "OK");
        }
        
        private void OnGetQuoteClicked(object sender, EventArgs e)
        {
            DisplayAlert("Get Quote", "Opening quote request form...", "OK");
        }
        
        private void OnLearnMoreClicked(object sender, EventArgs e)
        {
            DisplayAlert("Learn More", "Opening service details...", "OK");
        }
        
        private void OnSendMessageClicked(object sender, EventArgs e)
        {
            DisplayAlert("Send Message", "Message sent successfully!", "OK");
        }
        
        private void OnNavigationClicked(object sender, EventArgs e)
        {
            DisplayAlert("Navigation", "Opening navigation page...", "OK");
        }
    }
}

