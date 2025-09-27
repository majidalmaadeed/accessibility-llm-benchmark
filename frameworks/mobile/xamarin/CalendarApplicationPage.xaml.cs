using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Windows.Input;
using Xamarin.Forms;

namespace AccessibilityBenchmark
{
    public partial class CalendarApplicationPage : ContentPage
    {
        private DateTime currentDate = DateTime.Now;
        private DateTime selectedDate = DateTime.Now;
        private string viewMode = "month";
        private List<Event> events = new List<Event>();
        private bool isLoading = false;

        public CalendarApplicationPage()
        {
            InitializeComponent();
            BindingContext = this;
            LoadEvents();
        }

        public string CurrentDateText => currentDate.ToString("dddd, MMMM dd, yyyy");
        public bool IsLoading
        {
            get => isLoading;
            set
            {
                isLoading = value;
                OnPropertyChanged();
            }
        }

        public ObservableCollection<CalendarDay> CalendarDays { get; set; } = new ObservableCollection<CalendarDay>();

        private async void LoadEvents()
        {
            IsLoading = true;
            
            // Simulate API call
            await System.Threading.Tasks.Task.Delay(1000);
            
            events = GenerateSampleEvents();
            UpdateCalendar();
            IsLoading = false;
        }

        private List<Event> GenerateSampleEvents()
        {
            return new List<Event>
            {
                new Event
                {
                    Id = "1",
                    Title = "Team Meeting",
                    Description = "Weekly team standup",
                    StartTime = new DateTime(2024, 1, 15, 10, 0, 0),
                    EndTime = new DateTime(2024, 1, 15, 11, 0, 0),
                    Category = "work",
                    IsAllDay = false,
                    Location = "Conference Room A",
                    Attendees = new List<string> { "john@example.com", "jane@example.com" },
                    Recurring = "weekly",
                    Reminders = new List<string> { "15min", "1hour" }
                },
                new Event
                {
                    Id = "2",
                    Title = "Doctor Appointment",
                    Description = "Annual checkup",
                    StartTime = new DateTime(2024, 1, 16, 14, 30, 0),
                    EndTime = new DateTime(2024, 1, 16, 15, 30, 0),
                    Category = "appointment",
                    IsAllDay = false,
                    Location = "Medical Center",
                    Attendees = new List<string>(),
                    Recurring = "none",
                    Reminders = new List<string> { "1day", "2hours" }
                },
                new Event
                {
                    Id = "3",
                    Title = "Project Deadline",
                    Description = "Submit final report",
                    StartTime = new DateTime(2024, 1, 20, 17, 0, 0),
                    EndTime = new DateTime(2024, 1, 20, 17, 0, 0),
                    Category = "work",
                    IsAllDay = true,
                    Location = "",
                    Attendees = new List<string>(),
                    Recurring = "none",
                    Reminders = new List<string> { "1week", "1day" }
                }
            };
        }

        private void UpdateCalendar()
        {
            CalendarDays.Clear();
            
            if (viewMode == "month")
            {
                UpdateMonthView();
            }
            else if (viewMode == "week")
            {
                UpdateWeekView();
            }
            else if (viewMode == "day")
            {
                UpdateDayView();
            }
        }

        private void UpdateMonthView()
        {
            var year = currentDate.Year;
            var month = currentDate.Month;
            var firstDay = new DateTime(year, month, 1);
            var lastDay = firstDay.AddMonths(1).AddDays(-1);
            var startingDayOfWeek = (int)firstDay.DayOfWeek;

            // Add empty cells for days before the first day of the month
            for (int i = 0; i < startingDayOfWeek; i++)
            {
                CalendarDays.Add(new CalendarDay { IsEmpty = true });
            }

            // Add days of the month
            for (int day = 1; day <= lastDay.Day; day++)
            {
                var date = new DateTime(year, month, day);
                var dayEvents = GetEventsForDate(date);
                var isToday = date.Date == DateTime.Now.Date;
                var isSelected = date.Date == selectedDate.Date;

                CalendarDays.Add(new CalendarDay
                {
                    Date = date,
                    DayNumber = day.ToString(),
                    IsToday = isToday,
                    IsSelected = isSelected,
                    HasEvents = dayEvents.Any(),
                    HasMultipleEvents = dayEvents.Count > 1,
                    EventColor = dayEvents.Any() ? GetCategoryColor(dayEvents.First().Category) : Color.Transparent,
                    DayBackgroundColor = isToday ? Color.FromHex("#E3F2FD") : 
                                        isSelected ? Color.FromHex("#007AFF") : Color.White,
                    DayTextColor = isSelected ? Color.White : 
                                  isToday ? Color.FromHex("#007AFF") : Color.Black,
                    DayFontAttributes = (isToday || isSelected) ? FontAttributes.Bold : FontAttributes.None
                });
            }
        }

