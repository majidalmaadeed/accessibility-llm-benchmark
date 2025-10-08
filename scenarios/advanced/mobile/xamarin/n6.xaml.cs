using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Xamarin.Forms;

namespace UIComponents
{
    public partial class MultiStepWizardPage : ContentPage
    {
        private int _currentStep = 1;
        private const int TotalSteps = 5;
        private bool _isSubmitting = false;

        private Dictionary<string, object> _formData = new Dictionary<string, object>
        {
            ["firstName"] = "",
            ["lastName"] = "",
            ["email"] = "",
            ["phone"] = "",
            ["dateOfBirth"] = "",
            ["street"] = "",
            ["city"] = "",
            ["state"] = "",
            ["zipCode"] = "",
            ["country"] = "",
            ["newsletter"] = false,
            ["notifications"] = true,
            ["theme"] = "light",
            ["language"] = "en",
            ["cardNumber"] = "",
            ["expiryDate"] = "",
            ["cvv"] = "",
            ["cardholderName"] = "",
            ["termsAccepted"] = false,
            ["privacyAccepted"] = false
        };

        private Dictionary<string, string> _errors = new Dictionary<string, string>();

        public MultiStepWizardPage()
        {
            InitializeComponent();
            BuildStepIndicator();
            LoadStepContent();
        }

        private void BuildStepIndicator()
        {
            StepIndicatorContainer.Children.Clear();

            var steps = new[]
            {
                new { Id = 1, Title = "Personal Info", Icon = "👤" },
                new { Id = 2, Title = "Address", Icon = "📍" },
                new { Id = 3, Title = "Preferences", Icon = "⚙️" },
                new { Id = 4, Title = "Payment", Icon = "💳" },
                new { Id = 5, Title = "Review", Icon = "✅" }
            };

            for (int i = 0; i < steps.Length; i++)
            {
                var step = steps[i];
                var isActive = _currentStep >= step.Id;
                var isCurrent = _currentStep == step.Id;

                var stepContainer = new StackLayout
                {
                    HorizontalOptions = LayoutOptions.Center,
                    VerticalOptions = LayoutOptions.Center,
                    WidthRequest = 80
                };

                var stepCircle = new Frame
                {
                    WidthRequest = 40,
                    HeightRequest = 40,
                    CornerRadius = 20,
                    BackgroundColor = isActive ? Color.FromHex("#007AFF") : Color.FromHex("#E0E0E0"),
                    HasShadow = false,
                    Padding = 0
                };

                var stepIcon = new Label
                {
                    Text = step.Icon,
                    FontSize = 20,
                    TextColor = isActive ? Color.White : Color.FromHex("#666"),
                    HorizontalOptions = LayoutOptions.Center,
                    VerticalOptions = LayoutOptions.Center
                };

                stepCircle.Content = stepIcon;

                var stepTitle = new Label
                {
                    Text = step.Title,
                    FontSize = 12,
                    TextColor = isActive ? Color.FromHex("#007AFF") : Color.FromHex("#666"),
                    HorizontalOptions = LayoutOptions.Center,
                    HorizontalTextAlignment = TextAlignment.Center,
                    FontAttributes = isActive ? FontAttributes.Bold : FontAttributes.None
                };

                stepContainer.Children.Add(stepCircle);
                stepContainer.Children.Add(new BoxView { HeightRequest = 8 });
                stepContainer.Children.Add(stepTitle);

                StepIndicatorContainer.Children.Add(stepContainer);

                // Add connector line (except for last step)
                if (i < steps.Length - 1)
                {
                    var connector = new BoxView
                    {
                        HeightRequest = 2,
                        WidthRequest = 40,
                        BackgroundColor = isActive ? Color.FromHex("#007AFF") : Color.FromHex("#E0E0E0"),
                        VerticalOptions = LayoutOptions.Center,
                        Margin = new Thickness(0, -20, 0, 0)
                    };
                    StepIndicatorContainer.Children.Add(connector);
                }
            }
        }

