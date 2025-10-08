using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using Microsoft.UI.Xaml.Media;
using Microsoft.UI.Xaml.Shapes;
using Windows.ApplicationModel.DataTransfer;

namespace UIComponents
{
    public sealed partial class CalendarApplication : Page
    {
        private DateTime currentDate;
        private DateTime selectedDate;
        private List<Event> events;
        private string currentViewMode = "Month";
        
        public CalendarApplication()
        {
            this.InitializeComponent();
            currentDate = DateTime.Now;
            selectedDate = DateTime.Now;
            events = new List<Event>();
            LoadSampleEvents();
            UpdateCalendar();
        }
        
        private void LoadSampleEvents()
        {
            events.Add(new Event
            {
                Id = "1",
                Title = "Team Meeting",
                Description = "Weekly team standup",
                StartTime = DateTime.Now.AddDays(1).Date.AddHours(10),
                EndTime = DateTime.Now.AddDays(1).Date.AddHours(11),
                Category = "work",
                IsAllDay = false,
                Location = "Conference Room A",
                Attendees = new List<string> { "john@example.com", "jane@example.com" },
                Recurring = "weekly",
                Reminders = new List<string> { "15min", "1hour" }
            });
            
            events.Add(new Event
            {
                Id = "2",
                Title = "Doctor Appointment",
                Description = "Annual checkup",
                StartTime = DateTime.Now.AddDays(2).Date.AddHours(14).AddMinutes(30),
                EndTime = DateTime.Now.AddDays(2).Date.AddHours(15).AddMinutes(30),
                Category = "appointment",
                IsAllDay = false,
                Location = "Medical Center",
                Attendees = new List<string>(),
                Recurring = "none",
                Reminders = new List<string> { "1day", "2hours" }
            });
            
            events.Add(new Event
            {
                Id = "3",
                Title = "Project Deadline",
                Description = "Submit final report",
                StartTime = DateTime.Now.AddDays(5).Date.AddHours(17),
                EndTime = DateTime.Now.AddDays(5).Date.AddHours(18),
                Category = "work",
                IsAllDay = true,
                Location = "",
                Attendees = new List<string>(),
                Recurring = "none",
                Reminders = new List<string> { "1week", "1day" }
            });
        }
        
        private void UpdateCalendar()
        {
            DateLabel.Text = currentDate.ToString("MMMM yyyy");
            
            switch (currentViewMode)
            {
                case "Month":
                    UpdateMonthView();
                    break;
                case "Week":
                    UpdateWeekView();
                    break;
                case "Day":
                    UpdateDayView();
                    break;
            }
        }
        
        private void UpdateMonthView()
        {
            MonthView.Visibility = Visibility.Visible;
            WeekView.Visibility = Visibility.Collapsed;
            DayView.Visibility = Visibility.Collapsed;
            
            CalendarGrid.Children.Clear();
            
            var firstDayOfMonth = new DateTime(currentDate.Year, currentDate.Month, 1);
            var lastDayOfMonth = firstDayOfMonth.AddMonths(1).AddDays(-1);
            var startDate = firstDayOfMonth.AddDays(-(int)firstDayOfMonth.DayOfWeek);
            
            for (int i = 0; i < 42; i++)
            {
                var date = startDate.AddDays(i);
                var dayButton = CreateDayButton(date, i);
                CalendarGrid.Children.Add(dayButton);
            }
        }
        
