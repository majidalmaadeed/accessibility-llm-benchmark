using System;
using Xamarin.Forms;

namespace AccessibilityTest
{
    public partial class InsufficientButtonSpacing : ContentPage
    {
        public InsufficientButtonSpacing()
        {
            InitializeComponent();
        }

        private void OnSaveClicked(object sender, EventArgs e)
        {
            DisplayAlert("Save", "Document saved successfully!", "OK");
        }

        private void OnEditClicked(object sender, EventArgs e)
        {
            DisplayAlert("Edit", "Opening edit mode...", "OK");
        }

        private void OnDeleteClicked(object sender, EventArgs e)
        {
            DisplayAlert("Delete", "Item deleted!", "OK");
        }

        private void OnShareClicked(object sender, EventArgs e)
        {
            DisplayAlert("Share", "Opening share options...", "OK");
        }

        private void OnCopyClicked(object sender, EventArgs e)
        {
            DisplayAlert("Copy", "Item copied to clipboard!", "OK");
        }

        private void OnMoveClicked(object sender, EventArgs e)
        {
            DisplayAlert("Move", "Opening move dialog...", "OK");
        }

        private void OnArchiveClicked(object sender, EventArgs e)
        {
            DisplayAlert("Archive", "Item archived!", "OK");
        }

        private void OnExportClicked(object sender, EventArgs e)
        {
            DisplayAlert("Export", "Opening export options...", "OK");
        }

        private void OnNewDocumentClicked(object sender, EventArgs e)
        {
            DisplayAlert("New Document", "Creating new document...", "OK");
        }

        private void OnOpenFolderClicked(object sender, EventArgs e)
        {
            DisplayAlert("Open Folder", "Opening folder browser...", "OK");
        }

        private void OnSearchClicked(object sender, EventArgs e)
        {
            DisplayAlert("Search", "Opening search...", "OK");
        }

        private void OnSettingsClicked(object sender, EventArgs e)
        {
            DisplayAlert("Settings", "Opening settings...", "OK");
        }

        private void OnPreviousClicked(object sender, EventArgs e)
        {
            DisplayAlert("Previous", "Playing previous track...", "OK");
        }

        private void OnPlayPauseClicked(object sender, EventArgs e)
        {
            DisplayAlert("Play/Pause", "Toggling playback...", "OK");
        }

        private void OnNextClicked(object sender, EventArgs e)
        {
            DisplayAlert("Next", "Playing next track...", "OK");
        }

        private void OnShuffleClicked(object sender, EventArgs e)
        {
            DisplayAlert("Shuffle", "Toggling shuffle mode...", "OK");
        }

        private void OnRepeatClicked(object sender, EventArgs e)
        {
            DisplayAlert("Repeat", "Toggling repeat mode...", "OK");
        }

        private void OnBackClicked(object sender, EventArgs e)
        {
            DisplayAlert("Back", "Going back...", "OK");
        }

        private void OnUpClicked(object sender, EventArgs e)
        {
            DisplayAlert("Up", "Moving up...", "OK");
        }

        private void OnForwardClicked(object sender, EventArgs e)
        {
            DisplayAlert("Forward", "Moving forward...", "OK");
        }

        private void OnDownClicked(object sender, EventArgs e)
        {
            DisplayAlert("Down", "Moving down...", "OK");
        }
    }
}
