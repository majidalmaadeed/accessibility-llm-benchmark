using System;
using System.Windows;

namespace AccessibilityTest
{
    public partial class GenericLinkText : Window
    {
        public GenericLinkText()
        {
            InitializeComponent();
        }

        private void ReadMore_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Opening full article...");
        }

        private void ShareArticle_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Sharing article...");
        }
    }
}
