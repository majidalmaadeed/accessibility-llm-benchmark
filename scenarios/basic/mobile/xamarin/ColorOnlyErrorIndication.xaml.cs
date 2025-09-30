using System;
using Xamarin.Forms;

namespace AccessibilityTest
{
    public partial class ColorOnlyErrorIndication : ContentPage
    {
        public ColorOnlyErrorIndication()
        {
            InitializeComponent();
        }

        private void OnFirstNameTextChanged(object sender, TextChangedEventArgs e)
        {
            // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
            if (string.IsNullOrWhiteSpace(e.NewTextValue))
            {
                FirstNameEntry.BorderColor = Color.Red;
            }
            else
            {
                FirstNameEntry.BorderColor = Color.Default;
            }
        }

        private void OnLastNameTextChanged(object sender, TextChangedEventArgs e)
        {
            // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
            if (string.IsNullOrWhiteSpace(e.NewTextValue))
            {
                LastNameEntry.BorderColor = Color.Red;
            }
            else
            {
                LastNameEntry.BorderColor = Color.Default;
            }
        }

        private void OnEmailTextChanged(object sender, TextChangedEventArgs e)
        {
            // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
            if (string.IsNullOrWhiteSpace(e.NewTextValue) || !e.NewTextValue.Contains("@"))
            {
                EmailEntry.BorderColor = Color.Red;
            }
            else
            {
                EmailEntry.BorderColor = Color.Default;
            }
        }

        private void OnPasswordTextChanged(object sender, TextChangedEventArgs e)
        {
            // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
            if (string.IsNullOrWhiteSpace(e.NewTextValue) || e.NewTextValue.Length < 8)
            {
                PasswordEntry.BorderColor = Color.Red;
            }
            else
            {
                PasswordEntry.BorderColor = Color.Default;
            }
        }

        private void OnConfirmPasswordTextChanged(object sender, TextChangedEventArgs e)
        {
            // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
            if (string.IsNullOrWhiteSpace(e.NewTextValue) || e.NewTextValue != PasswordEntry.Text)
            {
                ConfirmPasswordEntry.BorderColor = Color.Red;
            }
            else
            {
                ConfirmPasswordEntry.BorderColor = Color.Default;
            }
        }

        private void OnPhoneTextChanged(object sender, TextChangedEventArgs e)
        {
            // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
            if (!string.IsNullOrWhiteSpace(e.NewTextValue) && e.NewTextValue.Length < 10)
            {
                PhoneEntry.BorderColor = Color.Red;
            }
            else
            {
                PhoneEntry.BorderColor = Color.Default;
            }
        }

        private void OnDateOfBirthSelected(object sender, DateChangedEventArgs e)
        {
            // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
            if (e.NewDate > DateTime.Today.AddYears(-13))
            {
                DateOfBirthPicker.BackgroundColor = Color.Red;
            }
            else
            {
                DateOfBirthPicker.BackgroundColor = Color.Default;
            }
        }

        private void OnTermsCheckedChanged(object sender, CheckedChangedEventArgs e)
        {
            // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
            if (!e.Value)
            {
                TermsCheckBox.BackgroundColor = Color.Red;
            }
            else
            {
                TermsCheckBox.BackgroundColor = Color.Default;
            }
        }

        private void OnNewsletterCheckedChanged(object sender, CheckedChangedEventArgs e)
        {
            // This field is optional, no validation needed
        }

        private void OnCancelClicked(object sender, EventArgs e)
        {
            DisplayAlert("Cancel", "Registration cancelled.", "OK");
        }

        private void OnCreateAccountClicked(object sender, EventArgs e)
        {
            DisplayAlert("Create Account", "Account created successfully!", "OK");
        }
    }
}
