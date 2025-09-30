using System;
using System.Collections.ObjectModel;
using System.ComponentModel;
using Xamarin.Forms;

namespace AccessibilityTest
{
    public partial class MissingSkipLink : ContentPage
    {
        public ObservableCollection<ProductItem> Products { get; set; }

        public MissingSkipLink()
        {
            InitializeComponent();
            BindingContext = this;
            
            // Initialize product list
            Products = new ObservableCollection<ProductItem>
            {
                new ProductItem
                {
                    Name = "Wireless Bluetooth Headphones",
                    Price = "$99.99",
                    OriginalPrice = "$149.99",
                    Rating = "4.5",
                    Image = "https://via.placeholder.com/200x200",
                    InStock = true,
                    IsOutOfStock = false,
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
                    InStock = true,
                    IsOutOfStock = false,
                    HasOriginalPrice = true,
                    DiscountText = "25% OFF"
                },
                new ProductItem
                {
                    Name = "Laptop Stand",
                    Price = "$49.99",
                    OriginalPrice = "$69.99",
                    Rating = "4.2",
                    Image = "https://via.placeholder.com/200x200",
                    InStock = false,
                    IsOutOfStock = true,
                    HasOriginalPrice = true,
                    DiscountText = "29% OFF"
                },
                new ProductItem
                {
                    Name = "Bluetooth Speaker",
                    Price = "$79.99",
                    OriginalPrice = "$99.99",
                    Rating = "4.6",
                    Image = "https://via.placeholder.com/200x200",
                    InStock = true,
                    IsOutOfStock = false,
                    HasOriginalPrice = true,
                    DiscountText = "20% OFF"
                },
                new ProductItem
                {
                    Name = "Phone Case",
                    Price = "$19.99",
                    OriginalPrice = "$29.99",
                    Rating = "4.3",
                    Image = "https://via.placeholder.com/200x200",
                    InStock = true,
                    IsOutOfStock = false,
                    HasOriginalPrice = true,
                    DiscountText = "33% OFF"
                },
                new ProductItem
                {
                    Name = "USB Cable",
                    Price = "$9.99",
                    OriginalPrice = "$14.99",
                    Rating = "4.1",
                    Image = "https://via.placeholder.com/200x200",
                    InStock = true,
                    IsOutOfStock = false,
                    HasOriginalPrice = true,
                    DiscountText = "33% OFF"
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
        public bool InStock { get; set; }
        public bool IsOutOfStock { get; set; }
        public bool HasOriginalPrice { get; set; }
        public string DiscountText { get; set; }

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
