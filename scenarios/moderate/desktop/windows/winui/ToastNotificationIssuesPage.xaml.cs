using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using Microsoft.UI.Xaml.Media;
using Microsoft.UI.Xaml.Media.Animation;
using System;
using System.Threading.Tasks;
using Windows.UI;
{
    public sealed partial class ToastNotificationIssuesPage : Page
    {
        private int _notificationCount = 0;
        public ToastNotificationIssuesPage()
        {
            this.InitializeComponent();
        }
        {
            // Basic setup only
            ShowSuccessButton.SetValue(Microsoft.UI.Xaml.Automation.AutomationProperties.AutomationIdProperty, "ShowSuccessButton");
            ShowSuccessButton.SetValue(Microsoft.UI.Xaml.Automation.AutomationProperties.NameProperty, "Show Success Notification");
            ShowErrorButton.SetValue(Microsoft.UI.Xaml.Automation.AutomationProperties.AutomationIdProperty, "ShowErrorButton");
            ShowErrorButton.SetValue(Microsoft.UI.Xaml.Automation.AutomationProperties.NameProperty, "Show Error Notification");
            ShowWarningButton.SetValue(Microsoft.UI.Xaml.Automation.AutomationProperties.AutomationIdProperty, "ShowWarningButton");
            ShowWarningButton.SetValue(Microsoft.UI.Xaml.Automation.AutomationProperties.NameProperty, "Show Warning Notification");
            ShowInfoButton.SetValue(Microsoft.UI.Xaml.Automation.AutomationProperties.AutomationIdProperty, "ShowInfoButton");
            ShowInfoButton.SetValue(Microsoft.UI.Xaml.Automation.AutomationProperties.NameProperty, "Show Info Notification");
            ClearAllButton.SetValue(Microsoft.UI.Xaml.Automation.AutomationProperties.AutomationIdProperty, "ClearAllButton");
            ClearAllButton.SetValue(Microsoft.UI.Xaml.Automation.AutomationProperties.NameProperty, "Clear All Notifications");
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
        private async void ShowToast(string type, string message, string backgroundColor, string textColor)
        {
            _notificationCount++;
            // Create toast notification
            var toast = new Border
            {
                Background = new SolidColorBrush(Color.FromArgb(255, 
                    Convert.ToByte(backgroundColor.Substring(1, 2), 16),
                    Convert.ToByte(backgroundColor.Substring(3, 2), 16),
                    Convert.ToByte(backgroundColor.Substring(5, 2), 16))),
                CornerRadius = new CornerRadius(4),
                Padding = new Thickness(15),
                Margin = new Thickness(0, 0, 0, 10)
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
                Foreground = new SolidColorBrush(Color.FromArgb(255, 
                    Convert.ToByte(textColor.Substring(1, 2), 16),
                    Convert.ToByte(textColor.Substring(3, 2), 16),
                    Convert.ToByte(textColor.Substring(5, 2), 16))),
                VerticalAlignment = VerticalAlignment.Center,
                Margin = new Thickness(0, 0, 10, 0)
            };
            // Message
            var messageText = new TextBlock
            {
                Text = message,
                FontSize = 14,
                FontWeight = FontWeights.Bold,
                Foreground = new SolidColorBrush(Color.FromArgb(255, 
                    Convert.ToByte(textColor.Substring(1, 2), 16),
                    Convert.ToByte(textColor.Substring(3, 2), 16),
                    Convert.ToByte(textColor.Substring(5, 2), 16))),
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
                Foreground = new SolidColorBrush(Color.FromArgb(255, 
                    Convert.ToByte(textColor.Substring(1, 2), 16),
                    Convert.ToByte(textColor.Substring(3, 2), 16),
                    Convert.ToByte(textColor.Substring(5, 2), 16))),
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
            toast.SetValue(Microsoft.UI.Xaml.Automation.AutomationProperties.AutomationIdProperty, $"Toast_{_notificationCount}");
            toast.SetValue(Microsoft.UI.Xaml.Automation.AutomationProperties.NameProperty, $"{type}: {message}");
            // Add to container
            ToastContainer.Children.Insert(0, toast);
            // Should implement auto-hide functionality with configurable duration
            // Basic auto-hide (5 seconds)
            await Task.Delay(5000);
            RemoveToast(toast);
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
