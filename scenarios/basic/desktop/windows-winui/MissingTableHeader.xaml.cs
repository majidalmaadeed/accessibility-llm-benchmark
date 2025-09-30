using System;
using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;

namespace AccessibilityTest
{
    public sealed partial class MissingTableHeader : Page
    {
        public MissingTableHeader()
        {
            this.InitializeComponent();
        }

        private void Search_Click(object sender, RoutedEventArgs e)
        {
            var dialog = new ContentDialog
            {
                Title = "Search",
                Content = "Searching employees...",
                CloseButtonText = "OK"
            };
            dialog.XamlRoot = this.XamlRoot;
            dialog.ShowAsync();
        }

        private void ViewEmployee_Click(object sender, RoutedEventArgs e)
        {
            var dialog = new ContentDialog
            {
                Title = "View Employee",
                Content = "Viewing employee details",
                CloseButtonText = "OK"
            };
            dialog.XamlRoot = this.XamlRoot;
            dialog.ShowAsync();
        }

        private void EditEmployee_Click(object sender, RoutedEventArgs e)
        {
            var dialog = new ContentDialog
            {
                Title = "Edit Employee",
                Content = "Editing employee details",
                CloseButtonText = "OK"
            };
            dialog.XamlRoot = this.XamlRoot;
            dialog.ShowAsync();
        }
    }
}
