using System;
using System.Windows;
using System.Windows.Media.Animation;

namespace AccessibilityTest
{
    public partial class FlashingAdvertisement : Window
    {
        private int flashCount = 0;
        private bool isFlashing = true;
        private Storyboard flashStoryboard;

        public FlashingAdvertisement()
        {
            InitializeComponent();
            StartFlashAnimation();
        }

        private void StartFlashAnimation()
        {
            flashStoryboard = (Storyboard)FindResource("FlashAnimation");
            flashStoryboard.Begin();
            
            // Update flash count every 200ms (5 times per second)
            var timer = new System.Windows.Threading.DispatcherTimer();
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
            var button = sender as System.Windows.Controls.Button;
            
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
            MessageBox.Show("Item added to cart!");
        }
    }
}
