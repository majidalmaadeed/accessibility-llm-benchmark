using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Threading.Tasks;
using Xamarin.Forms;

namespace UIComponents
{
    public partial class InteractiveMapPage : ContentPage
    {
        private string mapType = "standard";
        private double zoomLevel = 10;
        private double centerLat = 37.7749;
        private double centerLng = -122.4194;
        private string searchQuery = "";
        private List<MapLocation> searchResults = new List<MapLocation>();
        private bool showUserLocation = true;
        private bool showMapControls = true;
        private bool trafficEnabled = false;
        private bool transitEnabled = false;
        private bool bikeLanesEnabled = false;
        private List<MapLocation> bookmarks = new List<MapLocation>();

        public InteractiveMapPage()
        {
            InitializeComponent();
            BindingContext = this;
            UpdateMapDisplay();
        }

        public bool ShowUserLocation
        {
            get => showUserLocation;
            set
            {
                showUserLocation = value;
                OnPropertyChanged();
            }
        }

        public bool ShowMapControls
        {
            get => showMapControls;
            set
            {
                showMapControls = value;
                OnPropertyChanged();
            }
        }

        private void UpdateMapDisplay()
        {
            CoordinatesLabel.Text = $"{centerLat:F4}, {centerLng:F4}";
            ZoomLabel.Text = $"Zoom: {zoomLevel:F0}";
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
                return;
            }

            LoadingIndicator.IsVisible = true;
            LoadingIndicator.IsRunning = true;

            // Simulate API call
            await Task.Delay(1000);

            searchResults = GetSearchResults(searchQuery);
            
            if (searchResults.Any())
            {
                var firstResult = searchResults.First();
                centerLat = firstResult.Lat;
                centerLng = firstResult.Lng;
                UpdateMapDisplay();
                ShowLocationDetails(firstResult);
            }

            LoadingIndicator.IsVisible = false;
            LoadingIndicator.IsRunning = false;
        }

        private List<MapLocation> GetSearchResults(string query)
        {
            var sampleLocations = GetSampleLocations();
            return sampleLocations.Where(l => 
                l.Name.ToLower().Contains(query.ToLower()) ||
                l.Address.ToLower().Contains(query.ToLower()) ||
                l.Category.ToLower().Contains(query.ToLower())
            ).ToList();
        }

        private List<MapLocation> GetSampleLocations()
        {
            return new List<MapLocation>
            {
                new MapLocation
                {
                    Id = "1",
                    Name = "Golden Gate Bridge",
                    Address = "Golden Gate Bridge, San Francisco, CA",
                    Lat = 37.8199,
                    Lng = -122.4783,
                    Type = "landmark",
                    Rating = 4.8,
                    Description = "Famous suspension bridge spanning the Golden Gate strait.",
                    Category = "Tourist Attraction",
                    Price = 0,
                    Hours = "24/7",
                    Phone = "(415) 921-5858"
                },
                new MapLocation
                {
                    Id = "2",
                    Name = "Fisherman's Wharf",
                    Address = "Pier 39, San Francisco, CA",
                    Lat = 37.8087,
                    Lng = -122.4098,
                    Type = "attraction",
                    Rating = 4.2,
                    Description = "Popular tourist destination with shops, restaurants, and sea lions.",
                    Category = "Shopping & Dining",
                    Price = 0,
                    Hours = "9:00 AM - 10:00 PM",
                    Phone = "(415) 705-5500"
                },
                new MapLocation
                {
                    Id = "3",
                    Name = "Alcatraz Island",
                    Address = "Alcatraz Island, San Francisco, CA",
                    Lat = 37.8270,
                    Lng = -122.4230,
                    Type = "landmark",
                    Rating = 4.6,
                    Description = "Former federal prison, now a popular tourist attraction.",
                    Category = "Historical Site",
                    Price = 45,
                    Hours = "9:00 AM - 6:30 PM",
                    Phone = "(415) 561-4926"
                },
                new MapLocation
                {
                    Id = "4",
                    Name = "Lombard Street",
                    Address = "Lombard St, San Francisco, CA",
                    Lat = 37.8021,
                    Lng = -122.4187,
                    Type = "landmark",
                    Rating = 4.3,
                    Description = "Famous steep, winding street with eight hairpin turns.",
                    Category = "Tourist Attraction",
                    Price = 0,
                    Hours = "24/7",
                    Phone = "N/A"
                },
                new MapLocation
                {
                    Id = "5",
                    Name = "Union Square",
                    Address = "Union Square, San Francisco, CA",
                    Lat = 37.7880,
                    Lng = -122.4074,
                    Type = "shopping",
                    Rating = 4.1,
                    Description = "Major shopping and entertainment district in downtown San Francisco.",
                    Category = "Shopping District",
                    Price = 0,
                    Hours = "10:00 AM - 9:00 PM",
                    Phone = "N/A"
                }
            };
        }

