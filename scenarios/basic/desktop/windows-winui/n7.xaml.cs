using System;
using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;

namespace AccessibilityTest
{
    public sealed partial class MissingLanguageAttribute : Page
    {
        public MissingLanguageAttribute()
        {
            this.InitializeComponent();
        }

        private void SignIn_Click(object sender, RoutedEventArgs e)
        {
            var dialog = new ContentDialog
            {
                Title = "Login Successful",
                Content = "Login successful! / Connexion réussie!",
                CloseButtonText = "OK"
            };
            dialog.XamlRoot = this.XamlRoot;
            dialog.ShowAsync();
        }

        private void ForgotPassword_Click(object sender, RoutedEventArgs e)
        {
            var dialog = new ContentDialog
            {
                Title = "Password Reset",
                Content = "Password reset instructions sent! / Instructions de réinitialisation envoyées!",
                CloseButtonText = "OK"
            };
            dialog.XamlRoot = this.XamlRoot;
            dialog.ShowAsync();
        }
    }
}
