using Microsoft.Maui.Controls;
{
    public partial class FormValidationWithoutAssociationPage : ContentPage
    {
        private bool _isSubmitting = false;
        public FormValidationWithoutAssociationPage()
        {
            InitializeComponent();
        }
        {
            // Basic setup only
            UsernameEntry.AutomationId = "UsernameInput";
            PasswordEntry.AutomationId = "PasswordInput";
            LoginButton.AutomationId = "LoginButton";
        }
        private void OnUsernameChanged(object sender, TextChangedEventArgs e)
        {
            ClearFieldError("username");
        }
        private void OnPasswordChanged(object sender, TextChangedEventArgs e)
        {
            ClearFieldError("password");
        }
        private async void OnLoginClicked(object sender, EventArgs e)
        {
            if (_isSubmitting) return;
            ClearAllErrors();
            string username = UsernameEntry.Text?.Trim() ?? "";
            string password = PasswordEntry.Text ?? "";
            bool hasErrors = false;
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
            LoginButton.Text = "Logging in...";
            LoginButton.IsEnabled = false;
            try
            {
                // Simulate API call
                await Task.Delay(2000);
                // Show success
                await DisplayAlert("Success", "Login successful!", "OK");
            }
            catch (Exception ex)
            {
                ShowGenericError("Login failed. Please try again.");
            }
            finally
            {
                _isSubmitting = false;
                LoginButton.Text = "Login";
                LoginButton.IsEnabled = true;
            }
        }
        private void ClearAllErrors()
        {
            UsernameError.IsVisible = false;
            PasswordError.IsVisible = false;
            GenericErrorFrame.IsVisible = false;
            // Reset field borders
            UsernameEntry.BackgroundColor = Colors.Transparent;
            PasswordEntry.BackgroundColor = Colors.Transparent;
        }
        private void ClearFieldError(string fieldName)
        {
            if (fieldName == "username")
            {
                UsernameError.IsVisible = false;
                UsernameEntry.BackgroundColor = Colors.Transparent;
            }
            else if (fieldName == "password")
            {
                PasswordError.IsVisible = false;
                PasswordEntry.BackgroundColor = Colors.Transparent;
            }
        }
        private void ShowFieldError(string fieldName, string message)
        {
            if (fieldName == "username")
            {
                UsernameError.Text = message;
                UsernameError.IsVisible = true;
                UsernameEntry.BackgroundColor = Color.FromRgba(220, 53, 69, 0.1);
            }
            else if (fieldName == "password")
            {
                PasswordError.Text = message;
                PasswordError.IsVisible = true;
                PasswordEntry.BackgroundColor = Color.FromRgba(220, 53, 69, 0.1);
            }
        }
        private void ShowGenericError(string message)
        {
            GenericErrorText.Text = message;
            GenericErrorFrame.IsVisible = true;
        }
    }
}
