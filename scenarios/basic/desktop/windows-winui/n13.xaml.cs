using System;
using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;

namespace AccessibilityTest
{
    public sealed partial class UnlabeledMediaButton : Page
    {
        private bool isPlaying = false;

        public UnlabeledMediaButton()
        {
            this.InitializeComponent();
        }

        private void PlayPause_Click(object sender, RoutedEventArgs e)
        {
            isPlaying = !isPlaying;
            var button = sender as Button;
            if (button != null)
            {
                button.Content = isPlaying ? "⏸️" : "▶️";
            }
        }

        private void Previous_Click(object sender, RoutedEventArgs e)
        {
            // Show message for demo
            var dialog = new ContentDialog
            {
                Title = "Previous Video",
                Content = "Playing previous video",
                CloseButtonText = "OK"
            };
            dialog.XamlRoot = this.XamlRoot;
            dialog.ShowAsync();
        }

        private void Next_Click(object sender, RoutedEventArgs e)
        {
            var dialog = new ContentDialog
            {
                Title = "Next Video",
                Content = "Playing next video",
                CloseButtonText = "OK"
            };
            dialog.XamlRoot = this.XamlRoot;
            dialog.ShowAsync();
        }

        private void Volume_Click(object sender, RoutedEventArgs e)
        {
            var dialog = new ContentDialog
            {
                Title = "Volume Control",
                Content = "Volume control opened",
                CloseButtonText = "OK"
            };
            dialog.XamlRoot = this.XamlRoot;
            dialog.ShowAsync();
        }

        private void Fullscreen_Click(object sender, RoutedEventArgs e)
        {
            var dialog = new ContentDialog
            {
                Title = "Fullscreen",
                Content = "Entering fullscreen mode",
                CloseButtonText = "OK"
            };
            dialog.XamlRoot = this.XamlRoot;
            dialog.ShowAsync();
        }
    }
}
