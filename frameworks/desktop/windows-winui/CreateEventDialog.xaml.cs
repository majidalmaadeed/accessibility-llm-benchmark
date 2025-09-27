using System;
using System.Collections.Generic;
using System.Globalization;
using Microsoft.UI.Xaml.Controls;

namespace AccessibilityBenchmark
{
    public sealed partial class CreateEventDialog : ContentDialog
    {
        public CreateEventDialog()
        {
            this.InitializeComponent();
            
            // Set default values
            StartDatePicker.Date = DateTime.Today;
            EndDatePicker.Date = DateTime.Today.AddDays(1);
        }
        
        public Event GetEvent()
        {
            if (string.IsNullOrWhiteSpace(TitleTextBox.Text))
            {
                return null;
            }
            
            var startTime = GetDateTimeFromPickers(StartDatePicker, StartTimeComboBox);
            var endTime = GetDateTimeFromPickers(EndDatePicker, EndTimeComboBox);
            
            if (AllDayCheckBox.IsChecked == true)
            {
                startTime = startTime.Date;
                endTime = endTime.Date.AddDays(1);
            }
            
            return new Event
            {
                Id = Guid.NewGuid().ToString(),
                Title = TitleTextBox.Text.Trim(),
                Description = DescriptionTextBox.Text.Trim(),
                StartTime = startTime,
                EndTime = endTime,
                Category = (CategoryComboBox.SelectedItem as ComboBoxItem)?.Content.ToString() ?? "personal",
                IsAllDay = AllDayCheckBox.IsChecked == true,
                Location = LocationTextBox.Text.Trim(),
                Attendees = new List<string>(),
                Recurring = "none",
                Reminders = new List<string>()
            };
        }
        
        private DateTime GetDateTimeFromPickers(DatePicker datePicker, ComboBox timeComboBox)
        {
            var date = datePicker.Date.DateTime;
            var timeText = (timeComboBox.SelectedItem as ComboBoxItem)?.Content.ToString() ?? "12:00 AM";
            
            if (DateTime.TryParseExact(timeText, "h:mm tt", CultureInfo.InvariantCulture, 
                                     DateTimeStyles.None, out DateTime time))
            {
                return date.Date.Add(time.TimeOfDay);
            }
            
            return date;
        }
    }
}
