using System;
using System.Collections.ObjectModel;
using System.ComponentModel;
using Xamarin.Forms;

namespace AccessibilityTest
{
    public partial class FlashingAdvertisement : ContentPage
    {
        private bool isFlashing = true;
        private int flashCount = 0;

        public ObservableCollection<ProductItem> Products { get; set; }

        public FlashingAdvertisement()
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
                    InStock = true,
                    IsOutOfStock = false,
                    HasOriginalPrice = true,
                    SaveText = "Save $50"
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
                    SaveText = "Save $100"
                },
                new ProductItem
                {
                    Name = "Bluetooth Speaker",
                    Price = "$79.99",
                    OriginalPrice = "$99.99",
                    Rating = "4.3",
                    Image = "https://via.placeholder.com/200x200",
                    InStock = false,
                    IsOutOfStock = true,
                    HasOriginalPrice = true,
                    SaveText = "Save $20"
                }
            };
            
            // Start flashing animation
            StartFlashing();
        }

        private void StartFlashing()
        {
            Device.StartTimer(TimeSpan.FromMilliseconds(200), () =>
            {
                if (isFlashing)
                {
                    // FLASHING: Alternates between colors
                    FlashBanner.BackgroundColor = flashCount % 2 == 0 ? Color.Red : Color.Orange;
                    flashCount++;
                    FlashCountLabel.Text = $"Flashes: {flashCount}";
                }
                return isFlashing;
            });
        }

        private void OnPlayPauseClicked(object sender, EventArgs e)
        {
            isFlashing = !isFlashing;
            var button = sender as Button;
            button.Text = isFlashing ? "⏸️" : "▶️";
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
        public string SaveText { get; set; }

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