        private void LoadStepContent()
        {
            StepContentContainer.Children.Clear();

            switch (_currentStep)
            {
                case 1:
                    LoadPersonalInfoStep();
                    break;
                case 2:
                    LoadAddressInfoStep();
                    break;
                case 3:
                    LoadPreferencesStep();
                    break;
                case 4:
                    LoadPaymentInfoStep();
                    break;
                case 5:
                    LoadReviewStep();
                    break;
            }

            UpdateNavigationButtons();
        }

        private void LoadPersonalInfoStep()
        {
            var title = new Label
            {
                Text = "Personal Information",
                FontSize = 24,
                FontAttributes = FontAttributes.Bold,
                Margin = new Thickness(0, 0, 0, 8)
            };

            var subtitle = new Label
            {
                Text = "Please provide your basic personal details.",
                FontSize = 16,
                TextColor = Color.FromHex("#666"),
                Margin = new Thickness(0, 0, 0, 24)
            };

            var firstNameEntry = CreateEntry("First Name", "firstName", "Enter your first name", true);
            var lastNameEntry = CreateEntry("Last Name", "lastName", "Enter your last name", true);
            var emailEntry = CreateEntry("Email Address", "email", "Enter your email", true, Keyboard.Email);
            var phoneEntry = CreateEntry("Phone Number", "phone", "Enter your phone number", true, Keyboard.Telephone);
            var dobEntry = CreateEntry("Date of Birth", "dateOfBirth", "MM/DD/YYYY", false);

            StepContentContainer.Children.Add(title);
            StepContentContainer.Children.Add(subtitle);
            StepContentContainer.Children.Add(firstNameEntry);
            StepContentContainer.Children.Add(lastNameEntry);
            StepContentContainer.Children.Add(emailEntry);
            StepContentContainer.Children.Add(phoneEntry);
            StepContentContainer.Children.Add(dobEntry);
        }

        private void LoadAddressInfoStep()
        {
            var title = new Label
            {
                Text = "Address Information",
                FontSize = 24,
                FontAttributes = FontAttributes.Bold,
                Margin = new Thickness(0, 0, 0, 8)
            };

            var subtitle = new Label
            {
                Text = "Please provide your current address details.",
                FontSize = 16,
                TextColor = Color.FromHex("#666"),
                Margin = new Thickness(0, 0, 0, 24)
            };

            var streetEntry = CreateEntry("Street Address", "street", "Enter your street address", true);
            var cityEntry = CreateEntry("City", "city", "City", true);
            var stateEntry = CreateEntry("State", "state", "State", true);
            var zipEntry = CreateEntry("ZIP Code", "zipCode", "ZIP Code", true, Keyboard.Numeric);
            var countryEntry = CreateEntry("Country", "country", "Country", false);

            var cityStateGrid = new Grid();
            cityStateGrid.ColumnDefinitions.Add(new ColumnDefinition { Width = new GridLength(1, GridUnitType.Star) });
            cityStateGrid.ColumnDefinitions.Add(new ColumnDefinition { Width = new GridLength(1, GridUnitType.Star) });
            Grid.SetColumn(cityEntry, 0);
            Grid.SetColumn(stateEntry, 1);
            cityStateGrid.Children.Add(cityEntry);
            cityStateGrid.Children.Add(stateEntry);

            var zipCountryGrid = new Grid();
            zipCountryGrid.ColumnDefinitions.Add(new ColumnDefinition { Width = new GridLength(1, GridUnitType.Star) });
            zipCountryGrid.ColumnDefinitions.Add(new ColumnDefinition { Width = new GridLength(1, GridUnitType.Star) });
            Grid.SetColumn(zipEntry, 0);
            Grid.SetColumn(countryEntry, 1);
            zipCountryGrid.Children.Add(zipEntry);
            zipCountryGrid.Children.Add(countryEntry);

            StepContentContainer.Children.Add(title);
            StepContentContainer.Children.Add(subtitle);
            StepContentContainer.Children.Add(streetEntry);
            StepContentContainer.Children.Add(cityStateGrid);
            StepContentContainer.Children.Add(zipCountryGrid);
        }

