using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using Xamarin.Forms;

namespace AccessibilityApp
{
    public partial class CustomDropdownNavigationPage : ContentPage, INotifyPropertyChanged
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

        public CustomDropdownNavigationPage()
        {
            InitializeComponent();
            InitializeData();
            BindingContext = this;
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

            UpdateFilteredProducts();
        }

        private void OnDropdownButtonClicked(object sender, System.EventArgs e)
        {
            ToggleDropdown();
        }

        private void ToggleDropdown()
        {
            IsOpen = !IsOpen;
            
            // Update button appearance
            if (IsOpen)
            {
                DropdownButton.BorderColor = Color.FromHex("#007BFF");
            }
            else
            {
                DropdownButton.BorderColor = Color.FromHex("#DDDDDD");
            }
        }

        private void OnOptionSelected(object sender, SelectionChangedEventArgs e)
        {
            if (e.CurrentSelection.Count > 0 && e.CurrentSelection[0] is Option selectedOption)
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

            // Announce selection change for accessibility
            DependencyService.Get<IAccessibilityService>()?.Announce($"Selected {text}");
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

    public interface IAccessibilityService
    {
        void Announce(string message);
    }
}