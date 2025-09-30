using Microsoft.Maui.Controls;

namespace AccessibilityScenarios
{
    public partial class GenericLinkText : ContentPage
    {
        public GenericLinkText()
        {
            InitializeComponent();
        }
        
        private void OnReadMoreClicked(object sender, EventArgs e)
        {
            DisplayAlert("Read More", "Opening full article...", "OK");
        }
        
        private void OnSearchClicked(object sender, EventArgs e)
        {
            DisplayAlert("Search", "Opening search page...", "OK");
        }
        
        private void OnSettingsClicked(object sender, EventArgs e)
        {
            DisplayAlert("Settings", "Opening settings page...", "OK");
        }
    }
}

