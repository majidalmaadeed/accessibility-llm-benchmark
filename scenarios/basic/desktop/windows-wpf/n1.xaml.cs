using System;
using System.Windows;

namespace AccessibilityTest
{
    public partial class AutoPlayingBackgroundVideo : Window
    {
        public AutoPlayingBackgroundVideo()
        {
            InitializeComponent();
        }

        private void BackgroundVideo_MediaEnded(object sender, RoutedEventArgs e)
        {
            // Restart the video when it ends
            BackgroundVideo.Position = TimeSpan.Zero;
            BackgroundVideo.Play();
        }

        private void LearnMore_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Learn more about our technology");
        }

        private void PauseVideo_Click(object sender, RoutedEventArgs e)
        {
            if (BackgroundVideo.LoadedBehavior == MediaElement.LoadedBehavior.Play)
            {
                BackgroundVideo.Pause();
                ((System.Windows.Controls.Button)sender).Content = "▶️ Play";
            }
            else
            {
                BackgroundVideo.Play();
                ((System.Windows.Controls.Button)sender).Content = "⏸️ Pause";
            }
        }

        private void StartTrial_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Starting free trial");
        }

        private void ContactSales_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Contacting sales team");
        }

        private void PrivacyPolicy_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Opening privacy policy");
        }

        private void TermsOfService_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Opening terms of service");
        }

        private void Support_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Opening support");
        }
    }
}
