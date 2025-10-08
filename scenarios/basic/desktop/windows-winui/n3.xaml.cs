using System;
using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using Microsoft.UI.Xaml.Media.Animation;

namespace AccessibilityTest
{
    public sealed partial class FlashingAdvertisement : Page
    {
        private int flashCount = 0;
        private bool isFlashing = true;
        private Storyboard flashStoryboard;

        public FlashingAdvertisement()
        {
            this.InitializeComponent();
            StartFlashAnimation();
        }

        private void StartFlashAnimation()
        {
            flashStoryboard = (Storyboard)FindResource("FlashAnimation");
            flashStoryboard.Begin();
            
            // Update flash count every 200ms (5 times per second)
            var timer = new DispatcherTimer();
            timer.Interval = TimeSpan.FromMilliseconds(200);
            timer.Tick += (s, e) =>
            {
                if (isFlashing)
                {
                    flashCount++;
                    FlashCount.Text = $"Flashes: {flashCount}";
                }
            };
            timer.Start();
        }

        private void ToggleFlash_Click(object sender, RoutedEventArgs e)
        {
            isFlashing = !isFlashing;
            var button = sender as Button;
            
            if (isFlashing)
            {
                flashStoryboard.Begin();
                button.Content = "⏸️";
            }
            else
            {
                flashStoryboard.Stop();
                button.Content = "▶️";
            }
        }

        private void AddToCart_Click(object sender, RoutedEventArgs e)
        {
            var dialog = new ContentDialog
            {
                Title = "Add to Cart",
                Content = "Item added to cart!",
                CloseButtonText = "OK"
            };
            dialog.XamlRoot = this.XamlRoot;
            dialog.ShowAsync();
        }
    }
}
