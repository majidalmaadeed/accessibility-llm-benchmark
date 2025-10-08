using Microsoft.Maui.Controls;

namespace AccessibilityScenarios
{
    public partial class MissingTableHeader : ContentPage
    {
        public MissingTableHeader()
        {
            InitializeComponent();
        }
        
        private void OnAddEmployeeClicked(object sender, EventArgs e)
        {
            DisplayAlert("Add Employee", "Opening add employee form...", "OK");
        }
        
        private void OnExportClicked(object sender, EventArgs e)
        {
            DisplayAlert("Export", "Exporting employee data...", "OK");
        }
        
        private void OnEditClicked(object sender, EventArgs e)
        {
            DisplayAlert("Edit", "Opening edit form...", "OK");
        }
        
        private void OnViewClicked(object sender, EventArgs e)
        {
            DisplayAlert("View", "Showing employee details...", "OK");
        }
        
        private void OnPreviousPageClicked(object sender, EventArgs e)
        {
            DisplayAlert("Navigation", "Going to previous page...", "OK");
        }
        
        private void OnNextPageClicked(object sender, EventArgs e)
        {
            DisplayAlert("Navigation", "Going to next page...", "OK");
        }
    }
}

