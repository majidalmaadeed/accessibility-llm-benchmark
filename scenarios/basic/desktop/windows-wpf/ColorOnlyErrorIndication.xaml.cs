using System;
using System.Windows;
using System.Windows.Media;

namespace AccessibilityTest
{
    public partial class ColorOnlyErrorIndication : Window
    {
        public ColorOnlyErrorIndication()
        {
            InitializeComponent();
        }

        private void ValidateFirstName(object sender, RoutedEventArgs e)
        {
            var textBox = sender as System.Windows.Controls.TextBox;
            if (textBox != null)
            {
                if (string.IsNullOrWhiteSpace(textBox.Text))
                {
                    // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
                    textBox.BorderBrush = Brushes.Red;
                }
                else
                {
                    textBox.BorderBrush = Brushes.Gray;
                }
            }
        }

        private void ValidateLastName(object sender, RoutedEventArgs e)
        {
            var textBox = sender as System.Windows.Controls.TextBox;
            if (textBox != null)
            {
                if (string.IsNullOrWhiteSpace(textBox.Text))
                {
                    // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
                    textBox.BorderBrush = Brushes.Red;
                }
                else
                {
                    textBox.BorderBrush = Brushes.Gray;
                }
            }
        }

        private void ValidateEmail(object sender, RoutedEventArgs e)
        {
            var textBox = sender as System.Windows.Controls.TextBox;
            if (textBox != null)
            {
                if (string.IsNullOrWhiteSpace(textBox.Text) || !textBox.Text.Contains("@"))
                {
                    // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
                    textBox.BorderBrush = Brushes.Red;
                }
                else
                {
                    textBox.BorderBrush = Brushes.Gray;
                }
            }
        }

        private void ValidatePassword(object sender, RoutedEventArgs e)
        {
            var passwordBox = sender as System.Windows.Controls.PasswordBox;
            if (passwordBox != null)
            {
                if (string.IsNullOrWhiteSpace(passwordBox.Password) || passwordBox.Password.Length < 8)
                {
                    // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
                    passwordBox.BorderBrush = Brushes.Red;
                }
                else
                {
                    passwordBox.BorderBrush = Brushes.Gray;
                }
            }
        }

        private void ValidateConfirmPassword(object sender, RoutedEventArgs e)
        {
            var passwordBox = sender as System.Windows.Controls.PasswordBox;
            if (passwordBox != null)
            {
                if (string.IsNullOrWhiteSpace(passwordBox.Password) || passwordBox.Password != Password.Password)
                {
                    // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
                    passwordBox.BorderBrush = Brushes.Red;
                }
                else
                {
                    passwordBox.BorderBrush = Brushes.Gray;
                }
            }
        }

        private void ValidatePhone(object sender, RoutedEventArgs e)
        {
            var textBox = sender as System.Windows.Controls.TextBox;
            if (textBox != null)
            {
                if (!string.IsNullOrWhiteSpace(textBox.Text) && textBox.Text.Length < 10)
                {
                    // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
                    textBox.BorderBrush = Brushes.Red;
                }
                else
                {
                    textBox.BorderBrush = Brushes.Gray;
                }
            }
        }

        private void ValidateDateOfBirth(object sender, RoutedEventArgs e)
        {
            var datePicker = sender as System.Windows.Controls.DatePicker;
            if (datePicker != null)
            {
                if (datePicker.SelectedDate == null)
                {
                    // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
                    datePicker.BorderBrush = Brushes.Red;
                }
                else
                {
                    var age = DateTime.Now.Year - datePicker.SelectedDate.Value.Year;
                    if (age < 13)
                    {
                        // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
                        datePicker.BorderBrush = Brushes.Red;
                    }
                    else
                    {
                        datePicker.BorderBrush = Brushes.Gray;
                    }
                }
            }
        }

        private void ValidateTerms(object sender, RoutedEventArgs e)
        {
            var checkBox = sender as System.Windows.Controls.CheckBox;
            if (checkBox != null)
            {
                if (!checkBox.IsChecked.HasValue || !checkBox.IsChecked.Value)
                {
                    // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
                    checkBox.BorderBrush = Brushes.Red;
                }
                else
                {
                    checkBox.BorderBrush = Brushes.Gray;
                }
            }
        }

        private void Cancel_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Registration cancelled.");
        }

        private void CreateAccount_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Account created successfully!");
        }
    }
}
