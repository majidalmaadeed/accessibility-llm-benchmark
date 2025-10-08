using Microsoft.Maui.Controls;

namespace AccessibilityScenarios
{
    public partial class MissingPageTitle : ContentPage
    {
        public MissingPageTitle()
        {
            InitializeComponent();
        }
        
        private void OnHelpClicked(object sender, EventArgs e)
        {
            DisplayAlert("Help", "Opening help documentation...", "OK");
        }
        
        private void OnBackClicked(object sender, EventArgs e)
        {
            DisplayAlert("Back", "Returning to previous page...", "OK");
        }
    }
}

