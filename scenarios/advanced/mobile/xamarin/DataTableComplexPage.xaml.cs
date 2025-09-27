using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Xamarin.Forms;

namespace AccessibilityBenchmark
{
    public partial class DataTableComplexPage : ContentPage
    {
        private List<Employee> _employees = new List<Employee>();
        private List<Employee> _filteredEmployees = new List<Employee>();
        private List<Employee> _currentPageEmployees = new List<Employee>();
        private HashSet<string> _selectedRows = new HashSet<string>();
        private string _searchQuery = "";
        private string _sortColumn = "name";
        private bool _sortAscending = true;
        private int _currentPage = 1;
        private int _itemsPerPage = 10;
        private bool _isLoading = false;

        public DataTableComplexPage()
        {
            InitializeComponent();
            LoadSampleData();
            UpdateDisplay();
        }

        private void LoadSampleData()
        {
            _employees = new List<Employee>
            {
                new Employee { Id = "1", Name = "John Doe", Email = "john@example.com", Department = "Engineering", Salary = 75000, Status = "Active", JoinDate = "2023-01-15" },
                new Employee { Id = "2", Name = "Jane Smith", Email = "jane@example.com", Department = "Marketing", Salary = 65000, Status = "Active", JoinDate = "2023-02-20" },
                new Employee { Id = "3", Name = "Mike Johnson", Email = "mike@example.com", Department = "Sales", Salary = 70000, Status = "Inactive", JoinDate = "2023-03-10" },
                new Employee { Id = "4", Name = "Sarah Wilson", Email = "sarah@example.com", Department = "HR", Salary = 60000, Status = "Active", JoinDate = "2023-04-05" },
                new Employee { Id = "5", Name = "David Brown", Email = "david@example.com", Department = "Finance", Salary = 80000, Status = "Active", JoinDate = "2023-05-12" },
                new Employee { Id = "6", Name = "Lisa Davis", Email = "lisa@example.com", Department = "Engineering", Salary = 72000, Status = "Active", JoinDate = "2023-06-18" },
                new Employee { Id = "7", Name = "Tom Miller", Email = "tom@example.com", Department = "Marketing", Salary = 68000, Status = "Inactive", JoinDate = "2023-07-22" },
                new Employee { Id = "8", Name = "Amy Garcia", Email = "amy@example.com", Department = "Sales", Salary = 69000, Status = "Active", JoinDate = "2023-08-30" },
                new Employee { Id = "9", Name = "Chris Lee", Email = "chris@example.com", Department = "HR", Salary = 62000, Status = "Active", JoinDate = "2023-09-14" },
                new Employee { Id = "10", Name = "Emma Taylor", Email = "emma@example.com", Department = "Finance", Salary = 78000, Status = "Active", JoinDate = "2023-10-08" }
            };
        }

        private void UpdateDisplay()
        {
            ApplyFilters();
            SortData();
            UpdatePagination();
            UpdateTableRows();
            UpdateBulkActions();
            UpdatePaginationInfo();
        }

        private void ApplyFilters()
        {
            _filteredEmployees = _employees.Where(emp =>
                (string.IsNullOrEmpty(_searchQuery) || 
                 emp.Name.ToLower().Contains(_searchQuery.ToLower()) ||
                 emp.Email.ToLower().Contains(_searchQuery.ToLower())) &&
                (DepartmentPicker.SelectedIndex == 0 || 
                 emp.Department == DepartmentPicker.Items[DepartmentPicker.SelectedIndex]) &&
                (StatusPicker.SelectedIndex == 0 || 
                 emp.Status == StatusPicker.Items[StatusPicker.SelectedIndex])
            ).ToList();
        }

