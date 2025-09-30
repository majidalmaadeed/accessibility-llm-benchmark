using System;
using System.ComponentModel;
using Xamarin.Forms;

namespace AccessibilityTest
{
    public partial class LowContrastWarningText : ContentPage, INotifyPropertyChanged
    {
        private bool _showWarning = true;
        private int _sessionTimeLeft = 5;
        private string _warningMessage = "Your session will expire in 5 minutes. Please save your work and extend your session to continue.";

        public bool ShowWarning
        {
            get => _showWarning;
            set
            {
                _showWarning = value;
                OnPropertyChanged(nameof(ShowWarning));
            }
        }

        public int SessionTimeLeft
        {
            get => _sessionTimeLeft;
            set
            {
                _sessionTimeLeft = value;
                OnPropertyChanged(nameof(SessionTimeLeft));
            }
        }

        public string WarningMessage
        {
            get => _warningMessage;
            set
            {
                _warningMessage = value;
                OnPropertyChanged(nameof(WarningMessage));
            }
        }

        public LowContrastWarningText()
        {
            InitializeComponent();
            BindingContext = this;
            
            // Start session countdown
            StartSessionTimer();
        }

        private void StartSessionTimer()
        {
            Device.StartTimer(TimeSpan.FromSeconds(1), () =>
            {
                if (SessionTimeLeft > 0)
                {
                    SessionTimeLeft--;
                    if (SessionTimeLeft <= 5)
                    {
                        ShowWarning = true;
                        WarningMessage = $"Your session will expire in {SessionTimeLeft} minutes. Please save your work and extend your session to continue.";
                    }
                }
                else
                {
                    // Session expired
                    ShowWarning = false;
                    ShowSessionExpiredDialog();
                    return false;
                }
                return true;
            });
        }

        private async void ShowSessionExpiredDialog()
        {
            await DisplayAlert("Session Expired", 
                "Your session has expired due to inactivity. Please log in again to continue.", 
                "Login Again");
        }

        private void OnExtendSessionClicked(object sender, EventArgs e)
        {
            SessionTimeLeft = 30; // Extend to 30 minutes
            ShowWarning = false;
            DisplayAlert("Session Extended", "Your session has been extended to 30 minutes.", "OK");
        }

        private void OnLogoutClicked(object sender, EventArgs e)
        {
            ShowWarning = false;
            DisplayAlert("Logged Out", "You have been logged out successfully.", "OK");
        }

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
