using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;

namespace UIComponents
{
    public partial class ComplexSearchInterface : Window
    {
        private ObservableCollection<SearchResult> allResults;
        private ObservableCollection<SearchResult> filteredResults;
        private List<string> activeFilters;
        private string currentSort = "Relevance";
        private string currentCategory = "All";
        private int currentPage = 1;
        private int resultsPerPage = 25;
        private int totalPages = 1;
        
        public ComplexSearchInterface()
        {
            InitializeComponent();
            allResults = new ObservableCollection<SearchResult>();
            filteredResults = new ObservableCollection<SearchResult>();
            activeFilters = new List<string>();
            LoadSampleData();
            UpdateResults();
        }
        
        private void LoadSampleData()
        {
            allResults.Add(new SearchResult
            {
                Id = "1",
                Title = "React Native Development Guide",
                Description = "Comprehensive guide to building mobile apps with React Native",
                Type = "document",
                Category = "Documents",
                Size = "2.5 MB",
                SizeValue = 2.5,
                Date = "2024-01-15",
                Rating = 4.8,
                Price = 0.0,
                Icon = "📄",
                Url = "https://example.com/react-native-guide"
            });
            
            allResults.Add(new SearchResult
            {
                Id = "2",
                Title = "Mobile UI Design Patterns",
                Description = "Best practices for mobile user interface design",
                Type = "image",
                Category = "Images",
                Size = "1.2 MB",
                SizeValue = 1.2,
                Date = "2024-01-14",
                Rating = 4.6,
                Price = 29.99,
                Icon = "🖼️",
                Url = "https://example.com/ui-patterns"
            });
            
            allResults.Add(new SearchResult
            {
                Id = "3",
                Title = "JavaScript Tutorial Series",
                Description = "Complete JavaScript tutorial for beginners",
                Type = "video",
                Category = "Videos",
                Size = "150 MB",
                SizeValue = 150.0,
                Date = "2024-01-13",
                Rating = 4.9,
                Price = 49.99,
                Icon = "🎥",
                Url = "https://example.com/js-tutorial"
            });
            
            allResults.Add(new SearchResult
            {
                Id = "4",
                Title = "Web Development News",
                Description = "Latest news and updates in web development",
                Type = "news",
                Category = "News",
                Size = "500 KB",
                SizeValue = 0.5,
                Date = "2024-01-12",
                Rating = 4.3,
                Price = 0.0,
                Icon = "📰",
                Url = "https://example.com/web-news"
            });
            
            allResults.Add(new SearchResult
            {
                Id = "5",
                Title = "E-commerce Product Catalog",
                Description = "Complete product catalog for online store",
                Type = "product",
                Category = "Products",
                Size = "5.8 MB",
                SizeValue = 5.8,
                Date = "2024-01-11",
                Rating = 4.5,
                Price = 99.99,
                Icon = "🛍️",
                Url = "https://example.com/product-catalog"
            });
            
            allResults.Add(new SearchResult
            {
                Id = "6",
                Title = "Database Design Principles",
                Description = "Fundamental concepts of database design and optimization",
                Type = "document",
                Category = "Documents",
                Size = "3.2 MB",
                SizeValue = 3.2,
                Date = "2024-01-10",
                Rating = 4.7,
                Price = 0.0,
                Icon = "📄",
                Url = "https://example.com/database-design"
            });
            
            allResults.Add(new SearchResult
            {
                Id = "7",
                Title = "Cloud Architecture Diagrams",
                Description = "Visual representations of cloud infrastructure patterns",
                Type = "image",
                Category = "Images",
                Size = "2.1 MB",
                SizeValue = 2.1,
                Date = "2024-01-09",
                Rating = 4.4,
                Price = 19.99,
                Icon = "🖼️",
                Url = "https://example.com/cloud-diagrams"
            });
            
            allResults.Add(new SearchResult
            {
                Id = "8",
                Title = "Machine Learning Course",
                Description = "Complete course on machine learning algorithms and applications",
                Type = "video",
                Category = "Videos",
                Size = "2.5 GB",
                SizeValue = 2500.0,
                Date = "2024-01-08",
                Rating = 4.9,
                Price = 199.99,
                Icon = "🎥",
                Url = "https://example.com/ml-course"
            });
        }
        
        private void SearchTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            PerformSearch();
        }
        
        private void SearchButton_Click(object sender, RoutedEventArgs e)
        {
            PerformSearch();
        }
        
        private void AdvancedSearchButton_Click(object sender, RoutedEventArgs e)
        {
            var advancedDialog = new AdvancedSearchDialog();
            if (advancedDialog.ShowDialog() == true)
            {
                // Apply advanced search criteria
                ApplyAdvancedSearch(advancedDialog.GetSearchCriteria());
            }
        }
        
