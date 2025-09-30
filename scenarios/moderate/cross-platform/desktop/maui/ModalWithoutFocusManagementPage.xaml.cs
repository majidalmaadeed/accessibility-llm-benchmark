using Microsoft.Maui.Controls;
{
    {
        private bool _isModalOpen = false;
        {
            InitializeComponent();
        }
        {
            // Basic setup only
            OpenModalButton.AutomationId = "OpenModalButton";
        }
        private async void OnOpenModalClicked(object sender, EventArgs e)
        {
            if (_isModalOpen) return;
            // Show modal
            await ShowModal();
        }
        private async Task ShowModal()
        {
            var modal = new ContentPage
            {
                Title = "Settings",
                BackgroundColor = Colors.White
            };
            var modalLayout = new StackLayout
            {
                Padding = new Thickness(30),
                Spacing = 20
            };
            // Modal Header
            var headerLayout = new StackLayout
            {
                Orientation = StackOrientation.Horizontal,
                HorizontalOptions = LayoutOptions.FillAndExpand
            };
            {
                Text = "Settings",
                FontSize = 20,
                FontAttributes = FontAttributes.Bold,
                TextColor = Colors.Black,
                HorizontalOptions = LayoutOptions.StartAndExpand
            };
            var closeButton = new Button
            {
                Text = "×",
                BackgroundColor = Colors.Transparent,
                TextColor = Colors.Gray,
                FontSize = 16,
                FontAttributes = FontAttributes.Bold,
                WidthRequest = 30,
                HeightRequest = 30,
                CornerRadius = 15
            };
            closeButton.Clicked += async (s, e) => await CloseModal();
            headerLayout.Children.Add(closeButton);
            // Settings Form
            var settingsLayout = new StackLayout { Spacing = 20 };
            // Theme Setting
            var themeLayout = new StackLayout { Spacing = 8 };
            { 
                Text = "Theme:", 
                FontAttributes = FontAttributes.Bold, 
                TextColor = Colors.Black 
            });
            var themePicker = new Picker
            {
                ItemsSource = new[] { "Light", "Dark", "Auto" },
                SelectedIndex = 0
            };
            themeLayout.Children.Add(themePicker);
            // Language Setting
            var languageLayout = new StackLayout { Spacing = 8 };
            { 
                Text = "Language:", 
                FontAttributes = FontAttributes.Bold, 
                TextColor = Colors.Black 
            });
            var languagePicker = new Picker
            {
                ItemsSource = new[] { "English", "Spanish", "French" },
                SelectedIndex = 0
            };
            languageLayout.Children.Add(languagePicker);
            // Notifications Setting
            var notificationsLayout = new StackLayout { Spacing = 8 };
            { 
                Text = "Email Notifications:", 
                FontAttributes = FontAttributes.Bold, 
                TextColor = Colors.Black 
            });
            var notificationsPicker = new Picker
            {
                ItemsSource = new[] { "All", "Important Only", "None" },
                SelectedIndex = 0
            };
            notificationsLayout.Children.Add(notificationsPicker);
            settingsLayout.Children.Add(themeLayout);
            settingsLayout.Children.Add(languageLayout);
            settingsLayout.Children.Add(notificationsLayout);
            // Modal Actions
            var actionsLayout = new StackLayout
            {
                Orientation = StackOrientation.Horizontal,
                HorizontalOptions = LayoutOptions.End,
                Spacing = 10
            };
            var cancelButton = new Button
            {
                Text = "Cancel",
                BackgroundColor = Color.FromRgb(108, 117, 125),
                TextColor = Colors.White,
                FontSize = 14,
                FontAttributes = FontAttributes.Bold,
                CornerRadius = 4,
                Padding = new Thickness(20, 10)
            };
            cancelButton.Clicked += async (s, e) => await CloseModal();
            var saveButton = new Button
            {
                Text = "Save Settings",
                BackgroundColor = Color.FromRgb(0, 123, 255),
                TextColor = Colors.White,
                FontSize = 14,
                FontAttributes = FontAttributes.Bold,
                CornerRadius = 4,
                Padding = new Thickness(20, 10)
            };
            saveButton.Clicked += async (s, e) => await OnSaveClicked();
            actionsLayout.Children.Add(cancelButton);
            actionsLayout.Children.Add(saveButton);
            modalLayout.Children.Add(headerLayout);
            modalLayout.Children.Add(settingsLayout);
            modalLayout.Children.Add(new BoxView { HeightRequest = 1, Color = Colors.LightGray });
            modalLayout.Children.Add(actionsLayout);
            modal.Content = modalLayout;
            // Show modal
            _isModalOpen = true;
            // Should handle Escape key to close modal
        }
        private async Task CloseModal()
        {
            if (!_isModalOpen) return;
            // Hide modal
            _isModalOpen = false;
            {
            }
            else
            {
            }
        }
        private async Task OnSaveClicked()
        {
            // Simulate saving settings
            await DisplayAlert("Success", "Settings saved successfully!", "OK");
            await CloseModal();
        }
        // Should implement methods to:
    }
}
