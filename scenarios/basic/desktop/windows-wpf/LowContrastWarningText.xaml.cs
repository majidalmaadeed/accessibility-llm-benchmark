using System;
using System.Windows;

namespace AccessibilityTest
{
    public partial class LowContrastWarningText : Window
    {
        public LowContrastWarningText()
        {
            InitializeComponent();
        }

        private void ExtendSession_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Your session has been extended to 30 minutes.");
        }

        private void Logout_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("You have been logged out successfully.");
        }
    }
}
