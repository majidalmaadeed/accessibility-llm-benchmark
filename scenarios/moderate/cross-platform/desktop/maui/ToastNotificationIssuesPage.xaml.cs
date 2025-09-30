using Microsoft.Maui.Controls;
{
    public partial class ToastNotificationIssuesPage : ContentPage
    {
        private List<ToastNotification> _notifications = new List<ToastNotification>();
        private int _notificationCount = 0;
        public ToastNotificationIssuesPage()
        {
            InitializeComponent();
        }
        {
            // Basic setup only
            ShowSuccessButton.AutomationId = "ShowSuccessButton";
            ShowErrorButton.AutomationId = "ShowErrorButton";
            ShowWarningButton.AutomationId = "ShowWarningButton";
            ShowInfoButton.AutomationId = "ShowInfoButton";
            ClearAllButton.AutomationId = "ClearAllButton";
        }
        private void OnShowSuccessClicked(object sender, EventArgs e)
        {
            ShowToast("success", "Operation completed successfully!");
        }
        private void OnShowErrorClicked(object sender, EventArgs e)
        {
            ShowToast("error", "An error occurred while processing your request.");
        }
        private void OnShowWarningClicked(object sender, EventArgs e)
        {
            ShowToast("warning", "Please review your input before proceeding.");
        }
        private void OnShowInfoClicked(object sender, EventArgs e)
        {
            ShowToast("info", "New updates are available for download.");
        }
        private void OnClearAllClicked(object sender, EventArgs e)
        {
            ClearAllNotifications();
        }
        private void ShowToast(string type, string message)
        {
            _notificationCount++;
            var notification = new ToastNotification
            {
                Id = _notificationCount,
                Type = type,
                Message = message,
                Timestamp = DateTime.Now
            };
            _notifications.Insert(0, notification);
            // Create toast view
            var toastFrame = new Frame
            {
                BackgroundColor = Colors.White,
                BorderColor = GetColorForType(type),
                CornerRadius = 8,
                Padding = new Thickness(15, 20),
                Margin = new Thickness(0, 0, 0, 10)
            };
            // Content layout
            var contentLayout = new StackLayout
            {
                Orientation = StackOrientation.Horizontal,
                Spacing = 10
            };
            // Icon
            {
                Text = GetIconForType(type),
                TextColor = GetColorForType(type),
                FontSize = 20,
                FontAttributes = FontAttributes.Bold,
                WidthRequest = 30
            };
            // Message
            {
                Text = message,
                TextColor = GetColorForType(type),
                FontSize = 14,
                FontAttributes = FontAttributes.Bold,
                HorizontalOptions = LayoutOptions.FillAndExpand
            };
            var dismissButton = new Button
            {
                Text = "×",
                BackgroundColor = Colors.Transparent,
                TextColor = Colors.Gray,
                FontSize = 18,
                FontAttributes = FontAttributes.Bold,
                WidthRequest = 24,
                HeightRequest = 24,
                CornerRadius = 12
            };
            dismissButton.Clicked += (s, e) => DismissToast(notification.Id);
            contentLayout.Children.Add(dismissButton);
            toastFrame.Content = contentLayout;
            toastFrame.AutomationId = $"Toast{notification.Id}";
            // Add to container
            ToastContainer.Children.Insert(0, toastFrame);
            // Should implement auto-hide functionality with configurable duration
            // Basic auto-hide (5 seconds)
            Device.StartTimer(TimeSpan.FromSeconds(5), () =>
            {
                DismissToast(notification.Id);
                return false; // Stop timer
            });
        }
        private void DismissToast(int id)
        {
            // Remove from notifications list
            _notifications.RemoveAll(n => n.Id == id);
            // Remove from UI
            var toastToRemove = ToastContainer.Children.FirstOrDefault(c => c.AutomationId == $"Toast{id}");
            if (toastToRemove != null)
            {
                ToastContainer.Children.Remove(toastToRemove);
            }
        }
        private void ClearAllNotifications()
        {
            _notifications.Clear();
            _notificationCount = 0;
            // Remove all toast views
            ToastContainer.Children.Clear();
        }
        private string GetIconForType(string type)
        {
            return type switch
            {
                "success" => "✓",
                "error" => "✗",
                "warning" => "⚠",
                "info" => "ℹ",
                _ => "•"
            };
        }
        private Color GetColorForType(string type)
        {
            return type switch
            {
                "success" => Color.FromRgb(40, 167, 69),
                "error" => Color.FromRgb(220, 53, 69),
                "warning" => Color.FromRgb(255, 193, 7),
                "info" => Color.FromRgb(23, 162, 184),
                _ => Color.FromRgb(108, 117, 125)
            };
        }
        // Should implement methods to:
        // 4. Provide programmatic access to notification content
    }
    public class ToastNotification
    {
        public int Id { get; set; }
        public string Type { get; set; }
        public string Message { get; set; }
        public DateTime Timestamp { get; set; }
    }
}
