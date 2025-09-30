using System;
using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;

namespace AccessibilityTest
{
    public sealed partial class LowContrastWarningText : Page
    {
        public LowContrastWarningText()
        {
            this.InitializeComponent();
        }

        private void ExtendSession_Click(object sender, RoutedEventArgs e)
        {
            var dialog = new ContentDialog
            {
                Title = "Session Extended",
                Content = "Your session has been extended to 30 minutes.",
                CloseButtonText = "OK"
            };
            dialog.XamlRoot = this.XamlRoot;
            dialog.ShowAsync();
        }

        private void Logout_Click(object sender, RoutedEventArgs e)
        {
            var dialog = new ContentDialog
            {
                Title = "Logged Out",
                Content = "You have been logged out successfully.",
                CloseButtonText = "OK"
            };
            dialog.XamlRoot = this.XamlRoot;
            dialog.ShowAsync();
        }
    }
}
