using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
{
    {
        private bool _isOpen;
        private string _selectedValue = "all";
        private string _selectedText = "All Categories";
        private int _currentIndex = 0;
        public bool IsOpen
        {
            get => _isOpen;
            set
            {
                _isOpen = value;
                OnPropertyChanged();
            }
        }
        public string SelectedValue
        {
            get => _selectedValue;
            set
            {
                _selectedValue = value;
                OnPropertyChanged();
                OnPropertyChanged(nameof(FilteredProducts));
            }
        }
        public string SelectedText
        {
            get => _selectedText;
            set
            {
                _selectedText = value;
                OnPropertyChanged();
            }
        }
        public int CurrentIndex
        {
            get => _currentIndex;
            set
            {
                _currentIndex = value;
                OnPropertyChanged();
            }
        }
        public ObservableCollection<Option> Options { get; set; }
        public ObservableCollection<Product> FilteredProducts { get; set; }
        private readonly Dictionary<string, List<Product>> _products = new Dictionary<string, List<Product>>
        {
            ["all"] = new List<Product>
            {
                new Product { Name = "iPhone 15", Category = "Electronics" },
                new Product { Name = "MacBook Pro", Category = "Electronics" },
                new Product { Name = "Cotton T-Shirt", Category = "Clothing" },
                new Product { Name = "JavaScript Guide", Category = "Books" },
                new Product { Name = "Garden Tools", Category = "Home & Garden" }
            },
            ["electronics"] = new List<Product>
            {
                new Product { Name = "iPhone 15", Category = "Electronics" },
                new Product { Name = "MacBook Pro", Category = "Electronics" }
            },
            ["clothing"] = new List<Product>
            {
                new Product { Name = "Cotton T-Shirt", Category = "Clothing" }
            },
            ["books"] = new List<Product>
            {
                new Product { Name = "JavaScript Guide", Category = "Books" }
            },
            ["home"] = new List<Product>
            {
                new Product { Name = "Garden Tools", Category = "Home & Garden" }
            }
        };
        {
            InitializeComponent();
            InitializeData();
            DataContext = this;
        }
        private void InitializeData()
        {
            Options = new ObservableCollection<Option>
            {
                new Option { Value = "all", Text = "All Categories", IsSelected = true },
                new Option { Value = "electronics", Text = "Electronics", IsSelected = false },
                new Option { Value = "clothing", Text = "Clothing", IsSelected = false },
                new Option { Value = "books", Text = "Books", IsSelected = false },
                new Option { Value = "home", Text = "Home & Garden", IsSelected = false }
            };
            DropdownList.ItemsSource = Options;
            UpdateFilteredProducts();
        }
        {
            DropdownButton.SetValue(AutomationProperties.AutomationIdProperty, "CategoryFilter");
            DropdownButton.SetValue(AutomationProperties.NameProperty, $"Category filter, {SelectedText}, click to open dropdown");
            DropdownButton.SetValue(AutomationProperties.HelpTextProperty, "Opens category selection dropdown");
            DropdownList.SetValue(AutomationProperties.AutomationIdProperty, "CategoryOptions");
            DropdownList.SetValue(AutomationProperties.NameProperty, "Category options");
        }
        private void OnDropdownButtonClicked(object sender, RoutedEventArgs e)
        {
            ToggleDropdown();
        }
        private void ToggleDropdown()
        {
            IsOpen = !IsOpen;
            DropdownList.Visibility = IsOpen ? Visibility.Visible : Visibility.Collapsed;
            // Update button appearance
            if (IsOpen)
            {
                DropdownButton.BorderBrush = System.Windows.Media.Brushes.Blue;
            }
            else
            {
                DropdownButton.BorderBrush = new System.Windows.Media.SolidColorBrush(
                    (System.Windows.Media.Color)System.Windows.Media.ColorConverter.ConvertFromString("#DDDDDD"));
            }
            DropdownButton.SetValue(AutomationProperties.NameProperty, 
                $"Category filter, {SelectedText}, {(IsOpen ? "dropdown is open" : "click to open dropdown")}");
        }
        private void OnOptionSelected(object sender, SelectionChangedEventArgs e)
        {
            if (DropdownList.SelectedItem is Option selectedOption)
            {
                SelectOption(selectedOption.Value, selectedOption.Text, Options.IndexOf(selectedOption));
            }
        }
        private void SelectOption(string value, string text, int index)
        {
            SelectedValue = value;
            SelectedText = text;
            CurrentIndex = index;
            // Update selection state
            foreach (var option in Options)
            {
                option.IsSelected = option.Value == value;
            }
            ToggleDropdown();
            UpdateFilteredProducts();
            System.Windows.Automation.AutomationProperties.SetName(DropdownButton, $"Category filter, {SelectedText}, selected");
            var peer = System.Windows.Automation.Peers.UIElementAutomationPeer.FromElement(DropdownButton);
            peer?.RaiseAutomationEvent(System.Windows.Automation.AutomationEvents.SelectionItemPatternOnElementSelected);
        }
        private void UpdateFilteredProducts()
        {
            if (_products.ContainsKey(SelectedValue))
            {
                FilteredProducts = new ObservableCollection<Product>(_products[SelectedValue]);
            }
            else
            {
                FilteredProducts = new ObservableCollection<Product>();
            }
            OnPropertyChanged(nameof(FilteredProducts));
        }
        protected override void OnKeyDown(KeyEventArgs e)
        {
            if (e.Key == Key.Escape && IsOpen)
            {
                ToggleDropdown();
                e.Handled = true;
            }
            base.OnKeyDown(e);
        }
        public event PropertyChangedEventHandler PropertyChanged;
        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
    public class Option : INotifyPropertyChanged
    {
        private string _value;
        private string _text;
        private bool _isSelected;
        public string Value
        {
            get => _value;
            set
            {
                _value = value;
                OnPropertyChanged();
            }
        }
        public string Text
        {
            get => _text;
            set
            {
                _text = value;
                OnPropertyChanged();
            }
        }
        public bool IsSelected
        {
            get => _isSelected;
            set
            {
                _isSelected = value;
                OnPropertyChanged();
            }
        }
        public event PropertyChangedEventHandler PropertyChanged;
        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
    public class Product : INotifyPropertyChanged
    {
        private string _name;
        private string _category;
        public string Name
        {
            get => _name;
            set
            {
                _name = value;
                OnPropertyChanged();
            }
        }
        public string Category
        {
            get => _category;
            set
            {
                _category = value;
                OnPropertyChanged();
            }
        }
        public event PropertyChangedEventHandler PropertyChanged;
        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}