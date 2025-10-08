namespace UIComponents.Views;

public partial class RichTextEditorPage : ContentPage
{
    public RichTextEditorPage()
    {
        InitializeComponent();
    }

    private void OnBoldClicked(object sender, EventArgs e)
    {
        DisplayAlert("Rich Text Editor", "Bold formatting applied", "OK");
    }

    private void OnItalicClicked(object sender, EventArgs e)
    {
        DisplayAlert("Rich Text Editor", "Italic formatting applied", "OK");
    }

    private void OnUnderlineClicked(object sender, EventArgs e)
    {
        DisplayAlert("Rich Text Editor", "Underline formatting applied", "OK");
    }

    private void OnAlignLeftClicked(object sender, EventArgs e)
    {
        DisplayAlert("Rich Text Editor", "Left alignment applied", "OK");
    }

    private void OnAlignCenterClicked(object sender, EventArgs e)
    {
        DisplayAlert("Rich Text Editor", "Center alignment applied", "OK");
    }

    private void OnSaveClicked(object sender, EventArgs e)
    {
        DisplayAlert("Rich Text Editor", "Document saved", "OK");
    }
}
