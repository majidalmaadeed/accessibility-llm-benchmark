using System;
using System.Windows;

namespace AccessibilityTest
{
    public partial class KeyboardTrapInWidget : Window
    {
        public KeyboardTrapInWidget()
        {
            InitializeComponent();
        }

        private void PreviousMonth_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Previous month selected");
        }

        private void NextMonth_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Next month selected");
        }

        private void SelectDate_Click(object sender, RoutedEventArgs e)
        {
            var button = sender as System.Windows.Controls.Button;
            if (button != null)
            {
                MessageBox.Show($"Date {button.Content} selected");
            }
        }

        private void CancelDateSelection_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Date selection cancelled");
        }

        private void ConfirmDateSelection_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Date confirmed");
        }

        private void CancelEvent_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Event creation cancelled");
        }

        private void CreateEvent_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Event created successfully!");
        }
    }
}
