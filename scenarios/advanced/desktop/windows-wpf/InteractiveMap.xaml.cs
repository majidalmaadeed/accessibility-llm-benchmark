using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Shapes;

namespace AccessibilityBenchmark
{
    public partial class InteractiveMap : Window
    {
        private List<MapLocation> allLocations;
        private List<MapLocation> searchResults;
        private List<MapLocation> bookmarks;
        private string currentMapType = "Standard";
        private double currentZoom = 10;
        private double centerLat = 37.7749;
        private double centerLng = -122.4194;
        private bool showUserLocation = true;
        private bool showMapControls = true;
        private bool trafficEnabled = false;
        private bool transitEnabled = false;
        private bool bikeLanesEnabled = false;
        
        public InteractiveMap()
        {
            InitializeComponent();
            allLocations = new List<MapLocation>();
            searchResults = new List<MapLocation>();
            bookmarks = new List<MapLocation>();
            LoadSampleData();
            SetupMapMarkers();
        }
        
        private void LoadSampleData()
        {
            allLocations.Add(new MapLocation
            {
                Id = "1",
                Name = "Golden Gate Bridge",
                Address = "Golden Gate Bridge, San Francisco, CA",
                Latitude = 37.8199,
                Longitude = -122.4783,
                Type = "landmark",
                Rating = 4.8,
                Description = "Famous suspension bridge spanning the Golden Gate strait.",
                Category = "Tourist Attraction",
                Price = 0.0,
                Hours = "24/7",
                Phone = "(415) 921-5858"
            });
            
            allLocations.Add(new MapLocation
            {
                Id = "2",
                Name = "Fisherman's Wharf",
                Address = "Pier 39, San Francisco, CA",
                Latitude = 37.8087,
                Longitude = -122.4098,
                Type = "attraction",
                Rating = 4.2,
                Description = "Popular tourist destination with shops, restaurants, and sea lions.",
                Category = "Shopping & Dining",
                Price = 0.0,
                Hours = "9:00 AM - 10:00 PM",
                Phone = "(415) 705-5500"
            });
            
            allLocations.Add(new MapLocation
            {
                Id = "3",
                Name = "Alcatraz Island",
                Address = "Alcatraz Island, San Francisco, CA",
                Latitude = 37.8270,
                Longitude = -122.4230,
                Type = "landmark",
                Rating = 4.6,
                Description = "Former federal prison, now a popular tourist attraction.",
                Category = "Historical Site",
                Price = 45.0,
                Hours = "9:00 AM - 6:30 PM",
                Phone = "(415) 561-4926"
            });
            
            allLocations.Add(new MapLocation
            {
                Id = "4",
                Name = "Lombard Street",
                Address = "Lombard St, San Francisco, CA",
                Latitude = 37.8021,
                Longitude = -122.4187,
                Type = "landmark",
                Rating = 4.3,
                Description = "Famous steep, winding street with eight hairpin turns.",
                Category = "Tourist Attraction",
                Price = 0.0,
                Hours = "24/7",
                Phone = "N/A"
            });
            
            allLocations.Add(new MapLocation
            {
                Id = "5",
                Name = "Union Square",
                Address = "Union Square, San Francisco, CA",
                Latitude = 37.7880,
                Longitude = -122.4074,
                Type = "shopping",
                Rating = 4.1,
                Description = "Major shopping and entertainment district in downtown San Francisco.",
                Category = "Shopping District",
                Price = 0.0,
                Hours = "10:00 AM - 9:00 PM",
                Phone = "N/A"
            });
        }
        
        private void SetupMapMarkers()
        {
            MapCanvas.Children.Clear();
            
            // Add location markers
            foreach (var location in allLocations)
            {
                AddMapMarker(location);
            }
            
            // Add user location marker
            if (showUserLocation)
            {
                AddUserLocationMarker();
            }
            
            UpdateMapInfo();
        }
        
        private void AddMapMarker(MapLocation location)
        {
            var marker = new Button
            {
                Content = GetLocationIcon(location.Type),
                Width = 30,
                Height = 30,
                FontSize = 16,
                Background = GetCategoryColor(location.Type),
                Foreground = Brushes.White,
                BorderThickness = new Thickness(2),
                BorderBrush = Brushes.White,
                Cursor = Cursors.Hand
            };
            
            marker.Click += (s, e) => ShowLocationDetails(location);
            
            // Position marker (simplified positioning for demo)
            var x = GetMarkerX(location.Longitude);
            var y = GetMarkerY(location.Latitude);
            
            Canvas.SetLeft(marker, x);
            Canvas.SetTop(marker, y);
            
            MapCanvas.Children.Add(marker);
        }
        
