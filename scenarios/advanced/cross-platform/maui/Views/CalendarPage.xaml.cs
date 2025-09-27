using AccessibilityBenchmark.Models;
using System.Collections.ObjectModel;

namespace AccessibilityBenchmark.Views;

public partial class CalendarPage : ContentPage
{
    public ObservableCollection<CalendarEvent> Events { get; set; } = new();

    public CalendarPage()
    {
        InitializeComponent();
        BindingContext = this;
        LoadEvents();
    }

    private void LoadEvents()
    {
        Events.Clear();
        
        Events.Add(new CalendarEvent { Title = "Meeting 1", Date = "2024-01-15", Time = "10:00 AM" });
        Events.Add(new CalendarEvent { Title = "Meeting 2", Date = "2024-01-16", Time = "2:00 PM" });
        Events.Add(new CalendarEvent { Title = "Meeting 3", Date = "2024-01-17", Time = "9:00 AM" });
    }

    private void OnAddEventClicked(object sender, EventArgs e)
    {
        DisplayAlert("Calendar", "Add event functionality", "OK");
    }
}

public class CalendarEvent
{
    public string Title { get; set; } = string.Empty;
    public string Date { get; set; } = string.Empty;
    public string Time { get; set; } = string.Empty;
}
