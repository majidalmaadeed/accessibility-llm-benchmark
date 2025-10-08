using UIComponents.Models;
using System.Collections.ObjectModel;

namespace UIComponents.Views;

public partial class DashboardPage : ContentPage
{
    public ObservableCollection<ActivityItem> ActivityItems { get; set; } = new();

    public DashboardPage()
    {
        InitializeComponent();
        BindingContext = this;
        LoadActivityData();
    }

    private void LoadActivityData()
    {
        ActivityItems.Clear();
        
        var actions = new[] { "Login", "Logout", "Purchase", "View", "Search" };
        
        for (int i = 0; i < 10; i++)
        {
            ActivityItems.Add(new ActivityItem
            {
                Time = DateTime.Now.AddMinutes(-i * 5).ToString("HH:mm:ss"),
                User = $"User {i + 1}",
                Action = actions[i % actions.Length]
            });
        }
    }
}

public class ActivityItem
{
    public string Time { get; set; } = string.Empty;
    public string User { get; set; } = string.Empty;
    public string Action { get; set; } = string.Empty;
}
