using System;
using System.Collections.ObjectModel;
using System.ComponentModel;
using Xamarin.Forms;

namespace AccessibilityTest
{
    public partial class StatusByShapeOnly : ContentPage, INotifyPropertyChanged
    {
        private bool _hasSelectedItems = false;
        private string _selectedCount = "0 document(s) selected";

        public ObservableCollection<DocumentItem> Documents { get; set; }
        public bool HasSelectedItems
        {
            get => _hasSelectedItems;
            set
            {
                _hasSelectedItems = value;
                OnPropertyChanged(nameof(HasSelectedItems));
            }
        }
        public string SelectedCount
        {
            get => _selectedCount;
            set
            {
                _selectedCount = value;
                OnPropertyChanged(nameof(SelectedCount));
            }
        }

        public StatusByShapeOnly()
        {
            InitializeComponent();
            BindingContext = this;
            
            // Initialize documents list
            Documents = new ObservableCollection<DocumentItem>
            {
                new DocumentItem
                {
                    Name = "Project Proposal.docx",
                    Type = "Document",
                    Size = "2.4 MB",
                    LastModified = "2024-01-20",
                    Author = "John Smith",
                    Department = "Engineering",
                    Status = "approved", // Circle shape
                    StatusColor = Color.Green,
                    Icon = "📄"
                },
                new DocumentItem
                {
                    Name = "Budget Report.xlsx",
                    Type = "Spreadsheet",
                    Size = "1.8 MB",
                    LastModified = "2024-01-19",
                    Author = "Sarah Johnson",
                    Department = "Finance",
                    Status = "pending", // Square shape
                    StatusColor = Color.Orange,
                    Icon = "📊"
                },
                new DocumentItem
                {
                    Name = "Meeting Notes.pdf",
                    Type = "PDF",
                    Size = "856 KB",
                    LastModified = "2024-01-18",
                    Author = "Mike Chen",
                    Department = "Marketing",
                    Status = "rejected", // Circle shape (same as approved!)
                    StatusColor = Color.Red,
                    Icon = "📕"
                },
                new DocumentItem
                {
                    Name = "Design Mockups.sketch",
                    Type = "Design",
                    Size = "15.2 MB",
                    LastModified = "2024-01-17",
                    Author = "Emily Davis",
                    Department = "Design",
                    Status = "approved", // Circle shape
                    StatusColor = Color.Green,
                    Icon = "🎨"
                },
                new DocumentItem
                {
                    Name = "Contract Template.docx",
                    Type = "Document",
                    Size = "1.2 MB",
                    LastModified = "2024-01-16",
                    Author = "David Wilson",
                    Department = "Legal",
                    Status = "pending", // Square shape
                    StatusColor = Color.Orange,
                    Icon = "📄"
                },
                new DocumentItem
                {
                    Name = "User Research.pdf",
                    Type = "PDF",
                    Size = "3.1 MB",
                    LastModified = "2024-01-15",
                    Author = "Lisa Brown",
                    Department = "Research",
                    Status = "rejected", // Circle shape
                    StatusColor = Color.Red,
                    Icon = "📕"
                }
            };
        }

        private void OnItemSelectClicked(object sender, EventArgs e)
        {
            // Toggle selection
            var button = sender as Button;
            button.Text = button.Text == "☐" ? "☑" : "☐";
            
            // Update selected count
            var selectedCount = 0;
            foreach (var doc in Documents)
            {
                // This is a simplified example - in real app you'd track selection state
                selectedCount++;
            }
            
            HasSelectedItems = selectedCount > 0;
            SelectedCount = $"{selectedCount} document(s) selected";
        }

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }

    public class DocumentItem : INotifyPropertyChanged
    {
        public string Name { get; set; }
        public string Type { get; set; }
        public string Size { get; set; }
        public string LastModified { get; set; }
        public string Author { get; set; }
        public string Department { get; set; }
        public string AuthorDepartment => $"By {Author} • {Department}";
        public string Status { get; set; }
        public Color StatusColor { get; set; }
        public string Icon { get; set; }

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
