using System;
using System.Collections.ObjectModel;
using System.ComponentModel;
using Xamarin.Forms;

namespace AccessibilityTest
{
    public partial class UnlabeledMediaButton : ContentPage
    {
        private bool isPlaying = false;
        private double currentPosition = 0.3; // 30% progress

        public ObservableCollection<VideoItem> Videos { get; set; }

        public UnlabeledMediaButton()
        {
            InitializeComponent();
            BindingContext = this;
            
            // Initialize video list
            Videos = new ObservableCollection<VideoItem>
            {
                new VideoItem
                {
                    Title = "Introduction to Flutter Development",
                    Duration = "15:30",
                    Views = "125K",
                    Thumbnail = "https://via.placeholder.com/300x200",
                    Description = "Learn the basics of Flutter development with this comprehensive tutorial."
                },
                new VideoItem
                {
                    Title = "Advanced State Management",
                    Duration = "22:15",
                    Views = "89K",
                    Thumbnail = "https://via.placeholder.com/300x200",
                    Description = "Master state management patterns in Flutter applications."
                },
                new VideoItem
                {
                    Title = "Building Responsive UIs",
                    Duration = "18:45",
                    Views = "156K",
                    Thumbnail = "https://via.placeholder.com/300x200",
                    Description = "Create beautiful responsive user interfaces for all screen sizes."
                },
                new VideoItem
                {
                    Title = "Flutter Performance Optimization",
                    Duration = "25:20",
                    Views = "67K",
                    Thumbnail = "https://via.placeholder.com/300x200",
                    Description = "Optimize your Flutter apps for better performance and user experience."
                }
            };
        }

        private void OnPlayPauseClicked(object sender, EventArgs e)
        {
            isPlaying = !isPlaying;
            PlayPauseButton.Text = isPlaying ? "⏸️" : "▶️";
            
            // Update progress bar
            if (isPlaying)
            {
                // Simulate progress
                Device.StartTimer(TimeSpan.FromSeconds(1), () =>
                {
                    currentPosition += 0.01;
                    if (currentPosition > 1.0) currentPosition = 0.0;
                    
                    Device.BeginInvokeOnMainThread(() =>
                    {
                        ProgressBar.Progress = currentPosition;
                    });
                    
                    return isPlaying;
                });
            }
        }

        private void OnPreviousClicked(object sender, EventArgs e)
        {
            // Previous video logic
            DisplayAlert("Previous", "Playing previous video", "OK");
        }

        private void OnNextClicked(object sender, EventArgs e)
        {
            // Next video logic
            DisplayAlert("Next", "Playing next video", "OK");
        }

        private void OnVolumeClicked(object sender, EventArgs e)
        {
            // Volume control logic
            DisplayAlert("Volume", "Volume control opened", "OK");
        }

        private void OnFullscreenClicked(object sender, EventArgs e)
        {
            // Fullscreen logic
            DisplayAlert("Fullscreen", "Entering fullscreen mode", "OK");
        }

        private void OnVideoThumbnailClicked(object sender, EventArgs e)
        {
            // Play video from thumbnail
            DisplayAlert("Play Video", "Playing selected video", "OK");
        }
    }

    public class VideoItem : INotifyPropertyChanged
    {
        public string Title { get; set; }
        public string Duration { get; set; }
        public string Views { get; set; }
        public string Thumbnail { get; set; }
        public string Description { get; set; }

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
