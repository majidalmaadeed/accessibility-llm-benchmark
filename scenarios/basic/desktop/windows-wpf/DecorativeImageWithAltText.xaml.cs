using System;
using System.Windows;

namespace AccessibilityTest
{
    public partial class DecorativeImageWithAltText : Window
    {
        public DecorativeImageWithAltText()
        {
            InitializeComponent();
        }

        private void AddToCart_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Item added to cart!");
        }
    }
}
