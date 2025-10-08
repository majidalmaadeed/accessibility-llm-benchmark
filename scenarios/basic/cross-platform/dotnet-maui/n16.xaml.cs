using Microsoft.Maui.Controls;

namespace AccessibilityScenarios
{
    public partial class SilentLoadingState : ContentPage
    {
        public SilentLoadingState()
        {
            InitializeComponent();
        }
        
        private void OnRefreshClicked(object sender, EventArgs e)
        {
            DisplayAlert("Refresh", "Refreshing data...", "OK");
        }
        
        private void OnExportClicked(object sender, EventArgs e)
        {
            DisplayAlert("Export", "Exporting data...", "OK");
        }
        
        private void OnSettingsClicked(object sender, EventArgs e)
        {
            DisplayAlert("Settings", "Opening settings...", "OK");
        }
    }
}

