using System;
using System.Windows;

namespace AccessibilityTest
{
    public partial class MissingTableHeader : Window
    {
        public MissingTableHeader()
        {
            InitializeComponent();
        }

        private void Search_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Searching employees...");
        }

        private void ViewEmployee_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Viewing employee details");
        }

        private void EditEmployee_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Editing employee details");
        }
    }
}
