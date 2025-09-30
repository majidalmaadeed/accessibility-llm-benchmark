using Microsoft.Maui.Controls;

namespace AccessibilityScenarios
{
    public partial class AutoPlayingBackgroundVideo : ContentPage
    {
        public AutoPlayingBackgroundVideo()
        {
            InitializeComponent();
        }
        
        private void OnGetStartedClicked(object sender, EventArgs e)
        {
            DisplayAlert("Get Started", "Redirecting to sign up page...", "OK");
        }
        
        private void OnWatchDemoClicked(object sender, EventArgs e)
        {
            DisplayAlert("Watch Demo", "Opening demo video...", "OK");
        }
        
        private void OnLearnMoreClicked(object sender, EventArgs e)
        {
            DisplayAlert("Learn More", "Opening service details...", "OK");
        }
        
        private void OnViewCaseStudiesClicked(object sender, EventArgs e)
        {
            DisplayAlert("Case Studies", "Opening case studies page...", "OK");
        }
        
        private void OnContactUsClicked(object sender, EventArgs e)
        {
            DisplayAlert("Contact Us", "Opening contact form...", "OK");
        }
        
        private void OnContactClicked(object sender, EventArgs e)
        {
            DisplayAlert("Contact", "Opening contact page...", "OK");
        }
        
        private void OnAboutClicked(object sender, EventArgs e)
        {
            DisplayAlert("About", "Opening about page...", "OK");
        }
    }
}