        private Button CreateDayButton(DateTime date, int index)
        {
            var button = new Button
            {
                Content = date.Day.ToString(),
                Margin = new Thickness(4),
                FontSize = 16,
                Background = new SolidColorBrush(Microsoft.UI.Colors.White),
                BorderBrush = new SolidColorBrush(Microsoft.UI.Colors.LightGray),
                BorderThickness = new Thickness(1),
                CornerRadius = new CornerRadius(4)
            };
            
            // Highlight today
            if (date.Date == DateTime.Today)
            {
                button.Background = new SolidColorBrush(Microsoft.UI.Colors.DodgerBlue);
                button.Foreground = new SolidColorBrush(Microsoft.UI.Colors.White);
                button.FontWeight = Microsoft.UI.Text.FontWeights.Bold;
            }
            
            // Highlight selected date
            if (date.Date == selectedDate.Date)
            {
                button.Background = new SolidColorBrush(Microsoft.UI.Colors.Gold);
                button.Foreground = new SolidColorBrush(Microsoft.UI.Colors.Black);
            }
            
            // Gray out days from other months
            if (date.Month != currentDate.Month)
            {
                button.Foreground = new SolidColorBrush(Microsoft.UI.Colors.Gray);
                button.Opacity = 0.5;
            }
            
            // Add event indicators
            var dayEvents = GetEventsForDate(date);
            if (dayEvents.Any())
            {
                var stackPanel = new StackPanel();
                stackPanel.Children.Add(new TextBlock { 
                    Text = date.Day.ToString(), 
                    HorizontalAlignment = HorizontalAlignment.Center,
                    FontSize = 16
                });
                
                var eventIndicators = new StackPanel { 
                    Orientation = Orientation.Horizontal, 
                    HorizontalAlignment = HorizontalAlignment.Center 
                };
                foreach (var evt in dayEvents.Take(3))
                {
                    var indicator = new Rectangle
                    {
                        Width = 8,
                        Height = 8,
                        Fill = GetCategoryColor(evt.Category),
                        Margin = new Thickness(2)
                    };
                    eventIndicators.Children.Add(indicator);
                }
                stackPanel.Children.Add(eventIndicators);
                button.Content = stackPanel;
            }
            
            button.Click += (s, e) => OnDayClicked(date);
            
            Grid.SetRow(button, index / 7);
            Grid.SetColumn(button, index % 7);
            
            return button;
        }
        
        private void UpdateWeekView()
        {
            MonthView.Visibility = Visibility.Collapsed;
            WeekView.Visibility = Visibility.Visible;
            DayView.Visibility = Visibility.Collapsed;
            
            var startOfWeek = currentDate.AddDays(-(int)currentDate.DayOfWeek);
            
            for (int i = 0; i < 7; i++)
            {
                var date = startOfWeek.AddDays(i);
                var dayTextBlock = FindName($"WeekDay{i}") as TextBlock;
                var eventsListView = FindName($"WeekEvents{i}") as ListView;
                
                if (dayTextBlock != null)
                {
                    dayTextBlock.Text = date.Day.ToString();
                }
                
                if (eventsListView != null)
                {
                    eventsListView.Items.Clear();
                    var dayEvents = GetEventsForDate(date);
                    foreach (var evt in dayEvents)
                    {
                        var item = new ListViewItem
                        {
                            Content = $"{evt.StartTime:HH:mm} - {evt.Title}",
                            Background = GetCategoryColor(evt.Category),
                            Margin = new Thickness(4),
                            Padding = new Thickness(8)
                        };
                        eventsListView.Items.Add(item);
                    }
                }
            }
        }
        
        private void UpdateDayView()
        {
            MonthView.Visibility = Visibility.Collapsed;
            WeekView.Visibility = Visibility.Collapsed;
            DayView.Visibility = Visibility.Visible;
            
            DayDateLabel.Text = currentDate.ToString("dddd, MMMM d, yyyy");
            
            DayEventsListBox.Items.Clear();
            var dayEvents = GetEventsForDate(currentDate);
            foreach (var evt in dayEvents.OrderBy(e => e.StartTime))
            {
                DayEventsListBox.Items.Add(evt);
            }
        }
        
        private List<Event> GetEventsForDate(DateTime date)
        {
            return events.Where(e => e.StartTime.Date == date.Date).ToList();
        }
        
        private Brush GetCategoryColor(string category)
        {
            switch (category)
            {
                case "personal": return new SolidColorBrush(Microsoft.UI.Colors.Green);
                case "work": return new SolidColorBrush(Microsoft.UI.Colors.Blue);
                case "meeting": return new SolidColorBrush(Microsoft.UI.Colors.Orange);
                case "appointment": return new SolidColorBrush(Microsoft.UI.Colors.Purple);
                case "reminder": return new SolidColorBrush(Microsoft.UI.Colors.Red);
                default: return new SolidColorBrush(Microsoft.UI.Colors.Blue);
            }
        }
        