        private void LoadPreferencesStep()
        {
            var title = new Label
            {
                Text = "Preferences",
                FontSize = 24,
                FontAttributes = FontAttributes.Bold,
                Margin = new Thickness(0, 0, 0, 8)
            };

            var subtitle = new Label
            {
                Text = "Customize your experience with these optional settings.",
                FontSize = 16,
                TextColor = Color.FromHex("#666"),
                Margin = new Thickness(0, 0, 0, 24)
            };

            var newsletterSwitch = CreateSwitch("Newsletter Subscription", "Receive updates and news via email", "newsletter");
            var notificationsSwitch = CreateSwitch("Push Notifications", "Get notified about important updates", "notifications");

            var themeLabel = new Label
            {
                Text = "Theme Preference",
                FontSize = 16,
                FontAttributes = FontAttributes.Bold,
                Margin = new Thickness(0, 24, 0, 12)
            };

            var themePicker = new Picker
            {
                Title = "Select Theme",
                SelectedIndex = GetThemeIndex()
            };
            themePicker.Items.Add("Light");
            themePicker.Items.Add("Dark");
            themePicker.Items.Add("Auto");
            themePicker.SelectedIndexChanged += (s, e) => _formData["theme"] = themePicker.Items[themePicker.SelectedIndex].ToLower();

            var languageLabel = new Label
            {
                Text = "Language",
                FontSize = 16,
                FontAttributes = FontAttributes.Bold,
                Margin = new Thickness(0, 24, 0, 12)
            };

            var languagePicker = new Picker
            {
                Title = "Select Language",
                SelectedIndex = GetLanguageIndex()
            };
            languagePicker.Items.Add("English");
            languagePicker.Items.Add("Spanish");
            languagePicker.Items.Add("French");
            languagePicker.SelectedIndexChanged += (s, e) => _formData["language"] = GetLanguageCode(languagePicker.Items[languagePicker.SelectedIndex]);

            StepContentContainer.Children.Add(title);
            StepContentContainer.Children.Add(subtitle);
            StepContentContainer.Children.Add(newsletterSwitch);
            StepContentContainer.Children.Add(notificationsSwitch);
            StepContentContainer.Children.Add(themeLabel);
            StepContentContainer.Children.Add(themePicker);
            StepContentContainer.Children.Add(languageLabel);
            StepContentContainer.Children.Add(languagePicker);
        }

        private void LoadPaymentInfoStep()
        {
            var title = new Label
            {
                Text = "Payment Information",
                FontSize = 24,
                FontAttributes = FontAttributes.Bold,
                Margin = new Thickness(0, 0, 0, 8)
            };

            var subtitle = new Label
            {
                Text = "Enter your payment details securely.",
                FontSize = 16,
                TextColor = Color.FromHex("#666"),
                Margin = new Thickness(0, 0, 0, 24)
            };

            var cardholderEntry = CreateEntry("Cardholder Name", "cardholderName", "Name on card", true);
            var cardNumberEntry = CreateEntry("Card Number", "cardNumber", "1234 5678 9012 3456", true, Keyboard.Numeric);
            var expiryEntry = CreateEntry("Expiry Date", "expiryDate", "MM/YY", true, Keyboard.Numeric);
            var cvvEntry = CreateEntry("CVV", "cvv", "123", true, Keyboard.Numeric, true);

            var expiryCvvGrid = new Grid();
            expiryCvvGrid.ColumnDefinitions.Add(new ColumnDefinition { Width = new GridLength(1, GridUnitType.Star) });
            expiryCvvGrid.ColumnDefinitions.Add(new ColumnDefinition { Width = new GridLength(1, GridUnitType.Star) });
            Grid.SetColumn(expiryEntry, 0);
            Grid.SetColumn(cvvEntry, 1);
            expiryCvvGrid.Children.Add(expiryEntry);
            expiryCvvGrid.Children.Add(cvvEntry);

            StepContentContainer.Children.Add(title);
            StepContentContainer.Children.Add(subtitle);
            StepContentContainer.Children.Add(cardholderEntry);
            StepContentContainer.Children.Add(cardNumberEntry);
            StepContentContainer.Children.Add(expiryCvvGrid);
        }

