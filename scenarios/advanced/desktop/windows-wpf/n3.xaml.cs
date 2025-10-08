using System;
using System.Collections.Generic;
using System.Globalization;
using System.Windows;

namespace UIComponents
{
    public partial class CreateEventDialog : Window
    {
        public CreateEventDialog()
        {
            InitializeComponent();
            
            // Set default values
            StartDatePicker.SelectedDate = DateTime.Today;
            EndDatePicker.SelectedDate = DateTime.Today.AddDays(1);
        }
        
        public Event GetEvent()
        {
            if (string.IsNullOrWhiteSpace(TitleTextBox.Text))
            {
                MessageBox.Show("Please enter a title for the event.", "Validation Error", 
                              MessageBoxButton.OK, MessageBoxImage.Warning);
                return null;
            }
            
            var startTime = GetDateTimeFromPickers(StartDatePicker, StartTimeComboBox);
            var endTime = GetDateTimeFromPickers(EndDatePicker, EndTimeComboBox);
            
            if (AllDayCheckBox.IsChecked == true)
            {
                startTime = startTime.Date;
                endTime = endTime.Date.AddDays(1);
            }
            
            if (endTime <= startTime)
            {
                MessageBox.Show("End time must be after start time.", "Validation Error", 
                              MessageBoxButton.OK, MessageBoxImage.Warning);
                return null;
            }
            
            return new Event
            {
                Id = Guid.NewGuid().ToString(),
                Title = TitleTextBox.Text.Trim(),
                Description = DescriptionTextBox.Text.Trim(),
                StartTime = startTime,
                EndTime = endTime,
                Category = (CategoryComboBox.SelectedItem as System.Windows.Controls.ComboBoxItem)?.Content.ToString() ?? "personal",
                IsAllDay = AllDayCheckBox.IsChecked == true,
                Location = LocationTextBox.Text.Trim(),
                Attendees = new List<string>(),
                Recurring = "none",
                Reminders = new List<string>()
            };
        }
        
        private DateTime GetDateTimeFromPickers(System.Windows.Controls.DatePicker datePicker, 
                                             System.Windows.Controls.ComboBox timeComboBox)
        {
            var date = datePicker.SelectedDate ?? DateTime.Today;
            var timeText = (timeComboBox.SelectedItem as System.Windows.Controls.ComboBoxItem)?.Content.ToString() ?? "12:00 AM";
            
            if (DateTime.TryParseExact(timeText, "h:mm tt", CultureInfo.InvariantCulture, 
                                     DateTimeStyles.None, out DateTime time))
            {
                return date.Date.Add(time.TimeOfDay);
            }
            
            return date;
        }
        
        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            var evt = GetEvent();
            if (evt != null)
            {
                DialogResult = true;
                Close();
            }
        }
        
        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            DialogResult = false;
            Close();
        }
    }
}
