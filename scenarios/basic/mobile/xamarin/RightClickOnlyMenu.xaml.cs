using System;
using System.Collections.ObjectModel;
using System.ComponentModel;
using Xamarin.Forms;

namespace AccessibilityTest
{
    public partial class RightClickOnlyMenu : ContentPage
    {
        public ObservableCollection<FileItem> Files { get; set; }

        public RightClickOnlyMenu()
        {
            InitializeComponent();
            BindingContext = this;
            
            // Initialize file list
            Files = new ObservableCollection<FileItem>
            {
                new FileItem
                {
                    Name = "Project Proposal.docx",
                    Size = "2.4 MB",
                    LastModified = "2024-01-20",
                    Type = "Document",
                    Icon = "📄",
                    IconColor = Color.LightBlue
                },
                new FileItem
                {
                    Name = "Budget Report.xlsx",
                    Size = "1.8 MB",
                    LastModified = "2024-01-19",
                    Type = "Spreadsheet",
                    Icon = "📊",
                    IconColor = Color.LightGreen
                },
                new FileItem
                {
                    Name = "Meeting Notes.pdf",
                    Size = "856 KB",
                    LastModified = "2024-01-18",
                    Type = "PDF",
                    Icon = "📕",
                    IconColor = Color.LightPink
                },
                new FileItem
                {
                    Name = "Design Mockups.sketch",
                    Size = "15.2 MB",
                    LastModified = "2024-01-17",
                    Type = "Design",
                    Icon = "🎨",
                    IconColor = Color.LightYellow
                },
                new FileItem
                {
                    Name = "Contract Template.docx",
                    Size = "1.2 MB",
                    LastModified = "2024-01-16",
                    Type = "Document",
                    Icon = "📄",
                    IconColor = Color.LightBlue
                },
                new FileItem
                {
                    Name = "User Research.pdf",
                    Size = "3.1 MB",
                    LastModified = "2024-01-15",
                    Type = "PDF",
                    Icon = "📕",
                    IconColor = Color.LightPink
                }
            };
        }

        private void OnNewFolderClicked(object sender, EventArgs e)
        {
            DisplayAlert("New Folder", "Creating new folder...", "OK");
        }

        private void OnNewFileClicked(object sender, EventArgs e)
        {
            DisplayAlert("New File", "Creating new file...", "OK");
        }

        private void OnUploadClicked(object sender, EventArgs e)
        {
            DisplayAlert("Upload", "Opening file picker...", "OK");
        }

        private void OnSearchClicked(object sender, EventArgs e)
        {
            DisplayAlert("Search", "Opening search...", "OK");
        }

        private void OnMoreOptionsClicked(object sender, EventArgs e)
        {
            // Show context menu
            ContextMenu.IsVisible = true;
        }

        private void OnOpenClicked(object sender, EventArgs e)
        {
            ContextMenu.IsVisible = false;
            DisplayAlert("Open", "Opening file...", "OK");
        }

        private void OnCopyClicked(object sender, EventArgs e)
        {
            ContextMenu.IsVisible = false;
            DisplayAlert("Copy", "File copied to clipboard!", "OK");
        }

        private void OnRenameClicked(object sender, EventArgs e)
        {
            ContextMenu.IsVisible = false;
            DisplayAlert("Rename", "Opening rename dialog...", "OK");
        }

        private void OnShareClicked(object sender, EventArgs e)
        {
            ContextMenu.IsVisible = false;
            DisplayAlert("Share", "Opening share options...", "OK");
        }

        private void OnDeleteClicked(object sender, EventArgs e)
        {
            ContextMenu.IsVisible = false;
            DisplayAlert("Delete", "File deleted!", "OK");
        }
    }

    public class FileItem : INotifyPropertyChanged
    {
        public string Name { get; set; }
        public string Size { get; set; }
        public string LastModified { get; set; }
        public string Type { get; set; }
        public string Icon { get; set; }
        public Color IconColor { get; set; }

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