        private void LoadReviewStep()
        {
            var title = new Label
            {
                Text = "Review & Confirm",
                FontSize = 24,
                FontAttributes = FontAttributes.Bold,
                Margin = new Thickness(0, 0, 0, 8)
            };

            var subtitle = new Label
            {
                Text = "Please review your information and accept the terms.",
                FontSize = 16,
                TextColor = Color.FromHex("#666"),
                Margin = new Thickness(0, 0, 0, 24)
            };

            var personalInfoCard = CreateReviewCard("Personal Information", new[]
            {
                ("Name", $"{_formData["firstName"]} {_formData["lastName"]}"),
                ("Email", _formData["email"].ToString()),
                ("Phone", _formData["phone"].ToString())
            });

            var addressInfoCard = CreateReviewCard("Address", new[]
            {
                ("Address", _formData["street"].ToString()),
                ("City, State ZIP", $"{_formData["city"]}, {_formData["state"]} {_formData["zipCode"]}")
            });

            var preferencesCard = CreateReviewCard("Preferences", new[]
            {
                ("Newsletter", (bool)_formData["newsletter"] ? "Yes" : "No"),
                ("Notifications", (bool)_formData["notifications"] ? "Enabled" : "Disabled"),
                ("Theme", _formData["theme"].ToString().ToUpper())
            });

            var termsCheckbox = CreateCheckbox("I accept the Terms and Conditions", "termsAccepted");
            var privacyCheckbox = CreateCheckbox("I accept the Privacy Policy", "privacyAccepted");

            StepContentContainer.Children.Add(title);
            StepContentContainer.Children.Add(subtitle);
            StepContentContainer.Children.Add(personalInfoCard);
            StepContentContainer.Children.Add(addressInfoCard);
            StepContentContainer.Children.Add(preferencesCard);
            StepContentContainer.Children.Add(termsCheckbox);
            StepContentContainer.Children.Add(privacyCheckbox);
        }

        private StackLayout CreateEntry(string label, string field, string placeholder, bool isRequired, Keyboard keyboard = null, bool isPassword = false)
        {
            var container = new StackLayout { Margin = new Thickness(0, 0, 0, 20) };

            var labelControl = new Label
            {
                Text = label + (isRequired ? " *" : ""),
                FontSize = 16,
                FontAttributes = FontAttributes.Bold
            };

            var entry = new Entry
            {
                Placeholder = placeholder,
                Text = _formData[field].ToString(),
                Keyboard = keyboard ?? Keyboard.Default,
                IsPassword = isPassword
            };
            entry.TextChanged += (s, e) => _formData[field] = e.NewTextValue;

            var errorLabel = new Label
            {
                Text = _errors.ContainsKey(field) ? _errors[field] : "",
                TextColor = Color.Red,
                FontSize = 12,
                IsVisible = _errors.ContainsKey(field)
            };

            container.Children.Add(labelControl);
            container.Children.Add(entry);
            container.Children.Add(errorLabel);

            return container;
        }

        private StackLayout CreateSwitch(string title, string subtitle, string field)
        {
            var container = new StackLayout
            {
                Orientation = StackOrientation.Horizontal,
                Padding = new Thickness(0, 16),
                Children = {
                    new StackLayout
                    {
                        VerticalOptions = LayoutOptions.Center,
                        HorizontalOptions = LayoutOptions.FillAndExpand,
                        Children = {
                            new Label
                            {
                                Text = title,
                                FontSize = 16,
                                FontAttributes = FontAttributes.Bold
                            },
                            new Label
                            {
                                Text = subtitle,
                                FontSize = 14,
                                TextColor = Color.FromHex("#666")
                            }
                        }
                    },
                    new Switch
                    {
                        IsToggled = (bool)_formData[field],
                        Toggled = (s, e) => _formData[field] = e.Value
                    }
                }
            };

            return container;
        }

