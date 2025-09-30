using Microsoft.Maui.Controls;

namespace AccessibilityScenarios
{
    public partial class InaccessibleTooltip : ContentPage
    {
        public InaccessibleTooltip()
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
        
        private void OnTooltipClicked(object sender, EventArgs e)
        {
            DisplayAlert("Tooltip", "This is a tooltip that only shows on click, not accessible via keyboard navigation", "OK");
        }
        
        private void OnResetClicked(object sender, EventArgs e)
        {
            DisplayAlert("Reset", "Form reset successfully!", "OK");
        }
        
        private void OnSendMessageClicked(object sender, EventArgs e)
        {
            DisplayAlert("Send Message", "Message sent successfully!", "OK");
        }
    }
}

