using System;
using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;

namespace AccessibilityTest
{
    public sealed partial class AutoPlayingBackgroundVideo : Page
    {
        public AutoPlayingBackgroundVideo()
        {
            this.InitializeComponent();
        }

        private void BackgroundVideo_MediaEnded(object sender, RoutedEventArgs e)
        {
            // Restart the video when it ends
            BackgroundVideo.Position = TimeSpan.Zero;
            BackgroundVideo.Play();
        }

        private void LearnMore_Click(object sender, RoutedEventArgs e)
        {
            var dialog = new ContentDialog
            {
                Title = "Learn More",
                Content = "Learn more about our technology",
                CloseButtonText = "OK"
            };
            dialog.XamlRoot = this.XamlRoot;
            dialog.ShowAsync();
        }

        private void PauseVideo_Click(object sender, RoutedEventArgs e)
        {
            var button = sender as Button;
            if (button != null)
            {
                if (button.Content.ToString() == "⏸️ Pause")
                {
                    BackgroundVideo.Pause();
                    button.Content = "▶️ Play";
                }
                else
                {
                    BackgroundVideo.Play();
                    button.Content = "⏸️ Pause";
                }
            }
        }

        private void StartTrial_Click(object sender, RoutedEventArgs e)
        {
            var dialog = new ContentDialog
            {
                Title = "Start Trial",
                Content = "Starting free trial",
                CloseButtonText = "OK"
            };
            dialog.XamlRoot = this.XamlRoot;
            dialog.ShowAsync();
        }

        private void ContactSales_Click(object sender, RoutedEventArgs e)
        {
            var dialog = new ContentDialog
            {
                Title = "Contact Sales",
                Content = "Contacting sales team",
                CloseButtonText = "OK"
            };
            dialog.XamlRoot = this.XamlRoot;
            dialog.ShowAsync();
        }

        private void PrivacyPolicy_Click(object sender, RoutedEventArgs e)
        {
            var dialog = new ContentDialog
            {
                Title = "Privacy Policy",
                Content = "Opening privacy policy",
                CloseButtonText = "OK"
            };
            dialog.XamlRoot = this.XamlRoot;
            dialog.ShowAsync();
        }

        private void TermsOfService_Click(object sender, RoutedEventArgs e)
        {
            var dialog = new ContentDialog
            {
                Title = "Terms of Service",
                Content = "Opening terms of service",
                CloseButtonText = "OK"
            };
            dialog.XamlRoot = this.XamlRoot;
            dialog.ShowAsync();
        }

        private void Support_Click(object sender, RoutedEventArgs e)
        {
            var dialog = new ContentDialog
            {
                Title = "Support",
                Content = "Opening support",
                CloseButtonText = "OK"
            };
            dialog.XamlRoot = this.XamlRoot;
            dialog.ShowAsync();
        }
    }
}
