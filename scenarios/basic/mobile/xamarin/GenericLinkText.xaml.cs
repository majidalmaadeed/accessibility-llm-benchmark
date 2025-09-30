using System;
using System.Collections.ObjectModel;
using System.ComponentModel;
using Xamarin.Forms;

namespace AccessibilityTest
{
    public partial class GenericLinkText : ContentPage
    {
        public ObservableCollection<ArticleItem> Articles { get; set; }

        public GenericLinkText()
        {
            InitializeComponent();
            BindingContext = this;
            
            // Initialize articles list
            Articles = new ObservableCollection<ArticleItem>
            {
                new ArticleItem
                {
                    Title = "Understanding Flutter Performance Optimization",
                    Excerpt = "Learn how to optimize your Flutter applications for better performance and user experience.",
                    Category = "Technology",
                    ReadTime = "5 min read",
                    Author = "By John Smith",
                    Date = "2024-01-15",
                    Image = "https://via.placeholder.com/120x100"
                },
                new ArticleItem
                {
                    Title = "Mobile UI/UX Design Best Practices",
                    Excerpt = "Essential design principles for creating intuitive and accessible mobile interfaces.",
                    Category = "Design",
                    ReadTime = "7 min read",
                    Author = "By Sarah Johnson",
                    Date = "2024-01-12",
                    Image = "https://via.placeholder.com/120x100"
                },
                new ArticleItem
                {
                    Title = "Cross-Platform Development Strategies",
                    Excerpt = "Compare different approaches to building apps that work across multiple platforms.",
                    Category = "Technology",
                    ReadTime = "10 min read",
                    Author = "By Mike Chen",
                    Date = "2024-01-10",
                    Image = "https://via.placeholder.com/120x100"
                },
                new ArticleItem
                {
                    Title = "State Management in Modern React",
                    Excerpt = "Explore different state management solutions for complex React applications.",
                    Category = "Technology",
                    ReadTime = "8 min read",
                    Author = "By Emily Davis",
                    Date = "2024-01-08",
                    Image = "https://via.placeholder.com/120x100"
                },
                new ArticleItem
                {
                    Title = "Building Scalable React Native Applications",
                    Excerpt = "Discover the key principles and patterns for creating maintainable and scalable React Native applications.",
                    Category = "Technology",
                    ReadTime = "12 min read",
                    Author = "By Alex Thompson",
                    Date = "2024-01-20",
                    Image = "https://via.placeholder.com/120x100"
                }
            };
        }

        private void OnReadMoreClicked(object sender, EventArgs e)
        {
            DisplayAlert("Read More", "Opening full article...", "OK");
        }

        private void OnArticleReadMoreClicked(object sender, EventArgs e)
        {
            DisplayAlert("Read More", "Opening article...", "OK");
        }
    }

    public class ArticleItem : INotifyPropertyChanged
    {
        public string Title { get; set; }
        public string Excerpt { get; set; }
        public string Category { get; set; }
        public string ReadTime { get; set; }
        public string Author { get; set; }
        public string Date { get; set; }
        public string Image { get; set; }

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
