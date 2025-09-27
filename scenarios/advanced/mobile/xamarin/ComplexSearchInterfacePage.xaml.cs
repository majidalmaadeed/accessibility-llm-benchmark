using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Threading.Tasks;
using Xamarin.Forms;

namespace AccessibilityBenchmark
{
    public partial class ComplexSearchInterfacePage : ContentPage
    {
        private string searchQuery = "";
        private ObservableCollection<SearchResult> searchResults = new ObservableCollection<SearchResult>();
        private bool isLoading = false;
        private HashSet<string> selectedFilters = new HashSet<string>();
        private string sortOption = "relevance";
        private string viewMode = "list";
        private string selectedCategory = "All";
        private double minPrice = 0;
        private double maxPrice = 1000;

        public ComplexSearchInterfacePage()
        {
            InitializeComponent();
            BindingContext = this;
        }

        public ObservableCollection<SearchResult> SearchResults
        {
            get => searchResults;
            set
            {
                searchResults = value;
                OnPropertyChanged();
            }
        }

        private async void OnSearchClicked(object sender, EventArgs e)
        {
            await PerformSearch();
        }

        private async void OnSearchCompleted(object sender, EventArgs e)
        {
            await PerformSearch();
        }

        private async Task PerformSearch()
        {
            searchQuery = SearchEntry.Text;
            
            if (string.IsNullOrWhiteSpace(searchQuery))
            {
                SearchResults.Clear();
                UpdateEmptyState();
                return;
            }

            isLoading = true;
            LoadingIndicator.IsVisible = true;
            LoadingIndicator.IsRunning = true;
            ResultsCollectionView.IsVisible = false;
            EmptyStateLayout.IsVisible = false;

            // Simulate API call
            await Task.Delay(1000);

            var filteredResults = GetFilteredResults();
            SearchResults = new ObservableCollection<SearchResult>(filteredResults);

            isLoading = false;
            LoadingIndicator.IsVisible = false;
            LoadingIndicator.IsRunning = false;
            ResultsCollectionView.IsVisible = true;
            UpdateEmptyState();
        }

        private List<SearchResult> GetFilteredResults()
        {
            var sampleResults = GetSampleResults();
            var filteredResults = sampleResults.AsEnumerable();

            // Apply search query filter
            if (!string.IsNullOrWhiteSpace(searchQuery))
            {
                filteredResults = filteredResults.Where(r =>
                    r.Title.ToLower().Contains(searchQuery.ToLower()) ||
                    r.Description.ToLower().Contains(searchQuery.ToLower())
                );
            }

            // Apply category filter
            if (selectedCategory != "All")
            {
                filteredResults = filteredResults.Where(r => r.Category == selectedCategory);
            }

            // Apply price range filter
            filteredResults = filteredResults.Where(r => r.Price >= minPrice && r.Price <= maxPrice);

            // Apply selected filters
            foreach (var filterId in selectedFilters)
            {
                switch (filterId)
                {
                    case "recent":
                        var recentDate = DateTime.Now.AddDays(-7);
                        filteredResults = filteredResults.Where(r => r.Date > recentDate);
                        break;
                    case "large":
                        filteredResults = filteredResults.Where(r => r.SizeValue > 1);
                        break;
                    case "images":
                        filteredResults = filteredResults.Where(r => r.Type == "image");
                        break;
                    case "videos":
                        filteredResults = filteredResults.Where(r => r.Type == "video");
                        break;
                    case "free":
                        filteredResults = filteredResults.Where(r => r.Price == 0);
                        break;
                }
            }

            // Apply sorting
            switch (sortOption)
            {
                case "date":
                    filteredResults = filteredResults.OrderByDescending(r => r.Date);
                    break;
                case "name":
                    filteredResults = filteredResults.OrderBy(r => r.Title);
                    break;
                case "size":
                    filteredResults = filteredResults.OrderByDescending(r => r.SizeValue);
                    break;
                case "type":
                    filteredResults = filteredResults.OrderBy(r => r.Type);
                    break;
                case "rating":
                    filteredResults = filteredResults.OrderByDescending(r => r.Rating);
                    break;
                default:
                    // relevance - keep original order
                    break;
            }

            return filteredResults.ToList();
        }

