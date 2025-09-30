using System;
using Xamarin.Forms;

namespace AccessibilityTest
{
    public partial class InaccessibleTooltip : ContentPage
    {
        public InaccessibleTooltip()
        {
            InitializeComponent();
        }

        private void OnFormTypeHelpClicked(object sender, EventArgs e)
        {
            DisplayAlert("Form Type Help", 
                "Select the type of form you want to create. This determines the default fields and settings.", 
                "OK");
        }

        private void OnResponseCollectionHelpClicked(object sender, EventArgs e)
        {
            DisplayAlert("Response Collection Help", 
                "Enable this to collect and store responses from form submissions. Disable for view-only forms.", 
                "OK");
        }

        private void OnPrivacySettingsHelpClicked(object sender, EventArgs e)
        {
            DisplayAlert("Privacy Settings Help", 
                "Choose who can access and submit this form. Public forms are accessible to everyone.", 
                "OK");
        }

        private void OnDeadlineHelpClicked(object sender, EventArgs e)
        {
            DisplayAlert("Submission Deadline Help", 
                "Set a deadline for form submissions. After this date, the form will be closed for new responses.", 
                "OK");
        }

        private void OnEmailNotificationsHelpClicked(object sender, EventArgs e)
        {
            DisplayAlert("Email Notifications Help", 
                "Receive email alerts when someone submits a response to your form.", 
                "OK");
        }

        private void OnAdvancedOptionsHelpClicked(object sender, EventArgs e)
        {
            DisplayAlert("Advanced Options Help", 
                "Enable advanced customization features like custom validation rules, conditional logic, and API integration.", 
                "OK");
        }

        private void OnCancelClicked(object sender, EventArgs e)
        {
            DisplayAlert("Cancel", "Form creation cancelled.", "OK");
        }

        private void OnCreateFormClicked(object sender, EventArgs e)
        {
            DisplayAlert("Create Form", "Form created successfully!", "OK");
        }
    }
}
