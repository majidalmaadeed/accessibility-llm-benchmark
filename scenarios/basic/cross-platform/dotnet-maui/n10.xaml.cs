using Microsoft.Maui.Controls;

namespace AccessibilityScenarios
{
    public partial class MissingImageAltText : ContentPage
    {
        public MissingImageAltText()
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
        
        private void OnAddToWishlistClicked(object sender, EventArgs e)
        {
            DisplayAlert("Wishlist", "Item added to wishlist!", "OK");
        }
    }
}
