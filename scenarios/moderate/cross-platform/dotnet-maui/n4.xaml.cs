using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Threading.Tasks;
{
    public partial class SearchWithSilentUpdatesPage : ContentPage
    {
        private ObservableCollection<SearchResult> suggestions;
        private ObservableCollection<SearchResult> results;
        private List<SearchResult> mockData;
        private bool isLoading = false;
        private bool showSuggestions = false;
        public SearchWithSilentUpdatesPage()
        {
            InitializeComponent();
            InitializeData();
        }
        private void InitializeData()
        {
            suggestions = new ObservableCollection<SearchResult>();
            results = new ObservableCollection<SearchResult>();
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
            SuggestionsCollectionView.ItemsSource = suggestions;
            ResultsCollectionView.ItemsSource = results;
        }
        {
        }
        private void OnSearchTextChanged(object sender, TextChangedEventArgs e)
        {
            string query = e.NewTextValue;
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
        private void OnSearchCompleted(object sender, EventArgs e)
        {
            PerformSearch();
        }
        private void OnSearchButtonClicked(object sender, EventArgs e)
        {
            PerformSearch();
        }
        private void OnSuggestionSelected(object sender, SelectionChangedEventArgs e)
        {
            if (e.CurrentSelection.Count > 0 && e.CurrentSelection[0] is SearchResult selectedSuggestion)
            {
                SearchEntry.Text = selectedSuggestion.Title;
                HideSuggestions();
                PerformSearch();
            }
        }
        private void UpdateSuggestions()
        {
            if (suggestions.Count > 0)
            {
                SuggestionsCollectionView.IsVisible = true;
            }
            else
            {
                HideSuggestions();
            }
        }
        private void HideSuggestions()
        {
            SuggestionsCollectionView.IsVisible = false;
        }
        private async void PerformSearch()
        {
            if (isLoading) return;
            string query = SearchEntry.Text?.Trim();
            if (string.IsNullOrEmpty(query)) return;
            isLoading = true;
            SearchButton.IsEnabled = false;
            SearchButton.Text = "Searching...";
            // Hide all result states
            LoadingStackLayout.IsVisible = true;
            LoadingIndicator.IsRunning = true;
            ResultsCollectionView.IsVisible = false;
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
            SearchButton.Text = "Search";
            LoadingStackLayout.IsVisible = false;
            LoadingIndicator.IsRunning = false;
            if (results.Count > 0)
            {
                ResultsCollectionView.IsVisible = true;
            }
            else
            {
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