        private List<SearchResult> GetSampleResults()
        {
            return new List<SearchResult>
            {
                new SearchResult
                {
                    Id = "1",
                    Title = "React Native Development Guide",
                    Description = "Comprehensive guide to building mobile apps with React Native",
                    Type = "document",
                    Category = "Documents",
                    Size = "2.5 MB",
                    SizeValue = 2.5,
                    Date = new DateTime(2024, 1, 15),
                    Rating = 4.8,
                    Price = 0,
                    Image = "📄",
                    Url = "https://example.com/react-native-guide"
                },
                new SearchResult
                {
                    Id = "2",
                    Title = "Mobile UI Design Patterns",
                    Description = "Best practices for mobile user interface design",
                    Type = "image",
                    Category = "Images",
                    Size = "1.2 MB",
                    SizeValue = 1.2,
                    Date = new DateTime(2024, 1, 14),
                    Rating = 4.6,
                    Price = 29.99,
                    Image = "🖼️",
                    Url = "https://example.com/ui-patterns"
                },
                new SearchResult
                {
                    Id = "3",
                    Title = "JavaScript Tutorial Series",
                    Description = "Complete JavaScript tutorial for beginners",
                    Type = "video",
                    Category = "Videos",
                    Size = "150 MB",
                    SizeValue = 150,
                    Date = new DateTime(2024, 1, 13),
                    Rating = 4.9,
                    Price = 49.99,
                    Image = "🎥",
                    Url = "https://example.com/js-tutorial"
                },
                new SearchResult
                {
                    Id = "4",
                    Title = "Web Development News",
                    Description = "Latest news and updates in web development",
                    Type = "news",
                    Category = "News",
                    Size = "500 KB",
                    SizeValue = 0.5,
                    Date = new DateTime(2024, 1, 12),
                    Rating = 4.3,
                    Price = 0,
                    Image = "📰",
                    Url = "https://example.com/web-news"
                },
                new SearchResult
                {
                    Id = "5",
                    Title = "E-commerce Product Catalog",
                    Description = "Complete product catalog for online store",
                    Type = "product",
                    Category = "Products",
                    Size = "5.8 MB",
                    SizeValue = 5.8,
                    Date = new DateTime(2024, 1, 11),
                    Rating = 4.5,
                    Price = 99.99,
                    Image = "🛍️",
                    Url = "https://example.com/product-catalog"
                }
            };
        }

        private void OnFilterToggled(object sender, EventArgs e)
        {
            if (sender is Button button && button.CommandParameter is string filterId)
            {
                if (selectedFilters.Contains(filterId))
                {
                    selectedFilters.Remove(filterId);
                    button.BackgroundColor = Color.FromHex("#F0F0F0");
                    button.TextColor = Color.FromHex("#666");
                }
                else
                {
                    selectedFilters.Add(filterId);
                    button.BackgroundColor = Color.FromHex("#007AFF");
                    button.TextColor = Color.White;
                }
            }
        }

        private void OnSortChanged(object sender, EventArgs e)
        {
            if (sender is Picker picker)
            {
                var options = new[] { "relevance", "date", "name", "size", "type", "rating" };
                if (picker.SelectedIndex >= 0 && picker.SelectedIndex < options.Length)
                {
                    sortOption = options[picker.SelectedIndex];
                }
            }
        }

        private void OnViewModeChanged(object sender, EventArgs e)
        {
            if (sender is Button button && button.CommandParameter is string mode)
            {
                viewMode = mode;
                // Update view mode styling
            }
        }

        private async void OnFiltersClicked(object sender, EventArgs e)
        {
            await Navigation.PushModalAsync(new AdvancedFiltersPage(this));
        }

        private void OnClearFiltersClicked(object sender, EventArgs e)
        {
            selectedFilters.Clear();
            selectedCategory = "All";
            minPrice = 0;
            maxPrice = 1000;
            UpdateFilterButtons();
        }

        private void UpdateFilterButtons()
        {
            // Reset all filter button colors
            foreach (var child in ((StackLayout)((ScrollView)Content).Content).Children)
            {
                if (child is Button button && button.CommandParameter is string filterId)
                {
                    if (selectedFilters.Contains(filterId))
                    {
                        button.BackgroundColor = Color.FromHex("#007AFF");
                        button.TextColor = Color.White;
                    }
                    else
                    {
                        button.BackgroundColor = Color.FromHex("#F0F0F0");
                        button.TextColor = Color.FromHex("#666");
                    }
                }
            }
        }

        private void UpdateEmptyState()
        {
            EmptyStateLayout.IsVisible = SearchResults.Count == 0 && !isLoading;
            ResultsCollectionView.IsVisible = SearchResults.Count > 0;
        }

        public void SetCategory(string category)
        {
            selectedCategory = category;
        }

        public void SetPriceRange(double min, double max)
        {
            minPrice = min;
            maxPrice = max;
        }

        public event PropertyChangedEventHandler PropertyChanged;
        protected virtual void OnPropertyChanged([System.Runtime.CompilerServices.CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }

    public class SearchResult : INotifyPropertyChanged
    {
        public string Id { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string Type { get; set; }
        public string Category { get; set; }
        public string Size { get; set; }
        public double SizeValue { get; set; }
        public DateTime Date { get; set; }
        public double Rating { get; set; }
        public double Price { get; set; }
        public string Image { get; set; }
        public string Url { get; set; }

        public string PriceText => Price > 0 ? $"${Price:C}" : "";
        public bool HasPrice => Price > 0;

        public event PropertyChangedEventHandler PropertyChanged;
        protected virtual void OnPropertyChanged([System.Runtime.CompilerServices.CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