        private async void OnDayClicked(DateTime date)
        {
            selectedDate = date;
            var dayEvents = GetEventsForDate(date);
            
            if (dayEvents.Any())
            {
                await ShowEventDetails(dayEvents.First());
            }
            else
            {
                await ShowCreateEventDialog();
            }
            
            UpdateCalendar();
        }
        
        private async System.Threading.Tasks.Task ShowEventDetails(Event evt)
        {
            var dialog = new ContentDialog
            {
                Title = evt.Title,
                Content = $"{evt.Description}\n\n" +
                         $"Time: {evt.StartTime:MMM dd, yyyy hh:mm tt}" +
                         (evt.IsAllDay ? "" : $" - {evt.EndTime:hh:mm tt}") + "\n" +
                         (string.IsNullOrEmpty(evt.Location) ? "" : $"Location: {evt.Location}\n") +
                         $"Category: {evt.Category}\n" +
                         $"Recurring: {evt.Recurring}",
                PrimaryButtonText = "Close",
                SecondaryButtonText = "Delete",
                XamlRoot = this.XamlRoot
            };
            
            var result = await dialog.ShowAsync();
            
            if (result == ContentDialogResult.Secondary)
            {
                var confirmDialog = new ContentDialog
                {
                    Title = "Delete Event",
                    Content = "Are you sure you want to delete this event?",
                    PrimaryButtonText = "Yes",
                    SecondaryButtonText = "No",
                    XamlRoot = this.XamlRoot
                };
                
                var confirmResult = await confirmDialog.ShowAsync();
                if (confirmResult == ContentDialogResult.Primary)
                {
                    events.Remove(evt);
                    UpdateCalendar();
                }
            }
        }
        
        private async System.Threading.Tasks.Task ShowCreateEventDialog()
        {
            var dialog = new CreateEventDialog();
            dialog.XamlRoot = this.XamlRoot;
            
            var result = await dialog.ShowAsync();
            if (result == ContentDialogResult.Primary)
            {
                var newEvent = dialog.GetEvent();
                if (newEvent != null)
                {
                    events.Add(newEvent);
                    UpdateCalendar();
                }
            }
        }
        
        private void PreviousButton_Click(object sender, RoutedEventArgs e)
        {
            switch (currentViewMode)
            {
                case "Month":
                    currentDate = currentDate.AddMonths(-1);
                    break;
                case "Week":
                    currentDate = currentDate.AddDays(-7);
                    break;
                case "Day":
                    currentDate = currentDate.AddDays(-1);
                    break;
            }
            UpdateCalendar();
        }
        
        private void NextButton_Click(object sender, RoutedEventArgs e)
        {
            switch (currentViewMode)
            {
                case "Month":
                    currentDate = currentDate.AddMonths(1);
                    break;
                case "Week":
                    currentDate = currentDate.AddDays(7);
                    break;
                case "Day":
                    currentDate = currentDate.AddDays(1);
                    break;
            }
            UpdateCalendar();
        }
        
        private void ViewModeComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (ViewModeComboBox.SelectedItem is ComboBoxItem selectedItem)
            {
                currentViewMode = selectedItem.Content.ToString();
                UpdateCalendar();
            }
        }
        
        private async void CreateEventButton_Click(object sender, RoutedEventArgs e)
        {
            await ShowCreateEventDialog();
        }
    }
    
    public class Event
    {
        public string Id { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public string Category { get; set; }
        public bool IsAllDay { get; set; }
        public string Location { get; set; }
        public List<string> Attendees { get; set; }
        public string Recurring { get; set; }
        public List<string> Reminders { get; set; }
        
        public string Time => IsAllDay ? "All Day" : $"{StartTime:HH:mm} - {EndTime:HH:mm}";
    }
}
