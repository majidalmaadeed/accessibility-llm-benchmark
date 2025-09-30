using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using Microsoft.UI.Xaml.Input;
using Microsoft.UI.Xaml.Media;
using System;
using System.Threading.Tasks;
{
    public sealed partial class FormValidationWithoutAssociationPage : Page
    {
        private bool _isSubmitting = false;
        public FormValidationWithoutAssociationPage()
        {
            this.InitializeComponent();
        }
        {
            // Should set up AutomationProperties.HelpedBy, AutomationProperties.IsRequiredForForm
            // Basic setup only
            UsernameInput.SetValue(Microsoft.UI.Xaml.Automation.AutomationProperties.AutomationIdProperty, "UsernameInput");
            UsernameInput.SetValue(Microsoft.UI.Xaml.Automation.AutomationProperties.NameProperty, "Username");
            PasswordInput.SetValue(Microsoft.UI.Xaml.Automation.AutomationProperties.AutomationIdProperty, "PasswordInput");
            PasswordInput.SetValue(Microsoft.UI.Xaml.Automation.AutomationProperties.NameProperty, "Password");
            LoginButton.SetValue(Microsoft.UI.Xaml.Automation.AutomationProperties.AutomationIdProperty, "LoginButton");
            LoginButton.SetValue(Microsoft.UI.Xaml.Automation.AutomationProperties.NameProperty, "Login");
        }
        private void OnUsernameChanged(object sender, TextChangedEventArgs e)
        {
            ClearFieldError("username");
        }
        private void OnPasswordChanged(object sender, RoutedEventArgs e)
        {
            ClearFieldError("password");
        }
        private void OnKeyDown(object sender, KeyRoutedEventArgs e)
        {
            if (e.Key == Windows.System.VirtualKey.Enter)
            {
                OnLoginClicked(sender, e);
            }
        }
        private async void OnLoginClicked(object sender, RoutedEventArgs e)
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
            await Task.Delay(2000);
            _isSubmitting = false;
            LoginButton.Content = "Login";
            LoginButton.IsEnabled = true;
            var dialog = new ContentDialog
            {
                Title = "Success",
                Content = "Login successful!",
                CloseButtonText = "OK",
                XamlRoot = this.XamlRoot
            };
            await dialog.ShowAsync();
        }
        private void ClearAllErrors()
        {
            UsernameError.Visibility = Visibility.Collapsed;
            PasswordError.Visibility = Visibility.Collapsed;
            GenericErrorPanel.Visibility = Visibility.Collapsed;
            // Reset field borders
            UsernameInput.BorderBrush = (Brush)Application.Current.Resources["ControlStrokeColorDefaultBrush"];
            PasswordInput.BorderBrush = (Brush)Application.Current.Resources["ControlStrokeColorDefaultBrush"];
        }
        private void ClearFieldError(string fieldName)
        {
            switch (fieldName.ToLower())
            {
                case "username":
                    UsernameError.Visibility = Visibility.Collapsed;
                    UsernameInput.BorderBrush = (Brush)Application.Current.Resources["ControlStrokeColorDefaultBrush"];
                    break;
                case "password":
                    PasswordError.Visibility = Visibility.Collapsed;
                    PasswordInput.BorderBrush = (Brush)Application.Current.Resources["ControlStrokeColorDefaultBrush"];
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
                    UsernameInput.BorderBrush = (Brush)Application.Current.Resources["SystemAccentColor"];
                    break;
                case "password":
                    PasswordError.Text = message;
                    PasswordError.Visibility = Visibility.Visible;
                    PasswordInput.BorderBrush = (Brush)Application.Current.Resources["SystemAccentColor"];
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
