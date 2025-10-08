using System;
using System.Windows;

namespace AccessibilityTest
{
    public partial class InsufficientButtonSpacing : Window
    {
        public InsufficientButtonSpacing()
        {
            InitializeComponent();
        }

        private void SaveAction_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Document saved successfully!");
        }

        private void EditAction_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Opening edit mode...");
        }

        private void DeleteAction_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Item deleted!");
        }

        private void ShareAction_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Opening share options...");
        }

        private void CopyAction_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Item copied to clipboard!");
        }

        private void MoveAction_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Opening move dialog...");
        }

        private void ArchiveAction_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Item archived!");
        }

        private void ExportAction_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Opening export options...");
        }

        private void NewDocument_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Creating new document...");
        }

        private void OpenFolder_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Opening folder browser...");
        }

        private void SearchAction_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Opening search...");
        }

        private void SettingsAction_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Opening settings...");
        }

        private void PreviousTrack_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Playing previous track...");
        }

        private void PlayPause_Click(object sender, RoutedEventArgs e)
        {
            var button = sender as System.Windows.Controls.Button;
            if (button != null)
            {
                if (button.Content.ToString() == "⏸️")
                {
                    button.Content = "▶️";
                }
                else
                {
                    button.Content = "⏸️";
                }
            }
        }

        private void NextTrack_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Playing next track...");
        }

        private void ShuffleMode_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Toggling shuffle mode...");
        }

        private void RepeatMode_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Toggling repeat mode...");
        }

        private void GoBack_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Going back...");
        }

        private void GoUp_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Moving up...");
        }

        private void GoForward_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Moving forward...");
        }

        private void GoDown_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Moving down...");
        }
    }
}
