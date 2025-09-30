using System;
using System.Windows;

namespace AccessibilityTest
{
    public partial class InaccessibleTooltip : Window
    {
        public InaccessibleTooltip()
        {
            InitializeComponent();
        }

        private void ShowTooltip_Click(object sender, RoutedEventArgs e)
        {
            var button = sender as System.Windows.Controls.Button;
            if (button != null && button.ToolTip != null)
            {
                MessageBox.Show(button.ToolTip.ToString());
            }
        }

        private void Cancel_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Form creation cancelled.");
        }

        private void CreateForm_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Form created successfully!");
        }
    }
}
