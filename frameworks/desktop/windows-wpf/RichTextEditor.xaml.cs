using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Media;
using Microsoft.Win32;

namespace AccessibilityBenchmark
{
    public partial class RichTextEditor : Window
    {
        private List<string> undoStack = new List<string>();
        private List<string> redoStack = new List<string>();
        private int currentZoom = 100;
        private bool isUpdating = false;
        
        public RichTextEditor()
        {
            InitializeComponent();
            UpdateStatistics();
            UpdateButtonStates();
        }
        
        private void UpdateStatistics()
        {
            if (isUpdating) return;
            
            var text = new TextRange(RichTextBox.Document.ContentStart, RichTextBox.Document.ContentEnd).Text;
            var words = text.Split(new char[] { ' ', '\n', '\r', '\t' }, StringSplitOptions.RemoveEmptyEntries).Length;
            var characters = text.Length;
            var paragraphs = RichTextBox.Document.Blocks.OfType<Paragraph>().Count();
            
            WordCountText.Text = $"Words: {words}";
            CharacterCountText.Text = $"Characters: {characters}";
            ParagraphCountText.Text = $"Paragraphs: {paragraphs}";
        }
        
        private void UpdateButtonStates()
        {
            var selection = RichTextBox.Selection;
            var fontWeight = selection.GetPropertyValue(TextElement.FontWeightProperty);
            var fontStyle = selection.GetPropertyValue(TextElement.FontStyleProperty);
            var textDecorations = selection.GetPropertyValue(Inline.TextDecorationsProperty);
            
            BoldButton.Background = fontWeight?.ToString() == "Bold" ? Brushes.LightBlue : Brushes.Transparent;
            ItalicButton.Background = fontStyle?.ToString() == "Italic" ? Brushes.LightBlue : Brushes.Transparent;
            UnderlineButton.Background = textDecorations?.ToString().Contains("Underline") == true ? Brushes.LightBlue : Brushes.Transparent;
        }
        
        private void SaveToUndoStack()
        {
            var text = new TextRange(RichTextBox.Document.ContentStart, RichTextBox.Document.ContentEnd).Text;
            undoStack.Add(text);
            redoStack.Clear();
            
            if (undoStack.Count > 50)
            {
                undoStack.RemoveAt(0);
            }
        }
        
        private void RichTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (!isUpdating)
            {
                SaveToUndoStack();
                UpdateStatistics();
            }
        }
        
        private void RichTextBox_SelectionChanged(object sender, RoutedEventArgs e)
        {
            UpdateButtonStates();
            
            // Update position in status bar
            var textPointer = RichTextBox.Selection.Start;
            var line = textPointer.GetLineStartPosition(0);
            var lineNumber = line?.GetLineStartPosition(0) == null ? 1 : textPointer.GetLineStartPosition(0).GetOffsetToPosition(textPointer) + 1;
            var columnNumber = textPointer.GetOffsetToPosition(textPointer.GetLineStartPosition(0)) + 1;
            
            PositionText.Text = $"Line {lineNumber}, Column {columnNumber}";
        }
        
        private void UndoButton_Click(object sender, RoutedEventArgs e)
        {
            if (undoStack.Count > 1)
            {
                redoStack.Add(undoStack[undoStack.Count - 1]);
                undoStack.RemoveAt(undoStack.Count - 1);
                
                var text = undoStack[undoStack.Count - 1];
                RichTextBox.Document.Blocks.Clear();
                RichTextBox.Document.Blocks.Add(new Paragraph(new Run(text)));
            }
        }
        
        private void RedoButton_Click(object sender, RoutedEventArgs e)
        {
            if (redoStack.Count > 0)
            {
                var text = redoStack[redoStack.Count - 1];
                redoStack.RemoveAt(redoStack.Count - 1);
                undoStack.Add(text);
                
                RichTextBox.Document.Blocks.Clear();
                RichTextBox.Document.Blocks.Add(new Paragraph(new Run(text)));
            }
        }
        
        private void BoldButton_Click(object sender, RoutedEventArgs e)
        {
            var selection = RichTextBox.Selection;
            if (!selection.IsEmpty)
            {
                var fontWeight = selection.GetPropertyValue(TextElement.FontWeightProperty);
                var newWeight = fontWeight?.ToString() == "Bold" ? FontWeights.Normal : FontWeights.Bold;
                selection.ApplyPropertyValue(TextElement.FontWeightProperty, newWeight);
            }
        }
        