        private void UpdateWeekView()
        {
            var startOfWeek = currentDate.AddDays(-(int)currentDate.DayOfWeek);
            
            for (int i = 0; i < 7; i++)
            {
                var date = startOfWeek.AddDays(i);
                var dayEvents = GetEventsForDate(date);
                var isToday = date.Date == DateTime.Now.Date;
                var isSelected = date.Date == selectedDate.Date;

                CalendarDays.Add(new CalendarDay
                {
                    Date = date,
                    DayNumber = date.Day.ToString(),
                    IsToday = isToday,
                    IsSelected = isSelected,
                    HasEvents = dayEvents.Any(),
                    HasMultipleEvents = dayEvents.Count > 1,
                    EventColor = dayEvents.Any() ? GetCategoryColor(dayEvents.First().Category) : Color.Transparent,
                    DayBackgroundColor = isToday ? Color.FromHex("#E3F2FD") : 
                                        isSelected ? Color.FromHex("#007AFF") : Color.White,
                    DayTextColor = isSelected ? Color.White : 
                                  isToday ? Color.FromHex("#007AFF") : Color.Black,
                    DayFontAttributes = (isToday || isSelected) ? FontAttributes.Bold : FontAttributes.None
                });
            }
        }

        private void UpdateDayView()
        {
            var dayEvents = GetEventsForDate(currentDate);
            var isToday = currentDate.Date == DateTime.Now.Date;

            CalendarDays.Add(new CalendarDay
            {
                Date = currentDate,
                DayNumber = currentDate.Day.ToString(),
                IsToday = isToday,
                IsSelected = true,
                HasEvents = dayEvents.Any(),
                HasMultipleEvents = dayEvents.Count > 1,
                EventColor = dayEvents.Any() ? GetCategoryColor(dayEvents.First().Category) : Color.Transparent,
                DayBackgroundColor = isToday ? Color.FromHex("#E3F2FD") : Color.White,
                DayTextColor = isToday ? Color.FromHex("#007AFF") : Color.Black,
                DayFontAttributes = FontAttributes.Bold
            });
        }

        private List<Event> GetEventsForDate(DateTime date)
        {
            return events.Where(e => e.StartTime.Date == date.Date).ToList();
        }

        private Color GetCategoryColor(string category)
        {
            switch (category)
            {
                case "personal": return Color.Green;
                case "work": return Color.Blue;
                case "meeting": return Color.Orange;
                case "appointment": return Color.Purple;
                case "reminder": return Color.Red;
                default: return Color.Blue;
            }
        }

        private void OnTodayClicked(object sender, EventArgs e)
        {
            currentDate = DateTime.Now;
            selectedDate = DateTime.Now;
            OnPropertyChanged(nameof(CurrentDateText));
            UpdateCalendar();
        }

        private void OnCreateEventClicked(object sender, EventArgs e)
        {
            ShowEventModal();
        }

        private void OnViewModeChanged(object sender, EventArgs e)
        {
            if (sender is Button button && button.CommandParameter is string mode)
            {
                viewMode = mode;
                UpdateCalendar();
            }
        }

        private void OnPreviousClicked(object sender, EventArgs e)
        {
            if (viewMode == "month")
            {
                currentDate = currentDate.AddMonths(-1);
            }
            else if (viewMode == "week")
            {
                currentDate = currentDate.AddDays(-7);
            }
            else
            {
                currentDate = currentDate.AddDays(-1);
            }
            
            OnPropertyChanged(nameof(CurrentDateText));
            UpdateCalendar();
        }

        private void OnNextClicked(object sender, EventArgs e)
        {
            if (viewMode == "month")
            {
                currentDate = currentDate.AddMonths(1);
            }
            else if (viewMode == "week")
            {
                currentDate = currentDate.AddDays(7);
            }
            else
            {
                currentDate = currentDate.AddDays(1);
            }
            
            OnPropertyChanged(nameof(CurrentDateText));
            UpdateCalendar();
        }

        private void OnDayClicked(object sender, EventArgs e)
        {
            if (sender is Button button && button.CommandParameter is DateTime date)
            {
                selectedDate = date;
                var dayEvents = GetEventsForDate(date);
                
                if (dayEvents.Any())
                {
                    ShowEventDetails(dayEvents.First());
                }
                else
                {
                    ShowEventModal();
                }
                
                UpdateCalendar();
            }
        }

        private async void ShowEventModal()
        {
            var event = new Event
            {
                StartTime = selectedDate,
                EndTime = selectedDate.AddHours(1),
                Category = "personal",
                IsAllDay = false
            };

            var result = await Navigation.PushModalAsync(new EventModalPage(event));
            if (result)
            {
                LoadEvents();
            }
        }

        private async void ShowEventDetails(Event event)
        {
            var result = await Navigation.PushModalAsync(new EventDetailsPage(event));
            if (result)
            {
                LoadEvents();
            }
        }

        public event PropertyChangedEventHandler PropertyChanged;
        protected virtual void OnPropertyChanged([System.Runtime.CompilerServices.CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }

    public class CalendarDay : INotifyPropertyChanged
    {
        public DateTime Date { get; set; }
        public string DayNumber { get; set; }
        public bool IsEmpty { get; set; }
        public bool IsToday { get; set; }
        public bool IsSelected { get; set; }
        public bool HasEvents { get; set; }
        public bool HasMultipleEvents { get; set; }
        public Color EventColor { get; set; }
        public Color DayBackgroundColor { get; set; }
        public Color DayTextColor { get; set; }
        public FontAttributes DayFontAttributes { get; set; }

        public event PropertyChangedEventHandler PropertyChanged;
        protected virtual void OnPropertyChanged([System.Runtime.CompilerServices.CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
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
    }
}
