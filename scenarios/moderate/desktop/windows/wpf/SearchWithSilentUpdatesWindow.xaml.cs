using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
{
    public partial class SearchWithSilentUpdatesWindow : Window
    {
        private List<SearchResult> mockData;
        private List<SearchResult> suggestions;
        private List<SearchResult> results;
        private bool isLoading = false;
        public SearchWithSilentUpdatesWindow()
        {
            InitializeComponent();
            InitializeMockData();
        }
        private void InitializeMockData()
        {
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
        {
        }
        private void OnSearchInputChanged(object sender, TextChangedEventArgs e)
        {
            var query = SearchInput.Text;
            if (query.Length > 1)
            {
                var filtered = mockData.Where(item =>
                    item.Title.ToLower().Contains(query.ToLower()) ||
                    item.Category.ToLower().Contains(query.ToLower()) ||
                    item.Author.ToLower().Contains(query.ToLower())).ToList();
                suggestions = filtered.Take(5).ToList();
                SuggestionsList.ItemsSource = suggestions;
                SuggestionsList.Visibility = suggestions.Count > 0 ? Visibility.Visible : Visibility.Collapsed;
            }
            else
            {
                suggestions = new List<SearchResult>();
                SuggestionsList.ItemsSource = null;
                SuggestionsList.Visibility = Visibility.Collapsed;
            }
            // Update search button state
            SearchButton.IsEnabled = !string.IsNullOrWhiteSpace(query) && !isLoading;
        }
        private void OnSearchInputKeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                if (SuggestionsList.Visibility == Visibility.Visible && SuggestionsList.SelectedItem != null)
                {
                    var selectedSuggestion = SuggestionsList.SelectedItem as SearchResult;
                    SearchInput.Text = selectedSuggestion.Title;
                    SuggestionsList.Visibility = Visibility.Collapsed;
                    PerformSearch();
                }
                else
                {
                    PerformSearch();
                }
                e.Handled = true;
            }
            else if (e.Key == Key.Escape)
            {
                SuggestionsList.Visibility = Visibility.Collapsed;
                e.Handled = true;
            }
            else if (e.Key == Key.Down && SuggestionsList.Visibility == Visibility.Visible)
            {
                if (SuggestionsList.SelectedIndex < SuggestionsList.Items.Count - 1)
                {
                    SuggestionsList.SelectedIndex++;
                }
                else
                {
                    SuggestionsList.SelectedIndex = 0;
                }
                e.Handled = true;
            }
            else if (e.Key == Key.Up && SuggestionsList.Visibility == Visibility.Visible)
            {
                if (SuggestionsList.SelectedIndex > 0)
                {
                    SuggestionsList.SelectedIndex--;
                }
                else
                {
                    SuggestionsList.SelectedIndex = SuggestionsList.Items.Count - 1;
                }
                e.Handled = true;
            }
        }
        private void OnSuggestionSelected(object sender, SelectionChangedEventArgs e)
        {
            if (SuggestionsList.SelectedItem is SearchResult selectedSuggestion)
            {
                SearchInput.Text = selectedSuggestion.Title;
                SuggestionsList.Visibility = Visibility.Collapsed;
                PerformSearch();
            }
        }
        private void OnSearchButtonClicked(object sender, RoutedEventArgs e)
        {
            PerformSearch();
        }
        private async void PerformSearch()
        {
            if (isLoading) return;
            var query = SearchInput.Text.Trim();
            if (string.IsNullOrEmpty(query)) return;
            isLoading = true;
            SearchButton.IsEnabled = false;
            SearchButton.Content = "Searching...";
            // Hide all result panels
            LoadingPanel.Visibility = Visibility.Visible;
            ResultsCount.Visibility = Visibility.Collapsed;
            ResultsList.Visibility = Visibility.Collapsed;
            NoResultsPanel.Visibility = Visibility.Collapsed;
            EmptyPanel.Visibility = Visibility.Collapsed;
            // Simulate API call
            await Task.Delay(1000);
            var filtered = mockData.Where(item =>
                item.Title.ToLower().Contains(query.ToLower()) ||
                item.Category.ToLower().Contains(query.ToLower()) ||
                item.Author.ToLower().Contains(query.ToLower())).ToList();
            results = filtered;
            // Update UI
            LoadingPanel.Visibility = Visibility.Collapsed;
            SearchButton.Content = "Search";
            SearchButton.IsEnabled = true;
            isLoading = false;
            if (results.Count > 0)
            {
                ResultsCount.Text = $"Found {results.Count} result{(results.Count == 1 ? "" : "s")}";
                ResultsCount.Visibility = Visibility.Visible;
                ResultsList.ItemsSource = results;
                ResultsList.Visibility = Visibility.Visible;
            }
            else
            {
                NoResultsText.Text = $"No results found for \"{query}\"";
                NoResultsPanel.Visibility = Visibility.Visible;
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