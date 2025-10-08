using Microsoft.Maui.Controls;

namespace AccessibilityScenarios
{
    public partial class ColorOnlyErrorIndication : ContentPage
    {
        public ColorOnlyErrorIndication()
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
        
        private void OnResetClicked(object sender, EventArgs e)
        {
            DisplayAlert("Reset", "Form reset successfully!", "OK");
        }
        
        private void OnCreateAccountClicked(object sender, EventArgs e)
        {
            DisplayAlert("Create Account", "Account created successfully!", "OK");
        }
        
        private void OnSupportClicked(object sender, EventArgs e)
        {
            DisplayAlert("Support", "Opening support options...", "OK");
        }
    }
}

