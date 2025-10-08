using Microsoft.Maui.Controls;

namespace AccessibilityScenarios
{
    public partial class StatusByShapeOnly : ContentPage
    {
        public StatusByShapeOnly()
        {
            InitializeComponent();
        }
        
        private void OnUploadClicked(object sender, EventArgs e)
        {
            DisplayAlert("Upload", "Opening file upload dialog...", "OK");
        }
        
        private void OnSearchClicked(object sender, EventArgs e)
        {
            DisplayAlert("Search", "Opening search interface...", "OK");
        }
        
        private void OnViewClicked(object sender, EventArgs e)
        {
            DisplayAlert("View", "Opening document viewer...", "OK");
        }
        
        private void OnDownloadClicked(object sender, EventArgs e)
        {
            DisplayAlert("Download", "Downloading document...", "OK");
        }
        
        private void OnPageClicked(object sender, EventArgs e)
        {
            DisplayAlert("Navigation", "Changing page...", "OK");
        }
    }
}

