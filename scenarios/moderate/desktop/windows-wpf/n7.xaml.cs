using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Threading;
{
    public partial class ToastNotificationIssuesWindow : Window
    {
        private int _notificationCount = 0;
        public ToastNotificationIssuesWindow()
        {
            InitializeComponent();
        }
        {
            // Basic setup only
            ShowSuccessButton.SetValue(AutomationProperties.AutomationIdProperty, "ShowSuccessButton");
            ShowSuccessButton.SetValue(AutomationProperties.NameProperty, "Show Success Notification");
            ShowErrorButton.SetValue(AutomationProperties.AutomationIdProperty, "ShowErrorButton");
            ShowErrorButton.SetValue(AutomationProperties.NameProperty, "Show Error Notification");
            ShowWarningButton.SetValue(AutomationProperties.AutomationIdProperty, "ShowWarningButton");
            ShowWarningButton.SetValue(AutomationProperties.NameProperty, "Show Warning Notification");
            ShowInfoButton.SetValue(AutomationProperties.AutomationIdProperty, "ShowInfoButton");
            ShowInfoButton.SetValue(AutomationProperties.NameProperty, "Show Info Notification");
            ClearAllButton.SetValue(AutomationProperties.AutomationIdProperty, "ClearAllButton");
            ClearAllButton.SetValue(AutomationProperties.NameProperty, "Clear All Notifications");
        }
        private void OnShowSuccessClicked(object sender, RoutedEventArgs e)
        {
            ShowToast("Success", "Operation completed successfully!", "#28A745", "#FFFFFF");
        }
        private void OnShowErrorClicked(object sender, RoutedEventArgs e)
        {
            ShowToast("Error", "An error occurred while processing your request.", "#DC3545", "#FFFFFF");
        }
        private void OnShowWarningClicked(object sender, RoutedEventArgs e)
        {
            ShowToast("Warning", "Please review your input before proceeding.", "#FFC107", "#212529");
        }
        private void OnShowInfoClicked(object sender, RoutedEventArgs e)
        {
            ShowToast("Info", "New updates are available for download.", "#17A2B8", "#FFFFFF");
        }
        private void OnClearAllClicked(object sender, RoutedEventArgs e)
        {
            ToastContainer.Children.Clear();
            _notificationCount = 0;
        }
        private void ShowToast(string type, string message, string backgroundColor, string textColor)
        {
            _notificationCount++;
            // Create toast notification
            var toast = new Border
            {
                Background = new SolidColorBrush((Color)ColorConverter.ConvertFromString(backgroundColor)),
                CornerRadius = new CornerRadius(4),
                Padding = new Thickness(15),
                Margin = new Thickness(0, 0, 0, 10),
                Effect = new DropShadowEffect
                {
                    Color = Colors.Black,
                    Direction = 270,
                    ShadowDepth = 2,
                    Opacity = 0.2,
                    BlurRadius = 8
                }
            };
            var panel = new StackPanel
            {
                Orientation = Orientation.Horizontal
            };
            // Icon
            var icon = new TextBlock
            {
                Text = GetIconForType(type),
                FontSize = 20,
                Foreground = new SolidColorBrush((Color)ColorConverter.ConvertFromString(textColor)),
                VerticalAlignment = VerticalAlignment.Center,
                Margin = new Thickness(0, 0, 10, 0)
            };
            // Message
            var messageText = new TextBlock
            {
                Text = message,
                FontSize = 14,
                FontWeight = FontWeights.Bold,
                Foreground = new SolidColorBrush((Color)ColorConverter.ConvertFromString(textColor)),
                VerticalAlignment = VerticalAlignment.Center,
                TextWrapping = TextWrapping.Wrap,
                Margin = new Thickness(0, 0, 10, 0)
            };
            var dismissButton = new Button
            {
                Content = "×",
                Width = 24,
                Height = 24,
                FontSize = 16,
                FontWeight = FontWeights.Bold,
                Background = new SolidColorBrush(Colors.Transparent),
                BorderThickness = new Thickness(0),
                Foreground = new SolidColorBrush((Color)ColorConverter.ConvertFromString(textColor)),
                VerticalAlignment = VerticalAlignment.Center,
                HorizontalAlignment = HorizontalAlignment.Right,
                Click = (s, args) => RemoveToast(toast)
            };
            panel.Children.Add(icon);
            panel.Children.Add(messageText);
            panel.Children.Add(dismissButton);
            toast.Child = panel;
            // Should set up AutomationProperties.LiveSetting, AutomationProperties.AutomationId
            // Basic setup only
            toast.SetValue(AutomationProperties.AutomationIdProperty, $"Toast_{_notificationCount}");
            toast.SetValue(AutomationProperties.NameProperty, $"{type}: {message}");
            // Add to container
            ToastContainer.Children.Insert(0, toast);
            // Should implement auto-hide functionality with configurable duration
            // Basic auto-hide (5 seconds)
            var timer = new DispatcherTimer
            {
                Interval = TimeSpan.FromSeconds(5)
            };
            timer.Tick += (s, args) =>
            {
                timer.Stop();
                RemoveToast(toast);
            };
            timer.Start();
        }
        private void RemoveToast(Border toast)
        {
            if (ToastContainer.Children.Contains(toast))
            {
                ToastContainer.Children.Remove(toast);
            }
        }
        private string GetIconForType(string type)
        {
            return type switch
            {
                "Success" => "✓",
                "Error" => "✗",
                "Warning" => "⚠",
                "Info" => "ℹ",
                _ => "•"
            };
        }
        // Should implement methods to:
        // 4. Provide programmatic access to notification content
    }
}
