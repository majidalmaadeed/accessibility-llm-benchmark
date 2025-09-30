using System;
using System.Collections.ObjectModel;
using System.ComponentModel;
using Xamarin.Forms;

namespace AccessibilityTest
{
    public partial class MissingTableHeader : ContentPage, INotifyPropertyChanged
    {
        private string _totalEmployees = "Total Employees: 6";
        private string _sortBy = "Sort by: Name";

        public ObservableCollection<EmployeeItem> Employees { get; set; }
        public string TotalEmployees
        {
            get => _totalEmployees;
            set
            {
                _totalEmployees = value;
                OnPropertyChanged(nameof(TotalEmployees));
            }
        }
        public string SortBy
        {
            get => _sortBy;
            set
            {
                _sortBy = value;
                OnPropertyChanged(nameof(SortBy));
            }
        }

        public MissingTableHeader()
        {
            InitializeComponent();
            BindingContext = this;
            
            // Initialize employee list
            Employees = new ObservableCollection<EmployeeItem>
            {
                new EmployeeItem
                {
                    Name = "John Smith",
                    Department = "Engineering",
                    Position = "Senior Developer",
                    Salary = "$95,000",
                    StartDate = "2022-01-15",
                    Status = "Active",
                    StatusColor = Color.Green,
                    Email = "john.smith@company.com",
                    Phone = "+1 (555) 123-4567",
                    Initials = "JS"
                },
                new EmployeeItem
                {
                    Name = "Sarah Johnson",
                    Department = "Marketing",
                    Position = "Marketing Manager",
                    Salary = "$78,000",
                    StartDate = "2021-08-22",
                    Status = "Active",
                    StatusColor = Color.Green,
                    Email = "sarah.johnson@company.com",
                    Phone = "+1 (555) 234-5678",
                    Initials = "SJ"
                },
                new EmployeeItem
                {
                    Name = "Mike Chen",
                    Department = "Sales",
                    Position = "Sales Director",
                    Salary = "$120,000",
                    StartDate = "2020-03-10",
                    Status = "Active",
                    StatusColor = Color.Green,
                    Email = "mike.chen@company.com",
                    Phone = "+1 (555) 345-6789",
                    Initials = "MC"
                },
                new EmployeeItem
                {
                    Name = "Emily Davis",
                    Department = "HR",
                    Position = "HR Specialist",
                    Salary = "$65,000",
                    StartDate = "2023-02-01",
                    Status = "Active",
                    StatusColor = Color.Green,
                    Email = "emily.davis@company.com",
                    Phone = "+1 (555) 456-7890",
                    Initials = "ED"
                },
                new EmployeeItem
                {
                    Name = "David Wilson",
                    Department = "Finance",
                    Position = "Financial Analyst",
                    Salary = "$72,000",
                    StartDate = "2022-11-05",
                    Status = "On Leave",
                    StatusColor = Color.Orange,
                    Email = "david.wilson@company.com",
                    Phone = "+1 (555) 567-8901",
                    Initials = "DW"
                },
                new EmployeeItem
                {
                    Name = "Lisa Brown",
                    Department = "Engineering",
                    Position = "Junior Developer",
                    Salary = "$55,000",
                    StartDate = "2023-06-12",
                    Status = "Active",
                    StatusColor = Color.Green,
                    Email = "lisa.brown@company.com",
                    Phone = "+1 (555) 678-9012",
                    Initials = "LB"
                }
            };
        }

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }

    public class EmployeeItem : INotifyPropertyChanged
    {
        public string Name { get; set; }
        public string Department { get; set; }
        public string Position { get; set; }
        public string Salary { get; set; }
        public string StartDate { get; set; }
        public string Status { get; set; }
        public Color StatusColor { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Initials { get; set; }

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