        private StackLayout CreateCheckbox(string text, string field)
        {
            var container = new StackLayout
            {
                Orientation = StackOrientation.Horizontal,
                Margin = new Thickness(0, 16, 0, 0)
            };

            var checkbox = new CheckBox
            {
                IsChecked = (bool)_formData[field],
                VerticalOptions = LayoutOptions.Start
            };
            checkbox.CheckedChanged += (s, e) => _formData[field] = e.Value;

            var label = new Label
            {
                Text = text,
                FontSize = 16,
                VerticalOptions = LayoutOptions.Center,
                HorizontalOptions = LayoutOptions.FillAndExpand
            };

            container.Children.Add(checkbox);
            container.Children.Add(label);

            return container;
        }

        private Frame CreateReviewCard(string title, (string label, string value)[] items)
        {
            var card = new Frame
            {
                BackgroundColor = Color.White,
                HasShadow = true,
                CornerRadius = 8,
                Padding = new Thickness(16),
                Margin = new Thickness(0, 0, 0, 16)
            };

            var content = new StackLayout();

            var titleLabel = new Label
            {
                Text = title,
                FontSize = 18,
                FontAttributes = FontAttributes.Bold,
                Margin = new Thickness(0, 0, 0, 12)
            };

            content.Children.Add(titleLabel);

            foreach (var item in items)
            {
                var itemGrid = new Grid();
                itemGrid.ColumnDefinitions.Add(new ColumnDefinition { Width = new GridLength(1, GridUnitType.Auto) });
                itemGrid.ColumnDefinitions.Add(new ColumnDefinition { Width = new GridLength(1, GridUnitType.Star) });

                var labelControl = new Label
                {
                    Text = $"{item.label}:",
                    FontSize = 14,
                    TextColor = Color.FromHex("#666"),
                    WidthRequest = 100
                };

                var valueControl = new Label
                {
                    Text = item.value,
                    FontSize = 14,
                    HorizontalOptions = LayoutOptions.FillAndExpand
                };

                Grid.SetColumn(labelControl, 0);
                Grid.SetColumn(valueControl, 1);
                itemGrid.Children.Add(labelControl);
                itemGrid.Children.Add(valueControl);

                content.Children.Add(itemGrid);
            }

            card.Content = content;
            return card;
        }

        private int GetThemeIndex()
        {
            var theme = _formData["theme"].ToString();
            return theme switch
            {
                "light" => 0,
                "dark" => 1,
                "auto" => 2,
                _ => 0
            };
        }

        private int GetLanguageIndex()
        {
            var language = _formData["language"].ToString();
            return language switch
            {
                "en" => 0,
                "es" => 1,
                "fr" => 2,
                _ => 0
            };
        }

        private string GetLanguageCode(string language)
        {
            return language switch
            {
                "English" => "en",
                "Spanish" => "es",
                "French" => "fr",
                _ => "en"
            };
        }

        private void UpdateNavigationButtons()
        {
            PreviousButton.IsEnabled = _currentStep > 1;
            StepInfoLabel.Text = $"Step {_currentStep} of {TotalSteps}";

            if (_currentStep < TotalSteps)
            {
                NextButton.Text = "Next";
                NextButton.BackgroundColor = Color.FromHex("#007AFF");
            }
            else
            {
                NextButton.Text = _isSubmitting ? "Submitting..." : "Submit";
                NextButton.BackgroundColor = _isSubmitting ? Color.FromHex("#CCCCCC") : Color.FromHex("#007AFF");
                NextButton.IsEnabled = !_isSubmitting;
            }
        }

