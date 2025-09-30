using Microsoft.Maui.Controls;

namespace AccessibilityScenarios
{
    public partial class InsufficientButtonSpacing : ContentPage
    {
        public InsufficientButtonSpacing()
        {
            InitializeComponent();
        }
        
        private void OnSaveClicked(object sender, EventArgs e)
        {
            DisplayAlert("Save", "Document saved successfully!", "OK");
        }
        
        private void OnExportClicked(object sender, EventArgs e)
        {
            DisplayAlert("Export", "Exporting document...", "OK");
        }
        
        private void OnPrintClicked(object sender, EventArgs e)
        {
            DisplayAlert("Print", "Opening print dialog...", "OK");
        }
        
        private void OnFormattingClicked(object sender, EventArgs e)
        {
            DisplayAlert("Formatting", "Applying formatting...", "OK");
        }
        
        private void OnActionClicked(object sender, EventArgs e)
        {
            DisplayAlert("Action", "Performing action...", "OK");
        }
    }
}