        private void AddUserLocationMarker()
        {
            var userMarker = new Ellipse
            {
                Width = 20,
                Height = 20,
                Fill = Brushes.Blue,
                Stroke = Brushes.White,
                StrokeThickness = 2
            };
            
            Canvas.SetLeft(userMarker, 200);
            Canvas.SetTop(userMarker, 200);
            
            MapCanvas.Children.Add(userMarker);
        }
        
        private string GetLocationIcon(string type)
        {
            switch (type)
            {
                case "landmark": return "🏛️";
                case "attraction": return "🎡";
                case "shopping": return "🛍️";
                case "restaurant": return "🍽️";
                case "hotel": return "🏨";
                default: return "📍";
            }
        }
        
        private Brush GetCategoryColor(string type)
        {
            switch (type)
            {
                case "landmark": return Brushes.Red;
                case "attraction": return Brushes.Orange;
                case "shopping": return Brushes.Green;
                case "restaurant": return Brushes.Blue;
                case "hotel": return Brushes.Purple;
                default: return Brushes.Gray;
            }
        }
        
        private double GetMarkerX(double longitude)
        {
            // Simplified positioning for demo
            return (longitude + 122.5) * 200;
        }
        
        private double GetMarkerY(double latitude)
        {
            // Simplified positioning for demo
            return (37.8 - latitude) * 200;
        }
        
        private void UpdateMapInfo()
        {
            var mapTypeText = currentMapType;
            MapInfoText.Text = $"🗺️ {mapTypeText} Map\n{centerLat:F4}, {centerLng:F4}\nZoom: {currentZoom:F0}";
            CoordinatesText.Text = $"Lat: {centerLat:F4}, Lng: {centerLng:F4}";
        }
        
        private void SearchTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            PerformSearch();
        }
        
        private void SearchButton_Click(object sender, RoutedEventArgs e)
        {
            PerformSearch();
        }
        
        private void PerformSearch()
        {
            var query = SearchTextBox.Text.ToLower();
            
            if (string.IsNullOrEmpty(query))
            {
                SearchResultsListBox.ItemsSource = null;
                SearchResultsListBox.Visibility = Visibility.Collapsed;
                return;
            }
            
            searchResults = allLocations.Where(l => 
                l.Name.ToLower().Contains(query) ||
                l.Address.ToLower().Contains(query) ||
                l.Category.ToLower().Contains(query)
            ).ToList();
            
            SearchResultsListBox.ItemsSource = searchResults;
            SearchResultsListBox.Visibility = Visibility.Visible;
            
            StatusText.Text = $"Found {searchResults.Count} results";
        }
        
