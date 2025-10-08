using UIComponents.Models;
using System.Collections.ObjectModel;

namespace UIComponents.Views;

public partial class ShoppingCartPage : ContentPage
{
    public ObservableCollection<CartItem> CartItems { get; set; } = new();

    public ShoppingCartPage()
    {
        InitializeComponent();
        BindingContext = this;
        LoadCartData();
    }

    private void LoadCartData()
    {
        CartItems.Clear();
        
        CartItems.Add(new CartItem { Name = "Product 1", Price = "$29.99", Quantity = "2" });
        CartItems.Add(new CartItem { Name = "Product 2", Price = "$19.99", Quantity = "1" });
        CartItems.Add(new CartItem { Name = "Product 3", Price = "$39.99", Quantity = "3" });
        
        UpdateTotal();
    }

    private void UpdateTotal()
    {
        TotalLabel.Text = "Total: $149.95";
    }

    private void OnRemoveItemClicked(object sender, EventArgs e)
    {
        DisplayAlert("Cart", "Item removed", "OK");
    }

    private void OnCheckoutClicked(object sender, EventArgs e)
    {
        DisplayAlert("Checkout", "Proceeding to checkout...", "OK");
    }
}

public class CartItem
{
    public string Name { get; set; } = string.Empty;
    public string Price { get; set; } = string.Empty;
    public string Quantity { get; set; } = string.Empty;
}