        private void SortData()
        {
            _filteredEmployees = _sortColumn switch
            {
                "name" => _sortAscending 
                    ? _filteredEmployees.OrderBy(e => e.Name).ToList()
                    : _filteredEmployees.OrderByDescending(e => e.Name).ToList(),
                "email" => _sortAscending 
                    ? _filteredEmployees.OrderBy(e => e.Email).ToList()
                    : _filteredEmployees.OrderByDescending(e => e.Email).ToList(),
                "department" => _sortAscending 
                    ? _filteredEmployees.OrderBy(e => e.Department).ToList()
                    : _filteredEmployees.OrderByDescending(e => e.Department).ToList(),
                "salary" => _sortAscending 
                    ? _filteredEmployees.OrderBy(e => e.Salary).ToList()
                    : _filteredEmployees.OrderByDescending(e => e.Salary).ToList(),
                "status" => _sortAscending 
                    ? _filteredEmployees.OrderBy(e => e.Status).ToList()
                    : _filteredEmployees.OrderByDescending(e => e.Status).ToList(),
                _ => _filteredEmployees
            };
        }

        private void UpdatePagination()
        {
            var startIndex = (_currentPage - 1) * _itemsPerPage;
            var endIndex = Math.Min(startIndex + _itemsPerPage, _filteredEmployees.Count);
            _currentPageEmployees = _filteredEmployees.Skip(startIndex).Take(_itemsPerPage).ToList();
        }

        private void UpdateTableRows()
        {
            TableRowsContainer.Children.Clear();

            if (_filteredEmployees.Count == 0)
            {
                EmptyStateStackLayout.IsVisible = true;
                DataScrollView.IsVisible = false;
                return;
            }

            EmptyStateStackLayout.IsVisible = false;
            DataScrollView.IsVisible = true;

            foreach (var employee in _currentPageEmployees)
            {
                var rowFrame = new Frame
                {
                    BackgroundColor = _selectedRows.Contains(employee.Id) ? Color.FromHex("#E3F2FD") : Color.White,
                    HasShadow = false,
                    Margin = new Thickness(16, 0, 16, 4)
                };

                var rowGrid = new Grid();
                rowGrid.ColumnDefinitions.Add(new ColumnDefinition { Width = new GridLength(1, GridUnitType.Auto) });
                rowGrid.ColumnDefinitions.Add(new ColumnDefinition { Width = new GridLength(1, GridUnitType.Star) });
                rowGrid.ColumnDefinitions.Add(new ColumnDefinition { Width = new GridLength(1, GridUnitType.Star) });
                rowGrid.ColumnDefinitions.Add(new ColumnDefinition { Width = new GridLength(1, GridUnitType.Star) });
                rowGrid.ColumnDefinitions.Add(new ColumnDefinition { Width = new GridLength(1, GridUnitType.Star) });
                rowGrid.ColumnDefinitions.Add(new ColumnDefinition { Width = new GridLength(1, GridUnitType.Star) });
                rowGrid.ColumnDefinitions.Add(new ColumnDefinition { Width = new GridLength(1, GridUnitType.Auto) });

                // Checkbox
                var checkbox = new CheckBox
                {
                    IsChecked = _selectedRows.Contains(employee.Id)
                };
                checkbox.CheckedChanged += (s, e) => OnRowSelectionChanged(employee.Id, e.Value);
                Grid.SetColumn(checkbox, 0);
                rowGrid.Children.Add(checkbox);

                // Name
                var nameLabel = new Label
                {
                    Text = employee.Name,
                    VerticalOptions = LayoutOptions.Center
                };
                Grid.SetColumn(nameLabel, 1);
                rowGrid.Children.Add(nameLabel);

                // Email
                var emailLabel = new Label
                {
                    Text = employee.Email,
                    TextColor = Color.FromHex("#007AFF"),
                    VerticalOptions = LayoutOptions.Center
                };
                Grid.SetColumn(emailLabel, 2);
                rowGrid.Children.Add(emailLabel);

                // Department
                var departmentLabel = new Label
                {
                    Text = employee.Department,
                    VerticalOptions = LayoutOptions.Center
                };
                Grid.SetColumn(departmentLabel, 3);
                rowGrid.Children.Add(departmentLabel);

                // Salary
                var salaryLabel = new Label
                {
                    Text = $"${employee.Salary:C0}",
                    VerticalOptions = LayoutOptions.Center
                };
                Grid.SetColumn(salaryLabel, 4);
                rowGrid.Children.Add(salaryLabel);

                // Status
                var statusFrame = new Frame
                {
                    BackgroundColor = employee.Status == "Active" ? Color.Green : Color.Red,
                    HasShadow = false,
                    Padding = new Thickness(8, 4),
                    CornerRadius = 12
                };
                var statusLabel = new Label
                {
                    Text = employee.Status,
                    TextColor = Color.White,
                    FontSize = 12,
                    FontAttributes = FontAttributes.Bold
                };
                statusFrame.Content = statusLabel;
                Grid.SetColumn(statusFrame, 5);
                rowGrid.Children.Add(statusFrame);

                // Actions
                var actionsStack = new StackLayout
                {
                    Orientation = StackOrientation.Horizontal,
                    HorizontalOptions = LayoutOptions.Center
                };

                var viewButton = new Button
                {
                    Text = "👁",
                    BackgroundColor = Color.Transparent,
                    TextColor = Color.FromHex("#007AFF"),
                    FontSize = 16
                };
                viewButton.Clicked += (s, e) => OnViewClicked(employee.Id);

                var editButton = new Button
                {
                    Text = "✏",
                    BackgroundColor = Color.Transparent,
                    TextColor = Color.FromHex("#007AFF"),
                    FontSize = 16
                };
                editButton.Clicked += (s, e) => OnEditClicked(employee.Id);

                var deleteButton = new Button
                {
                    Text = "🗑",
                    BackgroundColor = Color.Transparent,
                    TextColor = Color.Red,
                    FontSize = 16
                };
                deleteButton.Clicked += (s, e) => OnDeleteClicked(employee.Id);

                actionsStack.Children.Add(viewButton);
                actionsStack.Children.Add(editButton);
                actionsStack.Children.Add(deleteButton);

                Grid.SetColumn(actionsStack, 6);
                rowGrid.Children.Add(actionsStack);

                rowFrame.Content = rowGrid;
                TableRowsContainer.Children.Add(rowFrame);
            }
        }

