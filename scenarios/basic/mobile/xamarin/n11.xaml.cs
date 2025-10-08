using System;
using Xamarin.Forms;

namespace AccessibilityTest
{
    public partial class MissingLanguageAttribute : ContentPage
    {
        public MissingLanguageAttribute()
        {
            InitializeComponent();
        }

        private void OnLoginClicked(object sender, EventArgs e)
        {
            DisplayAlert("Login", "Login successful! / Connexion réussie!", "OK");
        }

        private void OnForgotPasswordClicked(object sender, EventArgs e)
        {
            DisplayAlert("Forgot Password", "Password reset instructions sent! / Instructions de réinitialisation envoyées!", "OK");
        }
    }
}
