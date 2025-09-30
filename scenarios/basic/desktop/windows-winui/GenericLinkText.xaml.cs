using System;
using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;

namespace AccessibilityTest
{
    public sealed partial class GenericLinkText : Page
    {
        public GenericLinkText()
        {
            this.InitializeComponent();
        }

        private void ReadMore_Click(object sender, RoutedEventArgs e)
        {
            var dialog = new ContentDialog
            {
                Title = "Read More",
                Content = "Opening full article...",
                CloseButtonText = "OK"
            };
            dialog.XamlRoot = this.XamlRoot;
            dialog.ShowAsync();
        }

        private void ShareArticle_Click(object sender, RoutedEventArgs e)
        {
            var dialog = new ContentDialog
            {
                Title = "Share Article",
                Content = "Sharing article...",
                CloseButtonText = "OK"
            };
            dialog.XamlRoot = this.XamlRoot;
            dialog.ShowAsync();
        }
    }
}
