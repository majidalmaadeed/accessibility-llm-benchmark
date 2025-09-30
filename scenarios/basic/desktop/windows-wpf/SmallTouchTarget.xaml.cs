using System;
using System.Windows;

namespace AccessibilityTest
{
    public partial class SmallTouchTarget : Window
    {
        public SmallTouchTarget()
        {
            InitializeComponent();
        }

        private void MoreOptions_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("More options");
        }

        private void ToggleLike_Click(object sender, RoutedEventArgs e)
        {
            var button = sender as System.Windows.Controls.Button;
            if (button != null)
            {
                if (button.Content.ToString() == "♡")
                {
                    button.Content = "♥";
                    button.Foreground = System.Windows.Media.Brushes.Red;
                }
                else
                {
                    button.Content = "♡";
                    button.Foreground = System.Windows.Media.Brushes.Gray;
                }
            }
        }

        private void OpenComments_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Opening comments...");
        }

        private void SharePost_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Sharing post...");
        }

        private void ToggleBookmark_Click(object sender, RoutedEventArgs e)
        {
            var button = sender as System.Windows.Controls.Button;
            if (button != null)
            {
                if (button.Foreground == System.Windows.Media.Brushes.Blue)
                {
                    button.Foreground = System.Windows.Media.Brushes.Gray;
                }
                else
                {
                    button.Foreground = System.Windows.Media.Brushes.Blue;
                }
            }
        }
    }
}
