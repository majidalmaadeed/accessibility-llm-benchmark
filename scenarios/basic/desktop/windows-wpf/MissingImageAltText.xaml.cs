using System;
using System.Windows;

namespace AccessibilityTest
{
    public partial class MissingImageAltText : Window
    {
        public MissingImageAltText()
        {
            InitializeComponent();
        }

        private void AddToCart_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Item added to cart!");
        }
    }
}