        private void UpdateBulkActions()
        {
            BulkActionsFrame.IsVisible = _selectedRows.Count > 0;
            BulkActionsLabel.Text = $"{_selectedRows.Count} item{(_selectedRows.Count == 1 ? "" : "s")} selected";
        }

        private void UpdatePaginationInfo()
        {
            var startItem = (_currentPage - 1) * _itemsPerPage + 1;
            var endItem = Math.Min(_currentPage * _itemsPerPage, _filteredEmployees.Count);
            PaginationLabel.Text = $"Showing {startItem}-{endItem} of {_filteredEmployees.Count} results";

            var totalPages = (int)Math.Ceiling((double)_filteredEmployees.Count / _itemsPerPage);
            PageLabel.Text = $"Page {_currentPage} of {totalPages}";
        }

        private async void OnSearchTextChanged(object sender, TextChangedEventArgs e)
        {
            _searchQuery = e.NewTextValue;
            UpdateDisplay();
        }

        private void OnFilterClicked(object sender, EventArgs e)
        {
            FiltersFrame.IsVisible = !FiltersFrame.IsVisible;
        }

        private void OnExportClicked(object sender, EventArgs e)
        {
            DisplayAlert("Export", "Exporting data as CSV...", "OK");
        }

        private async void OnRefreshClicked(object sender, EventArgs e)
        {
            _isLoading = true;
            LoadingIndicator.IsVisible = true;
            LoadingIndicator.IsRunning = true;

            await Task.Delay(1000); // Simulate API call

            _isLoading = false;
            LoadingIndicator.IsVisible = false;
            LoadingIndicator.IsRunning = false;

            UpdateDisplay();
        }

        private void OnDepartmentChanged(object sender, EventArgs e)
        {
            UpdateDisplay();
        }

        private void OnStatusChanged(object sender, EventArgs e)
        {
            UpdateDisplay();
        }

