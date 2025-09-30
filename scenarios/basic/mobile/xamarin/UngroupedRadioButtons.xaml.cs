using System;
using Xamarin.Forms;

namespace AccessibilityTest
{
    public partial class UngroupedRadioButtons : ContentPage
    {
        public UngroupedRadioButtons()
        {
            InitializeComponent();
        }

        private void OnEmailPreferenceClicked(object sender, EventArgs e)
        {
            var button = sender as Button;
            button.Text = button.Text == "☐" ? "☑" : "☐";
        }

        private void OnSmsPreferenceClicked(object sender, EventArgs e)
        {
            var button = sender as Button;
            button.Text = button.Text == "☐" ? "☑" : "☐";
        }

        private void OnPhonePreferenceClicked(object sender, EventArgs e)
        {
            var button = sender as Button;
            button.Text = button.Text == "☐" ? "☑" : "☐";
        }

        private void OnPushPreferenceClicked(object sender, EventArgs e)
        {
            var button = sender as Button;
            button.Text = button.Text == "☐" ? "☑" : "☐";
        }

        private void OnDailyNewsletterClicked(object sender, EventArgs e)
        {
            // Reset all newsletter options
            ResetNewsletterButtons();
            var button = sender as Button;
            button.Text = "☑";
        }

        private void OnWeeklyNewsletterClicked(object sender, EventArgs e)
        {
            ResetNewsletterButtons();
            var button = sender as Button;
            button.Text = "☑";
        }

        private void OnMonthlyNewsletterClicked(object sender, EventArgs e)
        {
            ResetNewsletterButtons();
            var button = sender as Button;
            button.Text = "☑";
        }

        private void OnNeverNewsletterClicked(object sender, EventArgs e)
        {
            ResetNewsletterButtons();
            var button = sender as Button;
            button.Text = "☑";
        }

        private void OnPersonalAccountClicked(object sender, EventArgs e)
        {
            // Reset all account type options
            ResetAccountTypeButtons();
            var button = sender as Button;
            button.Text = "☑";
        }

        private void OnBusinessAccountClicked(object sender, EventArgs e)
        {
            ResetAccountTypeButtons();
            var button = sender as Button;
            button.Text = "☑";
        }

        private void OnEnterpriseAccountClicked(object sender, EventArgs e)
        {
            ResetAccountTypeButtons();
            var button = sender as Button;
            button.Text = "☑";
        }

        private void ResetNewsletterButtons()
        {
            // This would reset all newsletter radio buttons in a real implementation
            // For demo purposes, we'll just show the concept
        }

        private void ResetAccountTypeButtons()
        {
            // This would reset all account type radio buttons in a real implementation
            // For demo purposes, we'll just show the concept
        }
    }
}
