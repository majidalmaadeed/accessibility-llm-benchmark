namespace UIComponents.Views;

public partial class WizardPage : ContentPage
{
    private int currentStep = 1;
    private int totalSteps = 5;

    public WizardPage()
    {
        InitializeComponent();
    }

    private void OnPreviousClicked(object sender, EventArgs e)
    {
        if (currentStep > 1)
        {
            currentStep--;
            UpdateStep();
        }
    }

    private void OnNextClicked(object sender, EventArgs e)
    {
        if (currentStep < totalSteps)
        {
            currentStep++;
            UpdateStep();
        }
        else
        {
            DisplayAlert("Wizard Complete", "Thank you for completing the wizard!", "OK");
        }
    }

    private void UpdateStep()
    {
        WizardProgress.Progress = (double)currentStep / totalSteps;
        StepLabel.Text = $"Step {currentStep} of {totalSteps}: {GetStepTitle()}";
    }

    private string GetStepTitle()
    {
        return currentStep switch
        {
            1 => "Personal Information",
            2 => "Preferences",
            3 => "Account Settings",
            4 => "Additional Information",
            5 => "Review and Confirm",
            _ => "Unknown Step"
        };
    }
}