        private void OnMapTypeChanged(object sender, EventArgs e)
        {
            if (sender is Button button && button.CommandParameter is string type)
            {
                mapType = type;
                // Update map type styling
                UpdateMapTypeButtons();
            }
        }

        private void UpdateMapTypeButtons()
        {
            // Reset all map type button colors
            var scrollView = Content as Grid;
            var mapTypeScrollView = scrollView.Children.OfType<ScrollView>().FirstOrDefault();
            if (mapTypeScrollView?.Content is StackLayout stackLayout)
            {
                foreach (var child in stackLayout.Children)
                {
                    if (child is Button button && button.CommandParameter is string type)
                    {
                        if (type == mapType)
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
        }

        private void OnMarkerClicked(object sender, EventArgs e)
        {
            if (sender is Button button && button.CommandParameter is string id)
            {
                var location = GetSampleLocations().FirstOrDefault(l => l.Id == id);
                if (location != null)
                {
                    centerLat = location.Lat;
                    centerLng = location.Lng;
                    UpdateMapDisplay();
                    ShowLocationDetails(location);
                }
            }
        }

        private async void ShowLocationDetails(MapLocation location)
        {
            var result = await DisplayAlert(
                location.Name,
                $"{location.Description}\n\nType: {location.Type}\nRating: {location.Rating}/5\nPrice: ${location.Price:C}\nHours: {location.Hours}\nPhone: {location.Phone}",
                "Close",
                "Get Directions"
            );

            if (result)
            {
                ShowDirections(location);
            }
        }

        private async void ShowDirections(MapLocation location)
        {
            await DisplayAlert("Directions", "Turn-by-turn directions would be displayed here", "OK");
        }

        private void OnZoomInClicked(object sender, EventArgs e)
        {
            zoomLevel = Math.Min(zoomLevel + 1, 20);
            UpdateMapDisplay();
        }

        private void OnZoomOutClicked(object sender, EventArgs e)
        {
            zoomLevel = Math.Max(zoomLevel - 1, 1);
            UpdateMapDisplay();
        }

        private void OnCenterMapClicked(object sender, EventArgs e)
        {
            centerLat = 37.7749;
            centerLng = -122.4194;
            UpdateMapDisplay();
        }

        private async void OnLayersClicked(object sender, EventArgs e)
        {
            var action = await DisplayActionSheet("Map Layers", "Cancel", null, 
                "Traffic", "Transit", "Bike Lanes", "User Location");
            
            switch (action)
            {
                case "Traffic":
                    trafficEnabled = !trafficEnabled;
                    await DisplayAlert("Traffic", trafficEnabled ? "Traffic layer enabled" : "Traffic layer disabled", "OK");
                    break;
                case "Transit":
                    transitEnabled = !transitEnabled;
                    await DisplayAlert("Transit", transitEnabled ? "Transit layer enabled" : "Transit layer disabled", "OK");
                    break;
                case "Bike Lanes":
                    bikeLanesEnabled = !bikeLanesEnabled;
                    await DisplayAlert("Bike Lanes", bikeLanesEnabled ? "Bike lanes enabled" : "Bike lanes disabled", "OK");
                    break;
                case "User Location":
                    ShowUserLocation = !ShowUserLocation;
                    break;
            }
        }

        private async void OnBookmarksClicked(object sender, EventArgs e)
        {
            if (bookmarks.Any())
            {
                var bookmarkNames = bookmarks.Select(b => b.Name).ToArray();
                var action = await DisplayActionSheet("Bookmarks", "Cancel", null, bookmarkNames);
                
                if (action != "Cancel")
                {
                    var bookmark = bookmarks.FirstOrDefault(b => b.Name == action);
                    if (bookmark != null)
                    {
                        centerLat = bookmark.Lat;
                        centerLng = bookmark.Lng;
                        UpdateMapDisplay();
                        ShowLocationDetails(bookmark);
                    }
                }
            }
            else
            {
                await DisplayAlert("Bookmarks", "No bookmarks yet", "OK");
            }
        }

        private void OnControlsClicked(object sender, EventArgs e)
        {
            ShowMapControls = !ShowMapControls;
        }

        public event PropertyChangedEventHandler PropertyChanged;
        protected virtual void OnPropertyChanged([System.Runtime.CompilerServices.CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }

    public class MapLocation
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public double Lat { get; set; }
        public double Lng { get; set; }
        public string Type { get; set; }
        public double Rating { get; set; }
        public string Description { get; set; }
        public string Category { get; set; }
        public double Price { get; set; }
        public string Hours { get; set; }
        public string Phone { get; set; }
    }
}
