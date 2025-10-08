using System;
using System.Windows;

namespace AccessibilityTest
{
    public partial class UngroupedRadioButtons : Window
    {
        public UngroupedRadioButtons()
        {
            InitializeComponent();
        }

        private void ToggleContactPreference_Click(object sender, RoutedEventArgs e)
        {
            var checkbox = sender as System.Windows.Controls.CheckBox;
            if (checkbox != null)
            {
                MessageBox.Show($"Contact preference {(checkbox.IsChecked == true ? "enabled" : "disabled")}");
            }
        }

        private void NewsletterFrequency_Click(object sender, RoutedEventArgs e)
        {
            var radioButton = sender as System.Windows.Controls.RadioButton;
            if (radioButton != null && radioButton.IsChecked == true)
            {
                MessageBox.Show($"Newsletter frequency set to: {radioButton.Name.Replace("Radio", "")}");
            }
        }

        private void AccountType_Click(object sender, RoutedEventArgs e)
        {
            var radioButton = sender as System.Windows.Controls.RadioButton;
            if (radioButton != null && radioButton.IsChecked == true)
            {
                MessageBox.Show($"Account type set to: {radioButton.Name.Replace("Radio", "")}");
            }
        }

        private void ToggleTerms_Click(object sender, RoutedEventArgs e)
        {
            var checkbox = sender as System.Windows.Controls.CheckBox;
            if (checkbox != null)
            {
                MessageBox.Show($"Terms and conditions {(checkbox.IsChecked == true ? "accepted" : "declined")}");
            }
        }

        private void ToggleNewsletter_Click(object sender, RoutedEventArgs e)
        {
            var checkbox = sender as System.Windows.Controls.CheckBox;
            if (checkbox != null)
            {
                MessageBox.Show($"Newsletter subscription {(checkbox.IsChecked == true ? "enabled" : "disabled")}");
            }
        }

        private void Previous_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Previous step");
        }

        private void Next_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Next step");
        }
    }
}
