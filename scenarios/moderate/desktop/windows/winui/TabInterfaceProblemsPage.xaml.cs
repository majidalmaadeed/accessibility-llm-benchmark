using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using Microsoft.UI.Xaml.Input;
using Microsoft.UI.Xaml.Media;
using System;
using System.Threading.Tasks;
{
    {
        {
            this.InitializeComponent();
        }
        {
            // Should set up AutomationProperties.AutomationId, AutomationProperties.Name
            // Basic setup only
        }
        {
        }
        {
        }
        {
        }
        {
        }
        {
            // Hide all content panels
            // Show selected content panel and style its button
            {
                case "General":
                    break;
                case "Security":
                    break;
                case "Privacy":
                    break;
                case "Advanced":
                    break;
            }
        }
        {
            button.Background = (Brush)Application.Current.Resources["AccentTextFillColorPrimaryBrush"];
            button.Foreground = new SolidColorBrush(Colors.White);
        }
        {
            button.Background = (Brush)Application.Current.Resources["CardBackgroundFillColorSecondaryBrush"];
            button.Foreground = (Brush)Application.Current.Resources["TextFillColorPrimaryBrush"];
        }
        protected override void OnKeyDown(KeyRoutedEventArgs e)
        {
            switch (e.Key)
            {
                case Windows.System.VirtualKey.Left:
                    e.Handled = true;
                    break;
                case Windows.System.VirtualKey.Right:
                    e.Handled = true;
                    break;
                case Windows.System.VirtualKey.Home:
                    e.Handled = true;
                    break;
                case Windows.System.VirtualKey.End:
                    e.Handled = true;
                    break;
                case Windows.System.VirtualKey.Enter:
                case Windows.System.VirtualKey.Space:
                    // Allow default button behavior
                    break;
            }
            base.OnKeyDown(e);
        }
        {
        }
        {
        }
        // Should implement methods to:
    }
}
