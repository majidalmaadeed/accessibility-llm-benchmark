using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Threading.Tasks;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Input;

namespace AccessibilityApp
{
    public sealed partial class SearchWithSilentUpdatesPage : Page
    {
        private ObservableCollection<SearchResult> suggestions;
        private ObservableCollection<SearchResult> results;
        private List<SearchResult> mockData;
        private bool isLoading = false;
        private bool showSuggestions = false;

        public ObservableCollection<SearchResult> Suggestions { get; set; }
        public ObservableCollection<SearchResult> Results { get; set; }

        public SearchWithSilentUpdatesPage()
        {
            this.InitializeComponent();
            InitializeData();
            SetupAccessibility();
        }

        private void InitializeData()
        {
            suggestions = new ObservableCollection<SearchResult>();
            results = new ObservableCollection<SearchResult>();
            
            Suggestions = suggestions;
            Results = results;
            
            mockData = new List<SearchResult>
            {
                new SearchResult { Id = 1, Title = "React Development Guide", Category = "Books", Author = "John Doe" },
                new SearchResult { Id = 2, Title = "Vue.js Tutorial", Category = "Books", Author = "Jane Smith" },
                new SearchResult { Id = 3, Title = "Angular Framework", Category = "Books", Author = "Bob Johnson" },
                new SearchResult { Id = 4, Title = "JavaScript Fundamentals", Category = "Books", Author = "Alice Brown" },
                new SearchResult { Id = 5, Title = "React Components", Category = "Tutorials", Author = "Charlie Wilson" },
                new SearchResult { Id = 6, Title = "Vue Components", Category = "Tutorials", Author = "Diana Lee" },
                new SearchResult { Id = 7, Title = "Angular Services", Category = "Tutorials", Author = "Eve Davis" },
                new SearchResult { Id = 8, Title = "JavaScript ES6", Category = "Tutorials", Author = "Frank Miller" }
            };
        }

        private void SetupAccessibility()
        {
            // MISSING: Proper accessibility setup
            // Should set up ARIA attributes, live regions, and keyboard navigation
        }

        private void OnSearchTextChanged(object sender, TextChangedEventArgs e)
        {
            string query = SearchTextBox.Text;
            
            if (query.Length > 1)
            {
                var filtered = mockData.Where(item =>
                    item.Title.ToLower().Contains(query.ToLower()) ||
                    item.Category.ToLower().Contains(query.ToLower()) ||
                    item.Author.ToLower().Contains(query.ToLower())).ToList();

                suggestions.Clear();
                foreach (var item in filtered.Take(5))
                {
                    suggestions.Add(item);
                }
                
                showSuggestions = true;
                UpdateSuggestions();
            }
            else
            {
                suggestions.Clear();
                showSuggestions = false;
                HideSuggestions();
            }

            SearchButton.IsEnabled = !string.IsNullOrWhiteSpace(query) && !isLoading;
        }

        private void OnSearchKeyDown(object sender, KeyRoutedEventArgs e)
        {
            if (e.Key == Windows.System.VirtualKey.Enter)
            {
                PerformSearch();
                e.Handled = true;
            }
            else if (e.Key == Windows.System.VirtualKey.Escape)
            {
                HideSuggestions();
                e.Handled = true;
            }
            // MISSING: Arrow key navigation for suggestions
        }

        private void OnSearchButtonClicked(object sender, RoutedEventArgs e)
        {
            PerformSearch();
        }

        private void OnSuggestionSelected(object sender, SelectionChangedEventArgs e)
        {
            if (SuggestionsListView.SelectedItem is SearchResult selectedSuggestion)
            {
                SearchTextBox.Text = selectedSuggestion.Title;
                HideSuggestions();
                PerformSearch();
            }
        }

        private void UpdateSuggestions()
        {
            if (suggestions.Count > 0)
            {
                SuggestionsListView.Visibility = Visibility.Visible;
            }
            else
            {
                HideSuggestions();
            }
        }

        private void HideSuggestions()
        {
            SuggestionsListView.Visibility = Visibility.Collapsed;
        }

        private async void PerformSearch()
        {
            if (isLoading) return;

            string query = SearchTextBox.Text?.Trim();
            if (string.IsNullOrEmpty(query)) return;

            isLoading = true;
            SearchButton.IsEnabled = false;
            SearchButton.Content = "Searching...";

            // Hide all result states
            LoadingStackPanel.Visibility = Visibility.Visible;
            LoadingProgressRing.IsActive = true;
            ResultsCountTextBlock.Visibility = Visibility.Collapsed;
            ResultsListView.Visibility = Visibility.Collapsed;
            NoResultsTextBlock.Visibility = Visibility.Collapsed;
            HideSuggestions();

            // Simulate API call
            await Task.Delay(1000);

            var filtered = mockData.Where(item =>
                item.Title.ToLower().Contains(query.ToLower()) ||
                item.Category.ToLower().Contains(query.ToLower()) ||
                item.Author.ToLower().Contains(query.ToLower())).ToList();

            results.Clear();
            foreach (var item in filtered)
            {
                results.Add(item);
            }

            isLoading = false;
            SearchButton.IsEnabled = true;
            SearchButton.Content = "Search";
            LoadingStackPanel.Visibility = Visibility.Collapsed;
            LoadingProgressRing.IsActive = false;

            if (results.Count > 0)
            {
                ResultsCountTextBlock.Text = $"Found {results.Count} result{(results.Count == 1 ? "" : "s")}";
                ResultsCountTextBlock.Visibility = Visibility.Visible;
                ResultsListView.Visibility = Visibility.Visible;

                // MISSING: Screen reader announcement of results
                // Should announce "Found X results"
            }
            else
            {
                NoResultsTextBlock.Text = $"No results found for \"{query}\"";
                NoResultsTextBlock.Visibility = Visibility.Visible;

                // MISSING: Screen reader announcement of no results
                // Should announce "No results found"
            }
        }
    }

    public class SearchResult
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Category { get; set; }
        public string Author { get; set; }
    }
}