        private void SearchResultsListBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (SearchResultsListBox.SelectedItem is MapLocation selectedLocation)
            {
                ShowLocationDetails(selectedLocation);
            }
        }
        
        private void ShowLocationDetails(MapLocation location)
        {
            LocationDetailsPanel.Children.Clear();
            
            var nameText = new TextBlock
            {
                Text = location.Name,
                FontWeight = FontWeights.Bold,
                FontSize = 16,
                Margin = new Thickness(0, 0, 0, 10)
            };
            LocationDetailsPanel.Children.Add(nameText);
            
            var descriptionText = new TextBlock
            {
                Text = location.Description,
                FontSize = 12,
                TextWrapping = TextWrapping.Wrap,
                Margin = new Thickness(0, 0, 0, 10)
            };
            LocationDetailsPanel.Children.Add(descriptionText);
            
            var detailsStack = new StackPanel();
            
            var typeText = new TextBlock
            {
                Text = $"Type: {location.Type}",
                FontSize = 11,
                Margin = new Thickness(0, 0, 0, 5)
            };
            detailsStack.Children.Add(typeText);
            
            var ratingText = new TextBlock
            {
                Text = $"Rating: {location.Rating:F1}/5",
                FontSize = 11,
                Margin = new Thickness(0, 0, 0, 5)
            };
            detailsStack.Children.Add(ratingText);
            
            var priceText = new TextBlock
            {
                Text = $"Price: {(location.Price > 0 ? $"${location.Price:F0}" : "Free")}",
                FontSize = 11,
                Margin = new Thickness(0, 0, 0, 5)
            };
            detailsStack.Children.Add(priceText);
            
            var hoursText = new TextBlock
            {
                Text = $"Hours: {location.Hours}",
                FontSize = 11,
                Margin = new Thickness(0, 0, 0, 5)
            };
            detailsStack.Children.Add(hoursText);
            
            if (!string.IsNullOrEmpty(location.Phone) && location.Phone != "N/A")
            {
                var phoneText = new TextBlock
                {
                    Text = $"Phone: {location.Phone}",
                    FontSize = 11,
                    Margin = new Thickness(0, 0, 0, 5)
                };
                detailsStack.Children.Add(phoneText);
            }
            
            LocationDetailsPanel.Children.Add(detailsStack);
        }
        
        private void MyLocationButton_Click(object sender, RoutedEventArgs e)
        {
            centerLat = 37.7749;
            centerLng = -122.4194;
            currentZoom = 10;
            UpdateMapInfo();
            StatusText.Text = "Centered on your location";
        }
        
        private void MapTypeComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (MapTypeComboBox.SelectedItem is ComboBoxItem selectedItem)
            {
                currentMapType = selectedItem.Content.ToString();
                UpdateMapInfo();
                StatusText.Text = $"Map type changed to {currentMapType}";
            }
        }
        
        private void LayersButton_Click(object sender, RoutedEventArgs e)
        {
            var layersDialog = new LayersDialog();
            if (layersDialog.ShowDialog() == true)
            {
                trafficEnabled = layersDialog.TrafficEnabled;
                transitEnabled = layersDialog.TransitEnabled;
                bikeLanesEnabled = layersDialog.BikeLanesEnabled;
                showUserLocation = layersDialog.UserLocationEnabled;
                
                SetupMapMarkers();
                StatusText.Text = "Map layers updated";
            }
        }
        
        private void BookmarksButton_Click(object sender, RoutedEventArgs e)
        {
            if (bookmarks.Count == 0)
            {
                MessageBox.Show("No bookmarks yet.\nBookmark locations to see them here.", 
                              "Bookmarks", MessageBoxButton.OK, MessageBoxImage.Information);
            }
            else
            {
                var bookmarkDialog = new BookmarksDialog(bookmarks);
                if (bookmarkDialog.ShowDialog() == true)
                {
                    var selectedBookmark = bookmarkDialog.SelectedBookmark;
                    if (selectedBookmark != null)
                    {
                        ShowLocationDetails(selectedBookmark);
                    }
                }
            }
        }
        
        private void ZoomInButton_Click(object sender, RoutedEventArgs e)
        {
            currentZoom = Math.Min(currentZoom + 1, 20);
            UpdateMapInfo();
        }
        
        private void ZoomOutButton_Click(object sender, RoutedEventArgs e)
        {
            currentZoom = Math.Max(currentZoom - 1, 1);
            UpdateMapInfo();
        }
        
        private void CenterButton_Click(object sender, RoutedEventArgs e)
        {
            centerLat = 37.7749;
            centerLng = -122.4194;
            currentZoom = 10;
            UpdateMapInfo();
            StatusText.Text = "Map centered";
        }
        
        private void GetDirectionsButton_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Turn-by-turn directions would be displayed here.", 
                          "Get Directions", MessageBoxButton.OK, MessageBoxImage.Information);
        }
        
        private void ShareLocationButton_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Location sharing options would be displayed here.", 
                          "Share Location", MessageBoxButton.OK, MessageBoxImage.Information);
        }
        
        private void SaveLocationButton_Click(object sender, RoutedEventArgs e)
        {
            if (SearchResultsListBox.SelectedItem is MapLocation selectedLocation)
            {
                if (!bookmarks.Contains(selectedLocation))
                {
                    bookmarks.Add(selectedLocation);
                    MessageBox.Show($"Location '{selectedLocation.Name}' bookmarked!", 
                                  "Bookmark", MessageBoxButton.OK, MessageBoxImage.Information);
                }
                else
                {
                    MessageBox.Show("Location already bookmarked.", 
                                  "Bookmark", MessageBoxButton.OK, MessageBoxImage.Information);
                }
            }
            else
            {
                MessageBox.Show("Please select a location first.", 
                              "Bookmark", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
        }
        
        private void ReportIssueButton_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Report issue form would be displayed here.", 
                          "Report Issue", MessageBoxButton.OK, MessageBoxImage.Information);
        }
    }
    
    public class MapLocation
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public string Type { get; set; }
        public double Rating { get; set; }
        public string Description { get; set; }
        public string Category { get; set; }
        public double Price { get; set; }
        public string Hours { get; set; }
        public string Phone { get; set; }
    }
    
    public partial class LayersDialog : Window
    {
        public bool TrafficEnabled { get; set; }
        public bool TransitEnabled { get; set; }
        public bool BikeLanesEnabled { get; set; }
        public bool UserLocationEnabled { get; set; }
        
        public LayersDialog()
        {
            Title = "Map Layers";
            Width = 300;
            Height = 250;
            WindowStartupLocation = WindowStartupLocation.CenterOwner;
            
            var grid = new Grid();
            grid.RowDefinitions.Add(new RowDefinition { Height = new GridLength(1, GridUnitType.Star) });
            grid.RowDefinitions.Add(new RowDefinition { Height = GridLength.Auto });
            
            var stackPanel = new StackPanel { Margin = new Thickness(20) };
            
            var trafficCheckBox = new CheckBox { Content = "Traffic", Margin = new Thickness(0, 5) };
            var transitCheckBox = new CheckBox { Content = "Transit", Margin = new Thickness(0, 5) };
            var bikeLanesCheckBox = new CheckBox { Content = "Bike Lanes", Margin = new Thickness(0, 5) };
            var userLocationCheckBox = new CheckBox { Content = "User Location", Margin = new Thickness(0, 5), IsChecked = true };
            
            stackPanel.Children.Add(trafficCheckBox);
            stackPanel.Children.Add(transitCheckBox);
            stackPanel.Children.Add(bikeLanesCheckBox);
            stackPanel.Children.Add(userLocationCheckBox);
            
            grid.Children.Add(stackPanel);
            Grid.SetRow(stackPanel, 0);
            
            var buttonPanel = new StackPanel { Orientation = Orientation.Horizontal, HorizontalAlignment = HorizontalAlignment.Right, Margin = new Thickness(20) };
            var okButton = new Button { Content = "Apply", Width = 80, Height = 30, Margin = new Thickness(5) };
            var cancelButton = new Button { Content = "Cancel", Width = 80, Height = 30, Margin = new Thickness(5) };
            
            okButton.Click += (s, e) => 
            {
                TrafficEnabled = trafficCheckBox.IsChecked == true;
                TransitEnabled = transitCheckBox.IsChecked == true;
                BikeLanesEnabled = bikeLanesCheckBox.IsChecked == true;
                UserLocationEnabled = userLocationCheckBox.IsChecked == true;
                DialogResult = true;
                Close();
            };
            cancelButton.Click += (s, e) => { DialogResult = false; Close(); };
            
            buttonPanel.Children.Add(okButton);
            buttonPanel.Children.Add(cancelButton);
            grid.Children.Add(buttonPanel);
            Grid.SetRow(buttonPanel, 1);
            
            Content = grid;
        }
    }
    
    public partial class BookmarksDialog : Window
    {
        public MapLocation SelectedBookmark { get; set; }
        
        public BookmarksDialog(List<MapLocation> bookmarks)
        {
            Title = "Bookmarks";
            Width = 400;
            Height = 300;
            WindowStartupLocation = WindowStartupLocation.CenterOwner;
            
            var grid = new Grid();
            grid.RowDefinitions.Add(new RowDefinition { Height = new GridLength(1, GridUnitType.Star) });
            grid.RowDefinitions.Add(new RowDefinition { Height = GridLength.Auto });
            
            var listBox = new ListBox { Margin = new Thickness(20) };
            listBox.ItemsSource = bookmarks;
            listBox.DisplayMemberPath = "Name";
            listBox.SelectionChanged += (s, e) => 
            {
                SelectedBookmark = listBox.SelectedItem as MapLocation;
            };
            
            grid.Children.Add(listBox);
            Grid.SetRow(listBox, 0);
            
            var buttonPanel = new StackPanel { Orientation = Orientation.Horizontal, HorizontalAlignment = HorizontalAlignment.Right, Margin = new Thickness(20) };
            var okButton = new Button { Content = "OK", Width = 80, Height = 30, Margin = new Thickness(5) };
            var cancelButton = new Button { Content = "Cancel", Width = 80, Height = 30, Margin = new Thickness(5) };
            
            okButton.Click += (s, e) => { DialogResult = true; Close(); };
            cancelButton.Click += (s, e) => { DialogResult = false; Close(); };
            
            buttonPanel.Children.Add(okButton);
            buttonPanel.Children.Add(cancelButton);
            grid.Children.Add(buttonPanel);
            Grid.SetRow(buttonPanel, 1);
            
            Content = grid;
        }
    }
}