        private void ApplyAdvancedSearch(AdvancedSearchCriteria criteria)
        {
            // Apply advanced search criteria
            SearchTextBox.Text = criteria.SearchText;
            CategoryComboBox.SelectedItem = CategoryComboBox.Items.Cast<ComboBoxItem>()
                .FirstOrDefault(item => item.Content.ToString() == criteria.Category);
            SortComboBox.SelectedItem = SortComboBox.Items.Cast<ComboBoxItem>()
                .FirstOrDefault(item => item.Content.ToString() == criteria.SortBy);
            
            PerformSearch();
        }
        
        private void PerformSearch()
        {
            var searchText = SearchTextBox.Text.ToLower();
            
            filteredResults.Clear();
            
            var results = allResults.Where(r => 
                string.IsNullOrEmpty(searchText) ||
                r.Title.ToLower().Contains(searchText) ||
                r.Description.ToLower().Contains(searchText) ||
                r.Category.ToLower().Contains(searchText)
            );
            
            // Apply category filter
            if (currentCategory != "All")
            {
                results = results.Where(r => r.Category == currentCategory);
            }
            
            // Apply active filters
            foreach (var filter in activeFilters)
            {
                switch (filter)
                {
                    case "Recent":
                        results = results.Where(r => DateTime.Parse(r.Date) >= DateTime.Now.AddDays(-7));
                        break;
                    case "Large Files":
                        results = results.Where(r => r.SizeValue > 10.0);
                        break;
                    case "Images Only":
                        results = results.Where(r => r.Type == "image");
                        break;
                    case "Videos Only":
                        results = results.Where(r => r.Type == "video");
                        break;
                    case "Free":
                        results = results.Where(r => r.Price == 0.0);
                        break;
                    case "Premium":
                        results = results.Where(r => r.Price > 0.0);
                        break;
                }
            }
            
            // Apply sorting
            switch (currentSort)
            {
                case "Date":
                    results = results.OrderByDescending(r => DateTime.Parse(r.Date));
                    break;
                case "Name":
                    results = results.OrderBy(r => r.Title);
                    break;
                case "Size":
                    results = results.OrderByDescending(r => r.SizeValue);
                    break;
                case "Type":
                    results = results.OrderBy(r => r.Type);
                    break;
                case "Rating":
                    results = results.OrderByDescending(r => r.Rating);
                    break;
                default: // Relevance
                    results = results.OrderByDescending(r => r.Rating);
                    break;
            }
            
            foreach (var result in results)
            {
                filteredResults.Add(result);
            }
            
            UpdateResults();
        }
        
        private void UpdateResults()
        {
            var totalResults = filteredResults.Count;
            totalPages = (int)Math.Ceiling((double)totalResults / resultsPerPage);
            
            if (totalPages == 0) totalPages = 1;
            if (currentPage > totalPages) currentPage = totalPages;
            if (currentPage < 1) currentPage = 1;
            
            var pagedResults = filteredResults.Skip((currentPage - 1) * resultsPerPage).Take(resultsPerPage);
            
            ResultsListBox.ItemsSource = pagedResults;
            ResultsCountText.Text = $"{totalResults} results found";
            PageInfoText.Text = $"Page {currentPage} of {totalPages}";
            
            if (totalResults == 0)
            {
                ResultsListBox.Visibility = Visibility.Collapsed;
                EmptyStateGrid.Visibility = Visibility.Visible;
            }
            else
            {
                ResultsListBox.Visibility = Visibility.Visible;
                EmptyStateGrid.Visibility = Visibility.Collapsed;
            }
            
            UpdatePaginationButtons();
        }
        
        private void UpdatePaginationButtons()
        {
            FirstPageButton.IsEnabled = currentPage > 1;
            PreviousPageButton.IsEnabled = currentPage > 1;
            NextPageButton.IsEnabled = currentPage < totalPages;
            LastPageButton.IsEnabled = currentPage < totalPages;
        }
        
