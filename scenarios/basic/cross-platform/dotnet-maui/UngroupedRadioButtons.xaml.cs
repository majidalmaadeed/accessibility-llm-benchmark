using Microsoft.Maui.Controls;

namespace AccessibilityScenarios
{
    public partial class UngroupedRadioButtons : ContentPage
    {
        public UngroupedRadioButtons()
        {
            InitializeComponent();
        }
        
        private void OnSaveClicked(object sender, EventArgs e)
        {
            DisplayAlert("Save", "Settings saved successfully!", "OK");
        }
        
        private void OnCancelClicked(object sender, EventArgs e)
        {
            DisplayAlert("Cancel", "Changes discarded!", "OK");
        }
    }
}

