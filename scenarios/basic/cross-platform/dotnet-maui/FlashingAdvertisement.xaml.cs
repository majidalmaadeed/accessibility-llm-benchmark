using Microsoft.Maui.Controls;

namespace AccessibilityScenarios
{
    public partial class FlashingAdvertisement : ContentPage
    {
        public FlashingAdvertisement()
        {
            InitializeComponent();
        }
        
        private void OnShopNowClicked(object sender, EventArgs e)
        {
            DisplayAlert("Shop Now", "Redirecting to sale items...", "OK");
        }
        
        private void OnViewDealsClicked(object sender, EventArgs e)
        {
            DisplayAlert("View Deals", "Showing all sale items...", "OK");
        }
        
        private void OnBrowseCategoryClicked(object sender, EventArgs e)
        {
            DisplayAlert("Browse", "Opening category page...", "OK");
        }
        
        private void OnAddToCartClicked(object sender, EventArgs e)
        {
            DisplayAlert("Cart", "Item added to cart!", "OK");
        }
        
        private void OnSubscribeClicked(object sender, EventArgs e)
        {
            DisplayAlert("Subscribe", "Thank you for subscribing!", "OK");
        }
    }
}