        private bool ValidateCurrentStep()
        {
            _errors.Clear();

            switch (_currentStep)
            {
                case 1:
                    if (string.IsNullOrWhiteSpace(_formData["firstName"].ToString()))
                        _errors["firstName"] = "First name is required";
                    if (string.IsNullOrWhiteSpace(_formData["lastName"].ToString()))
                        _errors["lastName"] = "Last name is required";
                    if (string.IsNullOrWhiteSpace(_formData["email"].ToString()))
                        _errors["email"] = "Email is required";
                    else if (!_formData["email"].ToString().Contains("@"))
                        _errors["email"] = "Email is invalid";
                    if (string.IsNullOrWhiteSpace(_formData["phone"].ToString()))
                        _errors["phone"] = "Phone number is required";
                    break;
                case 2:
                    if (string.IsNullOrWhiteSpace(_formData["street"].ToString()))
                        _errors["street"] = "Street address is required";
                    if (string.IsNullOrWhiteSpace(_formData["city"].ToString()))
                        _errors["city"] = "City is required";
                    if (string.IsNullOrWhiteSpace(_formData["state"].ToString()))
                        _errors["state"] = "State is required";
                    if (string.IsNullOrWhiteSpace(_formData["zipCode"].ToString()))
                        _errors["zipCode"] = "ZIP code is required";
                    break;
                case 3:
                    // Preferences are optional
                    break;
                case 4:
                    if (string.IsNullOrWhiteSpace(_formData["cardNumber"].ToString()))
                        _errors["cardNumber"] = "Card number is required";
                    else if (_formData["cardNumber"].ToString().Replace(" ", "").Length < 16)
                        _errors["cardNumber"] = "Card number must be 16 digits";
                    if (string.IsNullOrWhiteSpace(_formData["expiryDate"].ToString()))
                        _errors["expiryDate"] = "Expiry date is required";
                    if (string.IsNullOrWhiteSpace(_formData["cvv"].ToString()))
                        _errors["cvv"] = "CVV is required";
                    if (string.IsNullOrWhiteSpace(_formData["cardholderName"].ToString()))
                        _errors["cardholderName"] = "Cardholder name is required";
                    break;
                case 5:
                    if (!(bool)_formData["termsAccepted"])
                        _errors["termsAccepted"] = "You must accept the terms and conditions";
                    if (!(bool)_formData["privacyAccepted"])
                        _errors["privacyAccepted"] = "You must accept the privacy policy";
                    break;
            }

            return _errors.Count == 0;
        }

        private async void OnPreviousClicked(object sender, EventArgs e)
        {
            if (_currentStep > 1)
            {
                _currentStep--;
                BuildStepIndicator();
                LoadStepContent();
            }
        }

        private async void OnNextClicked(object sender, EventArgs e)
        {
            if (!ValidateCurrentStep())
            {
                LoadStepContent(); // Reload to show errors
                return;
            }

            if (_currentStep < TotalSteps)
            {
                _currentStep++;
                BuildStepIndicator();
                LoadStepContent();
            }
            else
            {
                await SubmitForm();
            }
        }

        private async Task SubmitForm()
        {
            _isSubmitting = true;
            LoadingOverlay.IsVisible = true;
            UpdateNavigationButtons();

            // Simulate API call
            await Task.Delay(2000);

            _isSubmitting = false;
            LoadingOverlay.IsVisible = false;

            await DisplayAlert("Success!", "Your registration has been completed successfully.", "OK");

            // Reset form
            _currentStep = 1;
            _formData = new Dictionary<string, object>
            {
                ["firstName"] = "",
                ["lastName"] = "",
                ["email"] = "",
                ["phone"] = "",
                ["dateOfBirth"] = "",
                ["street"] = "",
                ["city"] = "",
                ["state"] = "",
                ["zipCode"] = "",
                ["country"] = "",
                ["newsletter"] = false,
                ["notifications"] = true,
                ["theme"] = "light",
                ["language"] = "en",
                ["cardNumber"] = "",
                ["expiryDate"] = "",
                ["cvv"] = "",
                ["cardholderName"] = "",
                ["termsAccepted"] = false,
                ["privacyAccepted"] = false
            };

            BuildStepIndicator();
            LoadStepContent();
        }
    }
}
