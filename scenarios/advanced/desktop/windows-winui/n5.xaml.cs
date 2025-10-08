using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using Microsoft.UI.Xaml.Media;
using Microsoft.UI.Text;
using Windows.ApplicationModel.DataTransfer;
using Windows.Storage;
using Windows.Storage.Pickers;

namespace UIComponents
{
    public sealed partial class RichTextEditor : Page
    {
        private List<string> undoStack = new List<string>();
        private List<string> redoStack = new List<string>();
        private int currentZoom = 100;
        private bool isUpdating = false;
        
        public RichTextEditor()
        {
            this.InitializeComponent();
            UpdateStatistics();
            UpdateButtonStates();
        }
        
        private void UpdateStatistics()
        {
            if (isUpdating) return;
            
            RichEditBox.Document.GetText(TextGetOptions.None, out string text);
            var words = text.Split(new char[] { ' ', '\n', '\r', '\t' }, StringSplitOptions.RemoveEmptyEntries).Length;
            var characters = text.Length;
            var paragraphs = RichEditBox.Document.GetRange(0, RichEditBox.Document.Selection.EndPosition).GetParagraphs().Count();
            
            WordCountText.Text = $"Words: {words}";
            CharacterCountText.Text = $"Characters: {characters}";
            ParagraphCountText.Text = $"Paragraphs: {paragraphs}";
        }
        
        private void UpdateButtonStates()
        {
            var selection = RichEditBox.Document.Selection;
            var characterFormat = selection.CharacterFormat;
            
            BoldButton.Background = characterFormat.Bold == FormatEffect.On ? 
                new SolidColorBrush(Microsoft.UI.Colors.LightBlue) : 
                new SolidColorBrush(Microsoft.UI.Colors.Transparent);
            ItalicButton.Background = characterFormat.Italic == FormatEffect.On ? 
                new SolidColorBrush(Microsoft.UI.Colors.LightBlue) : 
                new SolidColorBrush(Microsoft.UI.Colors.Transparent);
            UnderlineButton.Background = characterFormat.Underline == UnderlineType.Single ? 
                new SolidColorBrush(Microsoft.UI.Colors.LightBlue) : 
                new SolidColorBrush(Microsoft.UI.Colors.Transparent);
        }
        
        private void SaveToUndoStack()
        {
            RichEditBox.Document.GetText(TextGetOptions.None, out string text);
            undoStack.Add(text);
            redoStack.Clear();
            
            if (undoStack.Count > 50)
            {
                undoStack.RemoveAt(0);
            }
        }
        
        private void RichEditBox_TextChanged(object sender, RoutedEventArgs e)
        {
            if (!isUpdating)
            {
                SaveToUndoStack();
                UpdateStatistics();
            }
        }
        
        private void RichEditBox_SelectionChanged(object sender, RoutedEventArgs e)
        {
            UpdateButtonStates();
            
            // Update position in status bar
            var selection = RichEditBox.Document.Selection;
            var lineNumber = selection.StartPosition;
            var columnNumber = selection.StartPosition;
            
            PositionText.Text = $"Position: {lineNumber}";
        }
        
        private void UndoButton_Click(object sender, RoutedEventArgs e)
        {
            if (undoStack.Count > 1)
            {
                redoStack.Add(undoStack[undoStack.Count - 1]);
                undoStack.RemoveAt(undoStack.Count - 1);
                
                var text = undoStack[undoStack.Count - 1];
                RichEditBox.Document.SetText(TextSetOptions.None, text);
            }
        }
        
        private void RedoButton_Click(object sender, RoutedEventArgs e)
        {
            if (redoStack.Count > 0)
            {
                var text = redoStack[redoStack.Count - 1];
                redoStack.RemoveAt(redoStack.Count - 1);
                undoStack.Add(text);
                
                RichEditBox.Document.SetText(TextSetOptions.None, text);
            }
        }
        
        private void BoldButton_Click(object sender, RoutedEventArgs e)
        {
            var selection = RichEditBox.Document.Selection;
            if (selection.Length > 0)
            {
                var characterFormat = selection.CharacterFormat;
                characterFormat.Bold = characterFormat.Bold == FormatEffect.On ? FormatEffect.Off : FormatEffect.On;
                selection.CharacterFormat = characterFormat;
            }
        }
        
        private void ItalicButton_Click(object sender, RoutedEventArgs e)
        {
            var selection = RichEditBox.Document.Selection;
            if (selection.Length > 0)
            {
                var characterFormat = selection.CharacterFormat;
                characterFormat.Italic = characterFormat.Italic == FormatEffect.On ? FormatEffect.Off : FormatEffect.On;
                selection.CharacterFormat = characterFormat;
            }
        }
        
