using AccessibilityBenchmark.Views;

namespace AccessibilityBenchmark.Views;

public partial class MainPage : ContentPage
{
    public MainPage()
    {
        InitializeComponent();
    }

    private async void OnDataTableClicked(object sender, EventArgs e)
    {
        await Shell.Current.GoToAsync("//DataTablePage");
    }

    private async void OnWizardClicked(object sender, EventArgs e)
    {
        await Shell.Current.GoToAsync("//WizardPage");
    }

    private async void OnDashboardClicked(object sender, EventArgs e)
    {
        await Shell.Current.GoToAsync("//DashboardPage");
    }

    private async void OnMediaPlayerClicked(object sender, EventArgs e)
    {
        await Shell.Current.GoToAsync("//MediaPlayerPage");
    }

    private async void OnShoppingCartClicked(object sender, EventArgs e)
    {
        await Shell.Current.GoToAsync("//ShoppingCartPage");
    }

    private async void OnCalendarClicked(object sender, EventArgs e)
    {
        await Shell.Current.GoToAsync("//CalendarPage");
    }

    private async void OnRichTextEditorClicked(object sender, EventArgs e)
    {
        await Shell.Current.GoToAsync("//RichTextEditorPage");
    }

    private async void OnSearchInterfaceClicked(object sender, EventArgs e)
    {
        await Shell.Current.GoToAsync("//SearchInterfacePage");
    }

    private async void OnInteractiveMapClicked(object sender, EventArgs e)
    {
        await Shell.Current.GoToAsync("//InteractiveMapPage");
    }

    private async void OnSocialFeedClicked(object sender, EventArgs e)
    {
        await Shell.Current.GoToAsync("//SocialFeedPage");
    }
}
