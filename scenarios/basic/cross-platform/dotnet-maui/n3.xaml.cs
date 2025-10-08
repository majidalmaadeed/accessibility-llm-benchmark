using Microsoft.Maui.Controls;

namespace AccessibilityScenarios
{
    public partial class DecorativeImageWithAltText : ContentPage
    {
        public DecorativeImageWithAltText()
        {
            InitializeComponent();
        }
        
        private void OnAddToCartClicked(object sender, EventArgs e)
        {
            DisplayAlert("Cart", "Item added to cart!", "OK");
        }
        
        private void OnViewDetailsClicked(object sender, EventArgs e)
        {
            DisplayAlert("Details", "Viewing product details...", "OK");
        }
        
        private void OnViewOffersClicked(object sender, EventArgs e)
        {
            DisplayAlert("Offers", "Showing special offers...", "OK");
        }
        
        private void OnSubscribeClicked(object sender, EventArgs e)
        {
            DisplayAlert("Subscribe", "Subscribed to newsletter!", "OK");
        }
    }
}

