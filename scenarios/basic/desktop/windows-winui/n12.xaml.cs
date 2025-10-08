using System;
using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;

namespace AccessibilityTest
{
    public sealed partial class UngroupedRadioButtons : Page
    {
        public UngroupedRadioButtons()
        {
            this.InitializeComponent();
        }

        private void ToggleContactPreference_Click(object sender, RoutedEventArgs e)
        {
            var checkbox = sender as CheckBox;
            if (checkbox != null)
            {
                var dialog = new ContentDialog
                {
                    Title = "Contact Preference",
                    Content = $"Contact preference {(checkbox.IsChecked == true ? "enabled" : "disabled")}",
                    CloseButtonText = "OK"
                };
                dialog.XamlRoot = this.XamlRoot;
                dialog.ShowAsync();
            }
        }

        private void NewsletterFrequency_Click(object sender, RoutedEventArgs e)
        {
            var radioButton = sender as RadioButton;
            if (radioButton != null && radioButton.IsChecked == true)
            {
                var dialog = new ContentDialog
                {
                    Title = "Newsletter Frequency",
                    Content = $"Newsletter frequency set to: {radioButton.Name.Replace("Radio", "")}",
                    CloseButtonText = "OK"
                };
                dialog.XamlRoot = this.XamlRoot;
                dialog.ShowAsync();
            }
        }

        private void AccountType_Click(object sender, RoutedEventArgs e)
        {
            var radioButton = sender as RadioButton;
            if (radioButton != null && radioButton.IsChecked == true)
            {
                var dialog = new ContentDialog
                {
                    Title = "Account Type",
                    Content = $"Account type set to: {radioButton.Name.Replace("Radio", "")}",
                    CloseButtonText = "OK"
                };
                dialog.XamlRoot = this.XamlRoot;
                dialog.ShowAsync();
            }
        }

        private void ToggleTerms_Click(object sender, RoutedEventArgs e)
        {
            var checkbox = sender as CheckBox;
            if (checkbox != null)
            {
                var dialog = new ContentDialog
                {
                    Title = "Terms and Conditions",
                    Content = $"Terms and conditions {(checkbox.IsChecked == true ? "accepted" : "declined")}",
                    CloseButtonText = "OK"
                };
                dialog.XamlRoot = this.XamlRoot;
                dialog.ShowAsync();
            }
        }

        private void ToggleNewsletter_Click(object sender, RoutedEventArgs e)
        {
            var checkbox = sender as CheckBox;
            if (checkbox != null)
            {
                var dialog = new ContentDialog
                {
                    Title = "Newsletter Subscription",
                    Content = $"Newsletter subscription {(checkbox.IsChecked == true ? "enabled" : "disabled")}",
                    CloseButtonText = "OK"
                };
                dialog.XamlRoot = this.XamlRoot;
                dialog.ShowAsync();
            }
        }

        private void Previous_Click(object sender, RoutedEventArgs e)
        {
            var dialog = new ContentDialog
            {
                Title = "Previous",
                Content = "Previous step",
                CloseButtonText = "OK"
            };
            dialog.XamlRoot = this.XamlRoot;
            dialog.ShowAsync();
        }

        private void Next_Click(object sender, RoutedEventArgs e)
        {
            var dialog = new ContentDialog
            {
                Title = "Next",
                Content = "Next step",
                CloseButtonText = "OK"
            };
            dialog.XamlRoot = this.XamlRoot;
            dialog.ShowAsync();
        }
    }
}
