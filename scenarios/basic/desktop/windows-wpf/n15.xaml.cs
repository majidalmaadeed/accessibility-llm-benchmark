using System;
using System.Windows;

namespace AccessibilityTest
{
    public partial class RightClickOnlyMenu : Window
    {
        public RightClickOnlyMenu()
        {
            InitializeComponent();
        }

        private void ToggleSelection_Click(object sender, RoutedEventArgs e)
        {
            var checkbox = sender as System.Windows.Controls.CheckBox;
            if (checkbox != null)
            {
                MessageBox.Show($"File {(checkbox.IsChecked == true ? "selected" : "deselected")}");
            }
        }

        private void ShowContextMenu_Click(object sender, RoutedEventArgs e)
        {
            var button = sender as System.Windows.Controls.Button;
            if (button != null)
            {
                // Position context menu near the button
                var position = button.PointToScreen(new System.Windows.Point(0, button.ActualHeight));
                ContextMenu.Margin = new Thickness(position.X, position.Y, 0, 0);
                ContextMenu.Visibility = Visibility.Visible;
            }
        }

        private void OpenFile_Click(object sender, RoutedEventArgs e)
        {
            HideContextMenu();
            MessageBox.Show("Opening file...");
        }

        private void CopyFile_Click(object sender, RoutedEventArgs e)
        {
            HideContextMenu();
            MessageBox.Show("File copied to clipboard!");
        }

        private void RenameFile_Click(object sender, RoutedEventArgs e)
        {
            HideContextMenu();
            MessageBox.Show("Opening rename dialog...");
        }

        private void ShareFile_Click(object sender, RoutedEventArgs e)
        {
            HideContextMenu();
            MessageBox.Show("Opening share options...");
        }

        private void DeleteFile_Click(object sender, RoutedEventArgs e)
        {
            HideContextMenu();
            MessageBox.Show("File deleted!");
        }

        private void HideContextMenu()
        {
            ContextMenu.Visibility = Visibility.Collapsed;
        }

        private void NewFolder_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Creating new folder...");
        }

        private void NewFile_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Creating new file...");
        }

        private void UploadFile_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Opening file picker...");
        }

        private void SearchFiles_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Opening search...");
        }

        private void ViewFile_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Viewing file details");
        }

        private void EditFile_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Editing file details");
        }
    }
}
