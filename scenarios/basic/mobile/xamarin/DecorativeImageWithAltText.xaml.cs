using System;
using System.Collections.ObjectModel;
using System.ComponentModel;
using Xamarin.Forms;

namespace AccessibilityTest
{
    public partial class DecorativeImageWithAltText : ContentPage
    {
        public ObservableCollection<ProductItem> Products { get; set; }

        public DecorativeImageWithAltText()
        {
            InitializeComponent();
            BindingContext = this;
            
            // Initialize product list
            Products = new ObservableCollection<ProductItem>
            {
                new ProductItem
                {
                    Name = "Wireless Headphones",
                    Price = "$99.99",
                    OriginalPrice = "$149.99",
                    Rating = "4.5",
                    Image = "https://via.placeholder.com/200x200",
                    Category = "Electronics",
                    HasOriginalPrice = true,
                    DiscountText = "33% OFF"
                },
                new ProductItem
                {
                    Name = "Smart Watch",
                    Price = "$299.99",
                    OriginalPrice = "$399.99",
                    Rating = "4.8",
                    Image = "https://via.placeholder.com/200x200",
                    Category = "Wearables",
                    HasOriginalPrice = true,
                    DiscountText = "25% OFF"
                },
                new ProductItem
                {
                    Name = "Running Shoes",
                    Price = "$129.99",
                    OriginalPrice = "$179.99",
                    Rating = "4.3",
                    Image = "https://via.placeholder.com/200x200",
                    Category = "Sports",
                    HasOriginalPrice = true,
                    DiscountText = "28% OFF"
                },
                new ProductItem
                {
                    Name = "Coffee Maker",
                    Price = "$79.99",
                    OriginalPrice = "$99.99",
                    Rating = "4.6",
                    Image = "https://via.placeholder.com/200x200",
                    Category = "Home",
                    HasOriginalPrice = true,
                    DiscountText = "20% OFF"
                }
            };
        }
    }

    public class ProductItem : INotifyPropertyChanged
    {
        public string Name { get; set; }
        public string Price { get; set; }
        public string OriginalPrice { get; set; }
        public string Rating { get; set; }
        public string Image { get; set; }
        public string Category { get; set; }
        public bool HasOriginalPrice { get; set; }
        public string DiscountText { get; set; }

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
