using System;
using System.Windows;

namespace AccessibilityTest
{
    public partial class MissingLanguageAttribute : Window
    {
        public MissingLanguageAttribute()
        {
            InitializeComponent();
        }

        private void SignIn_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Login successful! / Connexion réussie!");
        }

        private void ForgotPassword_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Password reset instructions sent! / Instructions de réinitialisation envoyées!");
        }
    }
}
