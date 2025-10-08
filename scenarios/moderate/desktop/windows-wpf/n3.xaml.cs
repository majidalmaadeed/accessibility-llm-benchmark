using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media;
{
    public partial class FormValidationWithoutAssociationWindow : Window
    {
        private bool _isSubmitting = false;
        public FormValidationWithoutAssociationWindow()
        {
            InitializeComponent();
        }
        {
            // Should set up AutomationProperties.HelpedBy, AutomationProperties.IsRequiredForForm
            // Basic setup only
            UsernameInput.SetValue(AutomationProperties.AutomationIdProperty, "UsernameInput");
            UsernameInput.SetValue(AutomationProperties.NameProperty, "Username");
            PasswordInput.SetValue(AutomationProperties.AutomationIdProperty, "PasswordInput");
            PasswordInput.SetValue(AutomationProperties.NameProperty, "Password");
            LoginButton.SetValue(AutomationProperties.AutomationIdProperty, "LoginButton");
            LoginButton.SetValue(AutomationProperties.NameProperty, "Login");
        }
        private void OnUsernameChanged(object sender, TextChangedEventArgs e)
        {
            ClearFieldError("username");
        }
        private void OnPasswordChanged(object sender, RoutedEventArgs e)
        {
            ClearFieldError("password");
        }
        private void OnKeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                OnLoginClicked(sender, e);
            }
        }
        private void OnLoginClicked(object sender, RoutedEventArgs e)
        {
            if (_isSubmitting) return;
            ClearAllErrors();
            var username = UsernameInput.Text.Trim();
            var password = PasswordInput.Password;
            var hasErrors = false;
            // Validate username
            if (string.IsNullOrEmpty(username))
            {
                ShowFieldError("username", "Username is required");
                hasErrors = true;
            }
            else if (username.Length < 3)
            {
                ShowFieldError("username", "Username must be at least 3 characters");
                hasErrors = true;
            }
            // Validate password
            if (string.IsNullOrEmpty(password))
            {
                ShowFieldError("password", "Password is required");
                hasErrors = true;
            }
            else if (password.Length < 8)
            {
                ShowFieldError("password", "Password must be at least 8 characters");
                hasErrors = true;
            }
            if (hasErrors)
            {
                // Show generic error message - NOT ASSOCIATED WITH SPECIFIC FIELDS
                ShowGenericError("Please fill in all required fields.");
                return;
            }
            // Simulate login process
            _isSubmitting = true;
            LoginButton.Content = "Logging in...";
            LoginButton.IsEnabled = false;
            // Simulate API call
            System.Threading.Tasks.Task.Delay(2000).ContinueWith(_ =>
            {
                Dispatcher.Invoke(() =>
                {
                    _isSubmitting = false;
                    LoginButton.Content = "Login";
                    LoginButton.IsEnabled = true;
                    MessageBox.Show("Login successful!", "Success", MessageBoxButton.OK, MessageBoxImage.Information);
                });
            });
        }
        private void ClearAllErrors()
        {
            UsernameError.Visibility = Visibility.Collapsed;
            PasswordError.Visibility = Visibility.Collapsed;
            GenericErrorPanel.Visibility = Visibility.Collapsed;
            // Reset field borders
            UsernameInput.BorderBrush = new SolidColorBrush(Color.FromRgb(221, 221, 221));
            PasswordInput.BorderBrush = new SolidColorBrush(Color.FromRgb(221, 221, 221));
        }
        private void ClearFieldError(string fieldName)
        {
            switch (fieldName.ToLower())
            {
                case "username":
                    UsernameError.Visibility = Visibility.Collapsed;
                    UsernameInput.BorderBrush = new SolidColorBrush(Color.FromRgb(221, 221, 221));
                    break;
                case "password":
                    PasswordError.Visibility = Visibility.Collapsed;
                    PasswordInput.BorderBrush = new SolidColorBrush(Color.FromRgb(221, 221, 221));
                    break;
            }
        }
        private void ShowFieldError(string fieldName, string message)
        {
            switch (fieldName.ToLower())
            {
                case "username":
                    UsernameError.Text = message;
                    UsernameError.Visibility = Visibility.Visible;
                    UsernameInput.BorderBrush = new SolidColorBrush(Color.FromRgb(220, 53, 69));
                    break;
                case "password":
                    PasswordError.Text = message;
                    PasswordError.Visibility = Visibility.Visible;
                    PasswordInput.BorderBrush = new SolidColorBrush(Color.FromRgb(220, 53, 69));
                    break;
            }
        }
        private void ShowGenericError(string message)
        {
            GenericErrorMessage.Text = message;
            GenericErrorPanel.Visibility = Visibility.Visible;
        }
    }
}
