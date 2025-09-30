using System;
using System.Windows;

namespace AccessibilityTest
{
    public partial class UnlabeledMediaButton : Window
    {
        private bool isPlaying = false;

        public UnlabeledMediaButton()
        {
            InitializeComponent();
        }

        private void PlayPause_Click(object sender, RoutedEventArgs e)
        {
            isPlaying = !isPlaying;
            var button = sender as System.Windows.Controls.Button;
            if (button != null)
            {
                button.Content = isPlaying ? "⏸️" : "▶️";
            }
        }

        private void Previous_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Playing previous video");
        }

        private void Next_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Playing next video");
        }

        private void Volume_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Volume control opened");
        }

        private void Fullscreen_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Entering fullscreen mode");
        }
    }
}