        private void UnderlineButton_Click(object sender, RoutedEventArgs e)
        {
            var selection = RichEditBox.Document.Selection;
            if (selection.Length > 0)
            {
                var characterFormat = selection.CharacterFormat;
                characterFormat.Underline = characterFormat.Underline == UnderlineType.Single ? UnderlineType.None : UnderlineType.Single;
                selection.CharacterFormat = characterFormat;
            }
        }
        
        private void FontSizeComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var selection = RichEditBox.Document.Selection;
            if (selection.Length > 0 && FontSizeComboBox.SelectedItem is ComboBoxItem selectedItem)
            {
                if (float.TryParse(selectedItem.Content.ToString(), out float fontSize))
                {
                    var characterFormat = selection.CharacterFormat;
                    characterFormat.Size = fontSize;
                    selection.CharacterFormat = characterFormat;
                }
            }
        }
        
        private void FontFamilyComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var selection = RichEditBox.Document.Selection;
            if (selection.Length > 0 && FontFamilyComboBox.SelectedItem is ComboBoxItem selectedItem)
            {
                var characterFormat = selection.CharacterFormat;
                characterFormat.Name = selectedItem.Content.ToString();
                selection.CharacterFormat = characterFormat;
            }
        }
        
        private async void TextColorButton_Click(object sender, RoutedEventArgs e)
        {
            var colorDialog = new ColorDialog();
            var result = await colorDialog.ShowAsync();
            if (result == ContentDialogResult.Primary)
            {
                var selection = RichEditBox.Document.Selection;
                if (selection.Length > 0)
                {
                    var characterFormat = selection.CharacterFormat;
                    characterFormat.ForegroundColor = colorDialog.SelectedColor;
                    selection.CharacterFormat = characterFormat;
                }
            }
        }
        
        private async void BackgroundColorButton_Click(object sender, RoutedEventArgs e)
        {
            var colorDialog = new ColorDialog();
            var result = await colorDialog.ShowAsync();
            if (result == ContentDialogResult.Primary)
            {
                var selection = RichEditBox.Document.Selection;
                if (selection.Length > 0)
                {
                    var characterFormat = selection.CharacterFormat;
                    characterFormat.BackgroundColor = colorDialog.SelectedColor;
                    selection.CharacterFormat = characterFormat;
                }
            }
        }
        
        private void LeftAlignButton_Click(object sender, RoutedEventArgs e)
        {
            var selection = RichEditBox.Document.Selection;
            if (selection.Length > 0)
            {
                var paragraphFormat = selection.ParagraphFormat;
                paragraphFormat.Alignment = ParagraphAlignment.Left;
                selection.ParagraphFormat = paragraphFormat;
            }
        }
        
        private void CenterAlignButton_Click(object sender, RoutedEventArgs e)
        {
            var selection = RichEditBox.Document.Selection;
            if (selection.Length > 0)
            {
                var paragraphFormat = selection.ParagraphFormat;
                paragraphFormat.Alignment = ParagraphAlignment.Center;
                selection.ParagraphFormat = paragraphFormat;
            }
        }
        
        private void RightAlignButton_Click(object sender, RoutedEventArgs e)
        {
            var selection = RichEditBox.Document.Selection;
            if (selection.Length > 0)
            {
                var paragraphFormat = selection.ParagraphFormat;
                paragraphFormat.Alignment = ParagraphAlignment.Right;
                selection.ParagraphFormat = paragraphFormat;
            }
        }
        
        private void JustifyButton_Click(object sender, RoutedEventArgs e)
        {
            var selection = RichEditBox.Document.Selection;
            if (selection.Length > 0)
            {
                var paragraphFormat = selection.ParagraphFormat;
                paragraphFormat.Alignment = ParagraphAlignment.Justify;
                selection.ParagraphFormat = paragraphFormat;
            }
        }
        
        private void BulletListButton_Click(object sender, RoutedEventArgs e)
        {
            var selection = RichEditBox.Document.Selection;
            if (selection.Length > 0)
            {
                var paragraphFormat = selection.ParagraphFormat;
                paragraphFormat.ListType = paragraphFormat.ListType == MarkerType.Bullet ? MarkerType.None : MarkerType.Bullet;
                selection.ParagraphFormat = paragraphFormat;
            }
        }
        
        private void NumberedListButton_Click(object sender, RoutedEventArgs e)
        {
            var selection = RichEditBox.Document.Selection;
            if (selection.Length > 0)
            {
                var paragraphFormat = selection.ParagraphFormat;
                paragraphFormat.ListType = paragraphFormat.ListType == MarkerType.Arabic ? MarkerType.None : MarkerType.Arabic;
                selection.ParagraphFormat = paragraphFormat;
            }
        }
        
        private async void InsertImageButton_Click(object sender, RoutedEventArgs e)
        {
            var filePicker = new FileOpenPicker();
            filePicker.FileTypeFilter.Add(".png");
            filePicker.FileTypeFilter.Add(".jpg");
            filePicker.FileTypeFilter.Add(".jpeg");
            filePicker.FileTypeFilter.Add(".gif");
            filePicker.FileTypeFilter.Add(".bmp");
            
            var file = await filePicker.PickSingleFileAsync();
            if (file != null)
            {
                var selection = RichEditBox.Document.Selection;
                selection.SetText(TextSetOptions.None, $"[Image: {file.Name}]");
            }
        }
        
        private void InsertTableButton_Click(object sender, RoutedEventArgs e)
        {
            var selection = RichEditBox.Document.Selection;
            selection.SetText(TextSetOptions.None, "\n[Table placeholder - 3x3]\n");
        }
        
        private async void InsertLinkButton_Click(object sender, RoutedEventArgs e)
        {
            var linkDialog = new LinkDialog();
            var result = await linkDialog.ShowAsync();
            if (result == ContentDialogResult.Primary)
            {
                var selection = RichEditBox.Document.Selection;
                selection.SetText(TextSetOptions.None, $"[{linkDialog.LinkText}]({linkDialog.LinkUrl})");
            }
        }
        
        private void Heading1Button_Click(object sender, RoutedEventArgs e)
        {
            ApplyHeadingStyle(24, FontWeights.Bold);
        }
        
        private void Heading2Button_Click(object sender, RoutedEventArgs e)
        {
            ApplyHeadingStyle(20, FontWeights.Bold);
        }
        
        private void Heading3Button_Click(object sender, RoutedEventArgs e)
        {
            ApplyHeadingStyle(18, FontWeights.Bold);
        }
        
        private void NormalButton_Click(object sender, RoutedEventArgs e)
        {
            ApplyHeadingStyle(16, FontWeights.Normal);
        }
        
        private void ApplyHeadingStyle(float fontSize, FontWeight fontWeight)
        {
            var selection = RichEditBox.Document.Selection;
            if (selection.Length > 0)
            {
                var characterFormat = selection.CharacterFormat;
                characterFormat.Size = fontSize;
                characterFormat.Bold = fontWeight == FontWeights.Bold ? FormatEffect.On : FormatEffect.Off;
                selection.CharacterFormat = characterFormat;
            }
        }
        
        private void ZoomInButton_Click(object sender, RoutedEventArgs e)
        {
            currentZoom = Math.Min(currentZoom + 10, 200);
            UpdateZoom();
        }
        
        private void ZoomOutButton_Click(object sender, RoutedEventArgs e)
        {
            currentZoom = Math.Max(currentZoom - 10, 50);
            UpdateZoom();
        }
        
        private void UpdateZoom()
        {
            ZoomText.Text = $"{currentZoom}%";
            RichEditBox.ZoomFactor = currentZoom / 100.0f;
        }
        
        // Command bar event handlers
        private async void NewButton_Click(object sender, RoutedEventArgs e)
        {
            RichEditBox.Document.SetText(TextSetOptions.None, "");
            undoStack.Clear();
            redoStack.Clear();
        }
        
        private async void OpenButton_Click(object sender, RoutedEventArgs e)
        {
            var filePicker = new FileOpenPicker();
            filePicker.FileTypeFilter.Add(".rtf");
            filePicker.FileTypeFilter.Add(".txt");
            
            var file = await filePicker.PickSingleFileAsync();
            if (file != null)
            {
                try
                {
                    var text = await FileIO.ReadTextAsync(file);
                    RichEditBox.Document.SetText(TextSetOptions.None, text);
                }
                catch (Exception ex)
                {
                    var dialog = new ContentDialog
                    {
                        Title = "Error",
                        Content = $"Error opening file: {ex.Message}",
                        PrimaryButtonText = "OK",
                        XamlRoot = this.XamlRoot
                    };
                    await dialog.ShowAsync();
                }
            }
        }
        
        private async void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            var filePicker = new FileSavePicker();
            filePicker.FileTypeChoices.Add("Rich Text Files", new List<string> { ".rtf" });
            filePicker.FileTypeChoices.Add("Text Files", new List<string> { ".txt" });
            filePicker.SuggestedFileName = "Document";
            
            var file = await filePicker.PickSaveFileAsync();
            if (file != null)
            {
                try
                {
                    RichEditBox.Document.GetText(TextGetOptions.None, out string text);
                    await FileIO.WriteTextAsync(file, text);
                }
                catch (Exception ex)
                {
                    var dialog = new ContentDialog
                    {
                        Title = "Error",
                        Content = $"Error saving file: {ex.Message}",
                        PrimaryButtonText = "OK",
                        XamlRoot = this.XamlRoot
                    };
                    await dialog.ShowAsync();
                }
            }
        }
        
        private async void SaveAsButton_Click(object sender, RoutedEventArgs e)
        {
            await SaveButton_Click(sender, e);
        }
        
        private void CutButton_Click(object sender, RoutedEventArgs e)
        {
            RichEditBox.Document.Selection.Cut();
        }
        
        private void CopyButton_Click(object sender, RoutedEventArgs e)
        {
            RichEditBox.Document.Selection.Copy();
        }
        
        private void PasteButton_Click(object sender, RoutedEventArgs e)
        {
            RichEditBox.Document.Selection.Paste(0);
        }
        
        private void RecentFilesListView_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (RecentFilesListView.SelectedItem is ListViewItem selectedItem)
            {
                StatusText.Text = $"Opening file: {selectedItem.Content}";
            }
        }
    }
    
    // Helper classes for dialogs
    public sealed partial class ColorDialog : ContentDialog
    {
        public Microsoft.UI.Color SelectedColor { get; set; } = Microsoft.UI.Colors.Black;
        
        public ColorDialog()
        {
            Title = "Select Color";
            PrimaryButtonText = "OK";
            SecondaryButtonText = "Cancel";
            
            var grid = new Grid();
            grid.RowDefinitions.Add(new RowDefinition { Height = new GridLength(1, GridUnitType.Star) });
            grid.RowDefinitions.Add(new RowDefinition { Height = GridLength.Auto });
            
            var colorPicker = new StackPanel { Orientation = Orientation.Horizontal, HorizontalAlignment = HorizontalAlignment.Center, VerticalAlignment = VerticalAlignment.Center };
            
            var colors = new[] { 
                Microsoft.UI.Colors.Black, Microsoft.UI.Colors.Red, Microsoft.UI.Colors.Green, Microsoft.UI.Colors.Blue,
                Microsoft.UI.Colors.Yellow, Microsoft.UI.Colors.Orange, Microsoft.UI.Colors.Purple, Microsoft.UI.Colors.Gray
            };
            
            foreach (var color in colors)
            {
                var button = new Button
                {
                    Width = 32,
                    Height = 32,
                    Margin = new Thickness(4),
                    Background = new SolidColorBrush(color)
                };
                button.Click += (s, e) => { SelectedColor = color; Hide(); };
                colorPicker.Children.Add(button);
            }
            
            grid.Children.Add(colorPicker);
            Grid.SetRow(colorPicker, 0);
            
            Content = grid;
        }
    }
    
    public sealed partial class LinkDialog : ContentDialog
    {
        public string LinkText { get; set; }
        public string LinkUrl { get; set; }
        
        public LinkDialog()
        {
            Title = "Insert Link";
            PrimaryButtonText = "OK";
            SecondaryButtonText = "Cancel";
            
            var grid = new Grid();
            grid.RowDefinitions.Add(new RowDefinition { Height = GridLength.Auto });
            grid.RowDefinitions.Add(new RowDefinition { Height = GridLength.Auto });
            grid.RowDefinitions.Add(new RowDefinition { Height = GridLength.Auto });
            
            var textLabel = new TextBlock { Text = "Link Text:", Margin = new Thickness(0, 0, 0, 8) };
            var textTextBox = new TextBox { Name = "TextTextBox", Margin = new Thickness(0, 0, 0, 16) };
            
            var urlLabel = new TextBlock { Text = "URL:", Margin = new Thickness(0, 0, 0, 8) };
            var urlTextBox = new TextBox { Name = "UrlTextBox" };
            
            grid.Children.Add(textLabel);
            grid.Children.Add(textTextBox);
            Grid.SetRow(textTextBox, 1);
            grid.Children.Add(urlLabel);
            Grid.SetRow(urlLabel, 2);
            grid.Children.Add(urlTextBox);
            Grid.SetRow(urlTextBox, 3);
            
            Content = grid;
            
            PrimaryButtonClick += (s, e) =>
            {
                LinkText = textTextBox.Text;
                LinkUrl = urlTextBox.Text;
            };
        }
    }
}
