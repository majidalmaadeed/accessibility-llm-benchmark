using System;
using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;

namespace AccessibilityTest
{
    public sealed partial class StatusByShapeOnly : Page
    {
        public StatusByShapeOnly()
        {
            this.InitializeComponent();
        }

        private void ToggleSelection_Click(object sender, RoutedEventArgs e)
        {
            var checkbox = sender as CheckBox;
            if (checkbox != null)
            {
                var dialog = new ContentDialog
                {
                    Title = "Selection",
                    Content = $"Document {(checkbox.IsChecked == true ? "selected" : "deselected")}",
                    CloseButtonText = "OK"
                };
                dialog.XamlRoot = this.XamlRoot;
                dialog.ShowAsync();
            }
        }

        private void ViewDocument_Click(object sender, RoutedEventArgs e)
        {
            var dialog = new ContentDialog
            {
                Title = "View Document",
                Content = "Viewing document details",
                CloseButtonText = "OK"
            };
            dialog.XamlRoot = this.XamlRoot;
            dialog.ShowAsync();
        }

        private void EditDocument_Click(object sender, RoutedEventArgs e)
        {
            var dialog = new ContentDialog
            {
                Title = "Edit Document",
                Content = "Editing document details",
                CloseButtonText = "OK"
            };
            dialog.XamlRoot = this.XamlRoot;
            dialog.ShowAsync();
        }
    }
}
