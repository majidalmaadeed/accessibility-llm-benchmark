using UIComponents.Models;
using System.Collections.ObjectModel;

namespace UIComponents.Views;

public partial class DataTablePage : ContentPage
{
    public ObservableCollection<DataItem> DataItems { get; set; } = new();

    public DataTablePage()
    {
        InitializeComponent();
        BindingContext = this;
        LoadData();
    }

    private void LoadData()
    {
        DataItems.Clear();
        
        var categories = new[] { "Electronics", "Clothing", "Books", "Home", "Sports" };
        var statuses = new[] { "Active", "Inactive", "Pending", "Completed" };
        
        for (int i = 1; i <= 50; i++)
        {
            DataItems.Add(new DataItem
            {
                Id = i,
                Name = $"Item {i}",
                Category = categories[i % categories.Length],
                Status = statuses[i % statuses.Length],
                Value = new Random().Next(100, 1000),
                Date = DateTime.Now.AddDays(-new Random().Next(365)).ToString("yyyy-MM-dd"),
                Active = i % 3 == 0 ? "No" : "Yes"
            });
        }
        
        UpdateRowCount();
    }

    private void UpdateRowCount()
    {
        RowCountLabel.Text = $"Rows: {DataItems.Count}";
    }

    private void OnApplyFiltersClicked(object sender, EventArgs e)
    {
        // Filter logic would be implemented here
        DisplayAlert("Filters", "Filters applied successfully!", "OK");
    }

    private void OnResetFiltersClicked(object sender, EventArgs e)
    {
        SearchEntry.Text = "";
        CategoryPicker.SelectedIndex = 0;
        StatusPicker.SelectedIndex = 0;
        MinValueEntry.Text = "";
        MaxValueEntry.Text = "";
        ActiveOnlyCheckBox.IsChecked = false;
        
        LoadData();
    }

    private void OnAddRowClicked(object sender, EventArgs e)
    {
        var newItem = new DataItem
        {
            Id = DataItems.Count + 1,
            Name = "New Item",
            Category = "Electronics",
            Status = "Active",
            Value = 100,
            Date = DateTime.Now.ToString("yyyy-MM-dd"),
            Active = "Yes"
        };
        
        DataItems.Add(newItem);
        UpdateRowCount();
    }

    private void OnRemoveRowClicked(object sender, EventArgs e)
    {
        if (DataCollectionView.SelectedItems?.Count > 0)
        {
            var selectedItems = DataCollectionView.SelectedItems.Cast<DataItem>().ToList();
            foreach (var item in selectedItems)
            {
                DataItems.Remove(item);
            }
            UpdateRowCount();
        }
        else
        {
            DisplayAlert("Warning", "Please select items to remove.", "OK");
        }
    }

    private void OnClearAllClicked(object sender, EventArgs e)
    {
        var result = DisplayAlert("Clear All", "Are you sure you want to clear all data?", "Yes", "No");
        if (result)
        {
            DataItems.Clear();
            UpdateRowCount();
        }
    }

    private async void OnExportClicked(object sender, EventArgs e)
    {
        try
        {
            var file = await FilePicker.Default.PickAsync();
            if (file != null)
            {
                // Export logic would be implemented here
                await DisplayAlert("Export", "Data exported successfully!", "OK");
            }
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", $"Export failed: {ex.Message}", "OK");
        }
    }

    private async void OnImportClicked(object sender, EventArgs e)
    {
        try
        {
            var file = await FilePicker.Default.PickAsync();
            if (file != null)
            {
                // Import logic would be implemented here
                await DisplayAlert("Import", "Data imported successfully!", "OK");
            }
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", $"Import failed: {ex.Message}", "OK");
        }
    }
}
