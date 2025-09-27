namespace AccessibilityBenchmark.Views;

public partial class InteractiveMapPage : ContentPage
{
    public InteractiveMapPage()
    {
        InitializeComponent();
    }

    private void OnSearchClicked(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(LocationEntry.Text))
        {
            LocationLabel.Text = $"Searching for: {LocationEntry.Text}";
            DisplayAlert("Map", $"Searching for {LocationEntry.Text}", "OK");
        }
    }

    private void OnZoomInClicked(object sender, EventArgs e)
    {
        DisplayAlert("Map", "Zooming in", "OK");
    }

    private void OnZoomOutClicked(object sender, EventArgs e)
    {
        DisplayAlert("Map", "Zooming out", "OK");
    }
}
