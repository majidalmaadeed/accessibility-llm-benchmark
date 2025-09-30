using System;
using System.Windows;
using System.Windows.Media.Animation;

namespace AccessibilityTest
{
    public partial class SilentLoadingState : Window
    {
        private Storyboard loadingStoryboard;
        private int progress = 0;

        public SilentLoadingState()
        {
            InitializeComponent();
            StartLoading();
        }

        private void StartLoading()
        {
            loadingStoryboard = (Storyboard)FindResource("LoadingAnimation");
            loadingStoryboard.Begin();
            
            // Update progress every 100ms
            var timer = new System.Windows.Threading.DispatcherTimer();
            timer.Interval = TimeSpan.FromMilliseconds(100);
            timer.Tick += (s, e) =>
            {
                progress += 2;
                ProgressFill.Width = progress * 2; // Scale to 200px width
                ProgressText.Text = $"{progress}% complete";
                
                if (progress >= 100)
                {
                    timer.Stop();
                    loadingStoryboard.Stop();
                    
                    // Show main content
                    LoadingSection.Visibility = Visibility.Collapsed;
                    MainContent.Visibility = Visibility.Visible;
                }
            };
            timer.Start();
        }

        private void RefreshData_Click(object sender, RoutedEventArgs e)
        {
            MainContent.Visibility = Visibility.Collapsed;
            LoadingSection.Visibility = Visibility.Visible;
            progress = 0;
            ProgressFill.Width = 0;
            ProgressText.Text = "0% complete";
            StartLoading();
        }
    }
}