        private void OnClearFiltersClicked(object sender, EventArgs e)
        {
            _searchQuery = "";
            SearchEntry.Text = "";
            DepartmentPicker.SelectedIndex = 0;
            StatusPicker.SelectedIndex = 0;
            FiltersFrame.IsVisible = false;
            UpdateDisplay();
        }

        private void OnSortClicked(object sender, EventArgs e)
        {
            var button = sender as Button;
            var column = button.CommandParameter.ToString();

            if (_sortColumn == column)
            {
                _sortAscending = !_sortAscending;
            }
            else
            {
                _sortColumn = column;
                _sortAscending = true;
            }

            UpdateDisplay();
        }

        private void OnSelectAllChanged(object sender, CheckedChangedEventArgs e)
        {
            if (e.Value)
            {
                foreach (var employee in _currentPageEmployees)
                {
                    _selectedRows.Add(employee.Id);
                }
            }
            else
            {
                foreach (var employee in _currentPageEmployees)
                {
                    _selectedRows.Remove(employee.Id);
                }
            }

            UpdateTableRows();
            UpdateBulkActions();
        }

        private void OnRowSelectionChanged(string employeeId, bool isSelected)
        {
            if (isSelected)
            {
                _selectedRows.Add(employeeId);
            }
            else
            {
                _selectedRows.Remove(employeeId);
            }

            UpdateBulkActions();
        }

        private void OnViewClicked(string employeeId)
        {
            DisplayAlert("View", $"View details for employee {employeeId}", "OK");
        }

        private void OnEditClicked(string employeeId)
        {
            DisplayAlert("Edit", $"Edit employee {employeeId}", "OK");
        }

        private async void OnDeleteClicked(string employeeId)
        {
            var result = await DisplayAlert("Delete", $"Are you sure you want to delete employee {employeeId}?", "Yes", "No");
            if (result)
            {
                _employees.RemoveAll(e => e.Id == employeeId);
                _selectedRows.Remove(employeeId);
                UpdateDisplay();
            }
        }

        private void OnBulkEditClicked(object sender, EventArgs e)
        {
            if (_selectedRows.Count == 0)
            {
                DisplayAlert("No Selection", "Please select items to perform bulk actions", "OK");
                return;
            }
            DisplayAlert("Bulk Action", $"Edit {_selectedRows.Count} selected items", "OK");
        }

        private async void OnBulkDeleteClicked(object sender, EventArgs e)
        {
            if (_selectedRows.Count == 0)
            {
                await DisplayAlert("No Selection", "Please select items to perform bulk actions", "OK");
                return;
            }

            var result = await DisplayAlert("Bulk Delete", $"Are you sure you want to delete {_selectedRows.Count} selected items?", "Yes", "No");
            if (result)
            {
                _employees.RemoveAll(e => _selectedRows.Contains(e.Id));
                _selectedRows.Clear();
                UpdateDisplay();
            }
        }

        private void OnBulkExportClicked(object sender, EventArgs e)
        {
            if (_selectedRows.Count == 0)
            {
                DisplayAlert("No Selection", "Please select items to perform bulk actions", "OK");
                return;
            }
            DisplayAlert("Bulk Action", $"Export {_selectedRows.Count} selected items", "OK");
        }

        private void OnPreviousPageClicked(object sender, EventArgs e)
        {
            if (_currentPage > 1)
            {
                _currentPage--;
                UpdateDisplay();
            }
        }

        private void OnNextPageClicked(object sender, EventArgs e)
        {
            var totalPages = (int)Math.Ceiling((double)_filteredEmployees.Count / _itemsPerPage);
            if (_currentPage < totalPages)
            {
                _currentPage++;
                UpdateDisplay();
            }
        }

        private void OnItemsPerPageChanged(object sender, EventArgs e)
        {
            var picker = sender as Picker;
            _itemsPerPage = int.Parse(picker.Items[picker.SelectedIndex]);
            _currentPage = 1;
            UpdateDisplay();
        }
    }

    public class Employee
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string Department { get; set; }
        public decimal Salary { get; set; }
        public string Status { get; set; }
        public string JoinDate { get; set; }
    }
}