        private void ItalicButton_Click(object sender, RoutedEventArgs e)
        {
            var selection = RichTextBox.Selection;
            if (!selection.IsEmpty)
            {
                var fontStyle = selection.GetPropertyValue(TextElement.FontStyleProperty);
                var newStyle = fontStyle?.ToString() == "Italic" ? FontStyles.Normal : FontStyles.Italic;
                selection.ApplyPropertyValue(TextElement.FontStyleProperty, newStyle);
            }
        }
        
        private void UnderlineButton_Click(object sender, RoutedEventArgs e)
        {
            var selection = RichTextBox.Selection;
            if (!selection.IsEmpty)
            {
                var textDecorations = selection.GetPropertyValue(Inline.TextDecorationsProperty);
                var newDecorations = textDecorations?.ToString().Contains("Underline") == true ? 
                    TextDecorations.None : TextDecorations.Underline;
                selection.ApplyPropertyValue(Inline.TextDecorationsProperty, newDecorations);
            }
        }
        
        private void FontSizeComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var selection = RichTextBox.Selection;
            if (!selection.IsEmpty && FontSizeComboBox.SelectedItem is ComboBoxItem selectedItem)
            {
                if (double.TryParse(selectedItem.Content.ToString(), out double fontSize))
                {
                    selection.ApplyPropertyValue(TextElement.FontSizeProperty, fontSize);
                }
            }
        }
        
        private void FontFamilyComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var selection = RichTextBox.Selection;
            if (!selection.IsEmpty && FontFamilyComboBox.SelectedItem is ComboBoxItem selectedItem)
            {
                var fontFamily = new FontFamily(selectedItem.Content.ToString());
                selection.ApplyPropertyValue(TextElement.FontFamilyProperty, fontFamily);
            }
        }
        
        private void TextColorButton_Click(object sender, RoutedEventArgs e)
        {
            var colorDialog = new ColorDialog();
            if (colorDialog.ShowDialog() == true)
            {
                var selection = RichTextBox.Selection;
                if (!selection.IsEmpty)
                {
                    var color = Color.FromRgb(colorDialog.Color.R, colorDialog.Color.G, colorDialog.Color.B);
                    selection.ApplyPropertyValue(TextElement.ForegroundProperty, new SolidColorBrush(color));
                }
            }
        }
        
        private void BackgroundColorButton_Click(object sender, RoutedEventArgs e)
        {
            var colorDialog = new ColorDialog();
            if (colorDialog.ShowDialog() == true)
            {
                var selection = RichTextBox.Selection;
                if (!selection.IsEmpty)
                {
                    var color = Color.FromRgb(colorDialog.Color.R, colorDialog.Color.G, colorDialog.Color.B);
                    selection.ApplyPropertyValue(TextElement.BackgroundProperty, new SolidColorBrush(color));
                }
            }
        }
        
        private void LeftAlignButton_Click(object sender, RoutedEventArgs e)
        {
            var selection = RichTextBox.Selection;
            if (!selection.IsEmpty)
            {
                var paragraph = selection.Start.Paragraph;
                if (paragraph != null)
                {
                    paragraph.TextAlignment = TextAlignment.Left;
                }
            }
        }
        
        private void CenterAlignButton_Click(object sender, RoutedEventArgs e)
        {
            var selection = RichTextBox.Selection;
            if (!selection.IsEmpty)
            {
                var paragraph = selection.Start.Paragraph;
                if (paragraph != null)
                {
                    paragraph.TextAlignment = TextAlignment.Center;
                }
            }
        }
        
        private void RightAlignButton_Click(object sender, RoutedEventArgs e)
        {
            var selection = RichTextBox.Selection;
            if (!selection.IsEmpty)
            {
                var paragraph = selection.Start.Paragraph;
                if (paragraph != null)
                {
                    paragraph.TextAlignment = TextAlignment.Right;
                }
            }
        }
        
        private void JustifyButton_Click(object sender, RoutedEventArgs e)
        {
            var selection = RichTextBox.Selection;
            if (!selection.IsEmpty)
            {
                var paragraph = selection.Start.Paragraph;
                if (paragraph != null)
                {
                    paragraph.TextAlignment = TextAlignment.Justify;
                }
            }
        }
        
        private void BulletListButton_Click(object sender, RoutedEventArgs e)
        {
            var selection = RichTextBox.Selection;
            if (!selection.IsEmpty)
            {
                var paragraph = selection.Start.Paragraph;
                if (paragraph != null)
                {
                    paragraph.TextIndent = 20;
                    paragraph.Margin = new Thickness(20, 0, 0, 0);
                }
            }
        }
        
        private void NumberedListButton_Click(object sender, RoutedEventArgs e)
        {
            var selection = RichTextBox.Selection;
            if (!selection.IsEmpty)
            {
                var paragraph = selection.Start.Paragraph;
                if (paragraph != null)
                {
                    paragraph.TextIndent = 20;
                    paragraph.Margin = new Thickness(20, 0, 0, 0);
                }
            }
        }
        
        private void InsertImageButton_Click(object sender, RoutedEventArgs e)
        {
            var openFileDialog = new OpenFileDialog
            {
                Filter = "Image files (*.png;*.jpg;*.jpeg;*.gif;*.bmp)|*.png;*.jpg;*.jpeg;*.gif;*.bmp|All files (*.*)|*.*"
            };
            
            if (openFileDialog.ShowDialog() == true)
            {
                var selection = RichTextBox.Selection;
                var image = new Image
                {
                    Source = new BitmapImage(new Uri(openFileDialog.FileName)),
                    Width = 200,
                    Height = 150
                };
                
                var inlineUIContainer = new InlineUIContainer(image);
                selection.InsertTextInRun("[Image: " + Path.GetFileName(openFileDialog.FileName) + "]");
            }
        }
        
        private void InsertTableButton_Click(object sender, RoutedEventArgs e)
        {
            var selection = RichTextBox.Selection;
            selection.InsertTextInRun("\n[Table placeholder - 3x3]\n");
        }
        
        private void InsertLinkButton_Click(object sender, RoutedEventArgs e)
        {
            var linkDialog = new LinkDialog();
            if (linkDialog.ShowDialog() == true)
            {
                var selection = RichTextBox.Selection;
                selection.InsertTextInRun($"[{linkDialog.LinkText}]({linkDialog.LinkUrl})");
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
        
        private void ApplyHeadingStyle(double fontSize, FontWeight fontWeight)
        {
            var selection = RichTextBox.Selection;
            if (!selection.IsEmpty)
            {
                selection.ApplyPropertyValue(TextElement.FontSizeProperty, fontSize);
                selection.ApplyPropertyValue(TextElement.FontWeightProperty, fontWeight);
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
            RichTextBox.LayoutTransform = new ScaleTransform(currentZoom / 100.0, currentZoom / 100.0);
        }
        
        // Menu event handlers
        private void NewMenuItem_Click(object sender, RoutedEventArgs e)
        {
            RichTextBox.Document.Blocks.Clear();
            undoStack.Clear();
            redoStack.Clear();
        }
        
        private void OpenMenuItem_Click(object sender, RoutedEventArgs e)
        {
            var openFileDialog = new OpenFileDialog
            {
                Filter = "Rich Text Files (*.rtf)|*.rtf|Text Files (*.txt)|*.txt|All Files (*.*)|*.*"
            };
            
            if (openFileDialog.ShowDialog() == true)
            {
                try
                {
                    var fileStream = new FileStream(openFileDialog.FileName, FileMode.Open);
                    var range = new TextRange(RichTextBox.Document.ContentStart, RichTextBox.Document.ContentEnd);
                    range.Load(fileStream, DataFormats.Rtf);
                    fileStream.Close();
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Error opening file: {ex.Message}", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
        }
        
        private void SaveMenuItem_Click(object sender, RoutedEventArgs e)
        {
            var saveFileDialog = new SaveFileDialog
            {
                Filter = "Rich Text Files (*.rtf)|*.rtf|Text Files (*.txt)|*.txt|All Files (*.*)|*.*"
            };
            
            if (saveFileDialog.ShowDialog() == true)
            {
                try
                {
                    var fileStream = new FileStream(saveFileDialog.FileName, FileMode.Create);
                    var range = new TextRange(RichTextBox.Document.ContentStart, RichTextBox.Document.ContentEnd);
                    range.Save(fileStream, DataFormats.Rtf);
                    fileStream.Close();
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Error saving file: {ex.Message}", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
        }
        
        private void SaveAsMenuItem_Click(object sender, RoutedEventArgs e)
        {
            SaveMenuItem_Click(sender, e);
        }
        
        private void ExportPdfMenuItem_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("PDF export functionality would be implemented here.", "Export PDF", MessageBoxButton.OK, MessageBoxImage.Information);
        }
        
        private void ExportWordMenuItem_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Word export functionality would be implemented here.", "Export Word", MessageBoxButton.OK, MessageBoxImage.Information);
        }
        
        private void ExportHtmlMenuItem_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("HTML export functionality would be implemented here.", "Export HTML", MessageBoxButton.OK, MessageBoxImage.Information);
        }
        
        private void ExitMenuItem_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }
        
        private void UndoMenuItem_Click(object sender, RoutedEventArgs e)
        {
            UndoButton_Click(sender, e);
        }
        
        private void RedoMenuItem_Click(object sender, RoutedEventArgs e)
        {
            RedoButton_Click(sender, e);
        }
        
        private void CutMenuItem_Click(object sender, RoutedEventArgs e)
        {
            RichTextBox.Cut();
        }
        
        private void CopyMenuItem_Click(object sender, RoutedEventArgs e)
        {
            RichTextBox.Copy();
        }
        
        private void PasteMenuItem_Click(object sender, RoutedEventArgs e)
        {
            RichTextBox.Paste();
        }
        
        private void FontMenuItem_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Font dialog would be implemented here.", "Font", MessageBoxButton.OK, MessageBoxImage.Information);
        }
        
        private void ParagraphMenuItem_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Paragraph dialog would be implemented here.", "Paragraph", MessageBoxButton.OK, MessageBoxImage.Information);
        }
        
        private void StylesMenuItem_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Styles dialog would be implemented here.", "Styles", MessageBoxButton.OK, MessageBoxImage.Information);
        }
        
        private void InsertImageMenuItem_Click(object sender, RoutedEventArgs e)
        {
            InsertImageButton_Click(sender, e);
        }
        
        private void InsertTableMenuItem_Click(object sender, RoutedEventArgs e)
        {
            InsertTableButton_Click(sender, e);
        }
        
        private void InsertLinkMenuItem_Click(object sender, RoutedEventArgs e)
        {
            InsertLinkButton_Click(sender, e);
        }
        
        private void InsertListMenuItem_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("List dialog would be implemented here.", "Insert List", MessageBoxButton.OK, MessageBoxImage.Information);
        }
        
        private void WordCountMenuItem_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show($"Document Statistics:\n\n{WordCountText.Text}\n{CharacterCountText.Text}\n{ParagraphCountText.Text}", 
                          "Document Statistics", MessageBoxButton.OK, MessageBoxImage.Information);
        }
        
        private void ZoomInMenuItem_Click(object sender, RoutedEventArgs e)
        {
            ZoomInButton_Click(sender, e);
        }
        
        private void ZoomOutMenuItem_Click(object sender, RoutedEventArgs e)
        {
            ZoomOutButton_Click(sender, e);
        }
        
        private void ResetZoomMenuItem_Click(object sender, RoutedEventArgs e)
        {
            currentZoom = 100;
            UpdateZoom();
        }
        
        private void RecentFilesListBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (RecentFilesListBox.SelectedItem is ListBoxItem selectedItem)
            {
                MessageBox.Show($"Opening file: {selectedItem.Content}", "Open File", MessageBoxButton.OK, MessageBoxImage.Information);
            }
        }
    }
    
    // Helper classes for dialogs
    public class ColorDialog : Window
    {
        public System.Drawing.Color Color { get; set; } = System.Drawing.Color.Black;
        
        public ColorDialog()
        {
            Title = "Select Color";
            Width = 300;
            Height = 200;
            WindowStartupLocation = WindowStartupLocation.CenterOwner;
            
            var grid = new Grid();
            grid.RowDefinitions.Add(new RowDefinition { Height = new GridLength(1, GridUnitType.Star) });
            grid.RowDefinitions.Add(new RowDefinition { Height = GridLength.Auto });
            
            var colorPicker = new StackPanel { Orientation = Orientation.Horizontal, HorizontalAlignment = HorizontalAlignment.Center, VerticalAlignment = VerticalAlignment.Center };
            
            var colors = new[] { 
                System.Drawing.Color.Black, System.Drawing.Color.Red, System.Drawing.Color.Green, System.Drawing.Color.Blue,
                System.Drawing.Color.Yellow, System.Drawing.Color.Orange, System.Drawing.Color.Purple, System.Drawing.Color.Gray
            };
            
            foreach (var color in colors)
            {
                var button = new Button
                {
                    Width = 30,
                    Height = 30,
                    Margin = new Thickness(5),
                    Background = new SolidColorBrush(Color.FromRgb(color.R, color.G, color.B))
                };
                button.Click += (s, e) => { Color = color; DialogResult = true; Close(); };
                colorPicker.Children.Add(button);
            }
            
            grid.Children.Add(colorPicker);
            Grid.SetRow(colorPicker, 0);
            
            var buttonPanel = new StackPanel { Orientation = Orientation.Horizontal, HorizontalAlignment = HorizontalAlignment.Right, Margin = new Thickness(10) };
            var okButton = new Button { Content = "OK", Width = 80, Height = 30, Margin = new Thickness(5) };
            var cancelButton = new Button { Content = "Cancel", Width = 80, Height = 30, Margin = new Thickness(5) };
            
            okButton.Click += (s, e) => { DialogResult = true; Close(); };
            cancelButton.Click += (s, e) => { DialogResult = false; Close(); };
            
            buttonPanel.Children.Add(okButton);
            buttonPanel.Children.Add(cancelButton);
            grid.Children.Add(buttonPanel);
            Grid.SetRow(buttonPanel, 1);
            
            Content = grid;
        }
    }
    
    public class LinkDialog : Window
    {
        public string LinkText { get; set; }
        public string LinkUrl { get; set; }
        
        public LinkDialog()
        {
            Title = "Insert Link";
            Width = 400;
            Height = 200;
            WindowStartupLocation = WindowStartupLocation.CenterOwner;
            
            var grid = new Grid();
            grid.RowDefinitions.Add(new RowDefinition { Height = GridLength.Auto });
            grid.RowDefinitions.Add(new RowDefinition { Height = GridLength.Auto });
            grid.RowDefinitions.Add(new RowDefinition { Height = GridLength.Auto });
            grid.RowDefinitions.Add(new RowDefinition { Height = GridLength.Auto });
            
            var textLabel = new TextBlock { Text = "Link Text:", Margin = new Thickness(10) };
            var textTextBox = new TextBox { Name = "TextTextBox", Margin = new Thickness(10) };
            
            var urlLabel = new TextBlock { Text = "URL:", Margin = new Thickness(10) };
            var urlTextBox = new TextBox { Name = "UrlTextBox", Margin = new Thickness(10) };
            
            var buttonPanel = new StackPanel { Orientation = Orientation.Horizontal, HorizontalAlignment = HorizontalAlignment.Right, Margin = new Thickness(10) };
            var okButton = new Button { Content = "OK", Width = 80, Height = 30, Margin = new Thickness(5) };
            var cancelButton = new Button { Content = "Cancel", Width = 80, Height = 30, Margin = new Thickness(5) };
            
            okButton.Click += (s, e) => 
            {
                LinkText = textTextBox.Text;
                LinkUrl = urlTextBox.Text;
                DialogResult = true;
                Close();
            };
            cancelButton.Click += (s, e) => { DialogResult = false; Close(); };
            
            buttonPanel.Children.Add(okButton);
            buttonPanel.Children.Add(cancelButton);
            
            grid.Children.Add(textLabel);
            grid.Children.Add(textTextBox);
            Grid.SetRow(textTextBox, 1);
            grid.Children.Add(urlLabel);
            Grid.SetRow(urlLabel, 2);
            grid.Children.Add(urlTextBox);
            Grid.SetRow(urlTextBox, 3);
            grid.Children.Add(buttonPanel);
            Grid.SetRow(buttonPanel, 3);
            
            Content = grid;
        }
    }
}
