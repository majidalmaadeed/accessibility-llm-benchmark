using System;
using Xamarin.Forms;

namespace AccessibilityTest
{
    public partial class KeyboardTrapInWidget : ContentPage
    {
        public KeyboardTrapInWidget()
        {
            InitializeComponent();
        }

        private void OnPreviousMonthClicked(object sender, EventArgs e)
        {
            // Navigate to previous month
            DisplayAlert("Previous Month", "Previous month selected", "OK");
        }

        private void OnNextMonthClicked(object sender, EventArgs e)
        {
            // Navigate to next month
            DisplayAlert("Next Month", "Next month selected", "OK");
        }

        private void OnDateClicked(object sender, EventArgs e)
        {
            var button = sender as Button;
            DisplayAlert("Date Selected", $"Date {button.Text} selected", "OK");
        }

        private void OnCancelDateClicked(object sender, EventArgs e)
        {
            DisplayAlert("Cancel", "Date selection cancelled", "OK");
        }

        private void OnConfirmDateClicked(object sender, EventArgs e)
        {
            DisplayAlert("Confirm", "Date confirmed", "OK");
        }

        private void OnCancelClicked(object sender, EventArgs e)
        {
            DisplayAlert("Cancel", "Event creation cancelled", "OK");
        }

        private void OnCreateEventClicked(object sender, EventArgs e)
        {
            DisplayAlert("Create Event", "Event created successfully!", "OK");
        }
    }
}
