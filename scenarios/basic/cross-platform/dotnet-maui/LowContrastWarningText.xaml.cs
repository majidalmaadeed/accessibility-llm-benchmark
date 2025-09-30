using Microsoft.Maui.Controls;

namespace AccessibilityScenarios
{
    public partial class LowContrastWarningText : ContentPage
    {
        public LowContrastWarningText()
        {
            InitializeComponent();
        }
        
        private void OnRefreshSessionClicked(object sender, EventArgs e)
        {
            DisplayAlert("Session", "Session refreshed successfully!", "OK");
        }
        
        private void OnExtendSessionClicked(object sender, EventArgs e)
        {
            DisplayAlert("Session", "Session extended for 30 minutes!", "OK");
        }
        
        private void OnSaveAndLogoutClicked(object sender, EventArgs e)
        {
            DisplayAlert("Logout", "Work saved and logged out successfully!", "OK");
        }
    }
}