        private void CategoryComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (CategoryComboBox.SelectedItem is ComboBoxItem selectedItem)
            {
                currentCategory = selectedItem.Content.ToString();
                PerformSearch();
            }
        }
        
        private void SortComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (SortComboBox.SelectedItem is ComboBoxItem selectedItem)
            {
                currentSort = selectedItem.Content.ToString();
                PerformSearch();
            }
        }
        
        private void ViewModeComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (ViewModeComboBox.SelectedItem is ComboBoxItem selectedItem)
            {
                var viewMode = selectedItem.Content.ToString();
                // In a real implementation, this would change the view mode
                StatusText.Text = $"View mode changed to {viewMode}";
            }
        }
        
        private void ClearFiltersButton_Click(object sender, RoutedEventArgs e)
        {
            activeFilters.Clear();
            currentCategory = "All";
            CategoryComboBox.SelectedIndex = 0;
            SearchTextBox.Text = "";
            PerformSearch();
        }
        
        private void RecentFilterButton_Click(object sender, RoutedEventArgs e)
        {
            ToggleFilter("Recent", RecentFilterButton);
        }
        
        private void LargeFilesFilterButton_Click(object sender, RoutedEventArgs e)
        {
            ToggleFilter("Large Files", LargeFilesFilterButton);
        }
        
        private void ImagesFilterButton_Click(object sender, RoutedEventArgs e)
        {
            ToggleFilter("Images Only", ImagesFilterButton);
        }
        
        private void VideosFilterButton_Click(object sender, RoutedEventArgs e)
        {
            ToggleFilter("Videos Only", VideosFilterButton);
        }
        
        private void FreeFilterButton_Click(object sender, RoutedEventArgs e)
        {
            ToggleFilter("Free", FreeFilterButton);
        }
        
        private void PremiumFilterButton_Click(object sender, RoutedEventArgs e)
        {
            ToggleFilter("Premium", PremiumFilterButton);
        }
        
        private void ToggleFilter(string filter, Button button)
        {
            if (activeFilters.Contains(filter))
            {
                activeFilters.Remove(filter);
                button.Background = Brushes.Transparent;
            }
            else
            {
                activeFilters.Add(filter);
                button.Background = new SolidColorBrush(Color.FromRgb(33, 150, 243));
                button.Foreground = Brushes.White;
            }
            PerformSearch();
        }
        
        private void ResultsPerPageComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (ResultsPerPageComboBox.SelectedItem is ComboBoxItem selectedItem)
            {
                resultsPerPage = int.Parse(selectedItem.Content.ToString());
                currentPage = 1;
                UpdateResults();
            }
        }
        
        private void ResultsListBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (ResultsListBox.SelectedItem is SearchResult selectedResult)
            {
                StatusText.Text = $"Selected: {selectedResult.Title}";
            }
        }
        
        private void PreviewButton_Click(object sender, RoutedEventArgs e)
        {
            if (sender is Button button && button.Tag is SearchResult result)
            {
                MessageBox.Show($"Preview: {result.Title}\n\n{result.Description}", 
                              "Preview", MessageBoxButton.OK, MessageBoxImage.Information);
            }
        }
        
        private void DownloadButton_Click(object sender, RoutedEventArgs e)
        {
            if (sender is Button button && button.Tag is SearchResult result)
            {
                MessageBox.Show($"Downloading: {result.Title}", 
                              "Download", MessageBoxButton.OK, MessageBoxImage.Information);
            }
        }
        
        private void BookmarkButton_Click(object sender, RoutedEventArgs e)
        {
            if (sender is Button button && button.Tag is SearchResult result)
            {
                MessageBox.Show($"Bookmarked: {result.Title}", 
                              "Bookmark", MessageBoxButton.OK, MessageBoxImage.Information);
            }
        }
        
        private void FirstPageButton_Click(object sender, RoutedEventArgs e)
        {
            currentPage = 1;
            UpdateResults();
        }
        
        private void PreviousPageButton_Click(object sender, RoutedEventArgs e)
        {
            if (currentPage > 1)
            {
                currentPage--;
                UpdateResults();
            }
        }
        
        private void NextPageButton_Click(object sender, RoutedEventArgs e)
        {
            if (currentPage < totalPages)
            {
                currentPage++;
                UpdateResults();
            }
        }
        
        private void LastPageButton_Click(object sender, RoutedEventArgs e)
        {
            currentPage = totalPages;
            UpdateResults();
        }
    }
    
    public class SearchResult
    {
        public string Id { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string Type { get; set; }
        public string Category { get; set; }
        public string Size { get; set; }
        public double SizeValue { get; set; }
        public string Date { get; set; }
        public double Rating { get; set; }
        public double Price { get; set; }
        public string Icon { get; set; }
        public string Url { get; set; }
    }
    
    public class AdvancedSearchCriteria
    {
        public string SearchText { get; set; }
        public string Category { get; set; }
        public string SortBy { get; set; }
        public double MinPrice { get; set; }
        public double MaxPrice { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public double MinRating { get; set; }
        public double MaxRating { get; set; }
    }
    
    public partial class AdvancedSearchDialog : Window
    {
        public AdvancedSearchCriteria GetSearchCriteria()
        {
            return new AdvancedSearchCriteria
            {
                SearchText = "Advanced search criteria",
                Category = "All",
                SortBy = "Relevance",
                MinPrice = 0,
                MaxPrice = 1000,
                StartDate = DateTime.Now.AddYears(-1),
                EndDate = DateTime.Now,
                MinRating = 0,
                MaxRating = 5
            };
        }
    }
}
