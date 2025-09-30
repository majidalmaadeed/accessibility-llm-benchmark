using System;
using System.Windows;

namespace AccessibilityTest
{
    public partial class MissingSkipLink : Window
    {
        public MissingSkipLink()
        {
            InitializeComponent();
        }

        private void Search_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Searching products...");
        }

        private void AddToCart_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Item added to cart!");
        }
    }
}
