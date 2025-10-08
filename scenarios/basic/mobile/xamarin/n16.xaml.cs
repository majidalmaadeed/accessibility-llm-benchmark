using System;
using System.ComponentModel;
using Xamarin.Forms;

namespace AccessibilityTest
{
    public partial class SilentLoadingState : ContentPage, INotifyPropertyChanged
    {
        private bool _isLoading = true;
        private bool _isContentLoaded = false;

        public bool IsLoading
        {
            get => _isLoading;
            set
            {
                _isLoading = value;
                OnPropertyChanged(nameof(IsLoading));
            }
        }

        public bool IsContentLoaded
        {
            get => _isContentLoaded;
            set
            {
                _isContentLoaded = value;
                OnPropertyChanged(nameof(IsContentLoaded));
            }
        }

        public SilentLoadingState()
        {
            InitializeComponent();
            BindingContext = this;
            
            // Simulate loading process
            SimulateLoading();
        }

        private async void SimulateLoading()
        {
            // Simulate loading for 3 seconds
            await System.Threading.Tasks.Task.Delay(3000);
            
            IsLoading = false;
            IsContentLoaded = true;
        }

        private async void OnRefreshClicked(object sender, EventArgs e)
        {
            IsLoading = true;
            IsContentLoaded = false;
            
            // Simulate refresh loading
            await System.Threading.Tasks.Task.Delay(2000);
            
            IsLoading = false;
            IsContentLoaded = true;
        }

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
