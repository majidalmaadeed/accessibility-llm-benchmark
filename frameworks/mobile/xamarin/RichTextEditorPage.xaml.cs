using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using Xamarin.Forms;

namespace AccessibilityBenchmark
{
    public partial class RichTextEditorPage : ContentPage
    {
        private bool isBold = false;
        private bool isItalic = false;
        private bool isUnderline = false;
        private double fontSize = 16;
        private Color textColor = Color.Black;
        private Color backgroundColor = Color.White;
        private TextAlign alignment = TextAlign.Start;
        private bool showWordCount = false;
        private bool isUndoAvailable = false;
        private bool isRedoAvailable = false;
        private List<string> history = new List<string> { "" };
        private int historyIndex = 0;
        private string content = "";

        public RichTextEditorPage()
        {
            InitializeComponent();
            BindingContext = this;
            UpdateHistory();
        }

        public string Content
        {
            get => content;
            set
            {
                content = value;
                OnPropertyChanged();
                UpdateWordCount();
            }
        }

        public double FontSize
        {
            get => fontSize;
            set
            {
                fontSize = value;
                OnPropertyChanged();
            }
        }

        public Color TextColor
        {
            get => textColor;
            set
            {
                textColor = value;
                OnPropertyChanged();
            }
        }

        public Color BackgroundColor
        {
            get => backgroundColor;
            set
            {
                backgroundColor = value;
                OnPropertyChanged();
            }
        }

        public bool ShowWordCount
        {
            get => showWordCount;
            set
            {
                showWordCount = value;
                OnPropertyChanged();
            }
        }

        public string WordCountText => $"Words: {WordCount} | Characters: {CharacterCount}";

        public int WordCount { get; private set; }
        public int CharacterCount { get; private set; }

        public bool IsUndoAvailable
        {
            get => isUndoAvailable;
            set
            {
                isUndoAvailable = value;
                OnPropertyChanged();
            }
        }

        public bool IsRedoAvailable
        {
            get => isRedoAvailable;
            set
            {
                isRedoAvailable = value;
                OnPropertyChanged();
            }
        }

        public Color BoldBackgroundColor => isBold ? Color.FromHex("#E3F2FD") : Color.FromHex("#F0F0F0");
        public Color BoldTextColor => isBold ? Color.FromHex("#007AFF") : Color.FromHex("#666");
        public Color ItalicBackgroundColor => isItalic ? Color.FromHex("#E3F2FD") : Color.FromHex("#F0F0F0");
        public Color ItalicTextColor => isItalic ? Color.FromHex("#007AFF") : Color.FromHex("#666");
        public Color UnderlineBackgroundColor => isUnderline ? Color.FromHex("#E3F2FD") : Color.FromHex("#F0F0F0");
        public Color UnderlineTextColor => isUnderline ? Color.FromHex("#007AFF") : Color.FromHex("#666");

        public Color LeftAlignBackgroundColor => alignment == TextAlign.Start ? Color.FromHex("#E3F2FD") : Color.FromHex("#F0F0F0");
        public Color LeftAlignTextColor => alignment == TextAlign.Start ? Color.FromHex("#007AFF") : Color.FromHex("#666");
        public Color CenterAlignBackgroundColor => alignment == TextAlign.Center ? Color.FromHex("#E3F2FD") : Color.FromHex("#F0F0F0");
        public Color CenterAlignTextColor => alignment == TextAlign.Center ? Color.FromHex("#007AFF") : Color.FromHex("#666");
        public Color RightAlignBackgroundColor => alignment == TextAlign.End ? Color.FromHex("#E3F2FD") : Color.FromHex("#F0F0F0");
        public Color RightAlignTextColor => alignment == TextAlign.End ? Color.FromHex("#007AFF") : Color.FromHex("#666");

        private void UpdateWordCount()
        {
            if (string.IsNullOrEmpty(content))
            {
                WordCount = 0;
                CharacterCount = 0;
            }
            else
            {
                WordCount = content.Trim().Split(new char[] { ' ', '\t', '\n', '\r' }, StringSplitOptions.RemoveEmptyEntries).Length;
                CharacterCount = content.Length;
            }
            OnPropertyChanged(nameof(WordCountText));
        }

        private void UpdateHistory()
        {
            var newHistory = history.Take(historyIndex + 1).ToList();
            newHistory.Add(content);
            history = newHistory;
            historyIndex = newHistory.Count - 1;
            IsUndoAvailable = historyIndex > 0;
            IsRedoAvailable = historyIndex < newHistory.Count - 1;
        }

        private void OnSaveClicked(object sender, EventArgs e)
        {
            DisplayAlert("Save", "Document saved successfully", "OK");
        }

        private async void OnExportClicked(object sender, EventArgs e)
        {
            var action = await DisplayActionSheet("Export", "Cancel", null, "PDF", "Word", "HTML");
            if (action != "Cancel")
            {
                await DisplayAlert("Export", $"Exporting as {action}...", "OK");
            }
        }

        private void OnStatsClicked(object sender, EventArgs e)
        {
            ShowWordCount = !ShowWordCount;
        }

        private void OnUndoClicked(object sender, EventArgs e)
        {
            if (historyIndex > 0)
            {
                historyIndex--;
                Content = history[historyIndex];
                IsUndoAvailable = historyIndex > 0;
                IsRedoAvailable = true;
            }
        }

        private void OnRedoClicked(object sender, EventArgs e)
        {
            if (historyIndex < history.Count - 1)
            {
                historyIndex++;
                Content = history[historyIndex];
                IsUndoAvailable = true;
                IsRedoAvailable = historyIndex < history.Count - 1;
            }
        }

        private void OnBoldClicked(object sender, EventArgs e)
        {
            isBold = !isBold;
            OnPropertyChanged(nameof(BoldBackgroundColor));
            OnPropertyChanged(nameof(BoldTextColor));
            // In a real implementation, this would apply bold formatting to selected text
        }

        private void OnItalicClicked(object sender, EventArgs e)
        {
            isItalic = !isItalic;
            OnPropertyChanged(nameof(ItalicBackgroundColor));
            OnPropertyChanged(nameof(ItalicTextColor));
            // In a real implementation, this would apply italic formatting to selected text
        }

        private void OnUnderlineClicked(object sender, EventArgs e)
        {
            isUnderline = !isUnderline;
            OnPropertyChanged(nameof(UnderlineBackgroundColor));
            OnPropertyChanged(nameof(UnderlineTextColor));
            // In a real implementation, this would apply underline formatting to selected text
        }

        private async void OnFontSizeClicked(object sender, EventArgs e)
        {
            var fontSizes = new double[] { 12, 14, 16, 18, 20, 24, 28, 32, 36, 48 };
            var action = await DisplayActionSheet("Font Size", "Cancel", null, 
                fontSizes.Select(fs => $"{fs}pt").ToArray());
            
            if (action != "Cancel" && action.EndsWith("pt"))
            {
                var sizeStr = action.Replace("pt", "");
                if (double.TryParse(sizeStr, out double size))
                {
                    FontSize = size;
                }
            }
        }

        private async void OnTextColorClicked(object sender, EventArgs e)
        {
            var colors = new Color[]
            {
                Color.Black, Color.Gray, Color.Red, Color.Orange, Color.Yellow,
                Color.Green, Color.Blue, Color.Purple, Color.Pink, Color.White
            };
            
            var colorNames = new string[]
            {
                "Black", "Gray", "Red", "Orange", "Yellow",
                "Green", "Blue", "Purple", "Pink", "White"
            };

            var action = await DisplayActionSheet("Text Color", "Cancel", null, colorNames);
            var index = Array.IndexOf(colorNames, action);
            
            if (index >= 0)
            {
                TextColor = colors[index];
            }
        }

        private async void OnBackgroundColorClicked(object sender, EventArgs e)
        {
            var colors = new Color[]
            {
                Color.White, Color.LightGray, Color.LightBlue, Color.LightGreen,
                Color.LightYellow, Color.LightPink, Color.LightCoral, Color.LightCyan
            };
            
            var colorNames = new string[]
            {
                "White", "Light Gray", "Light Blue", "Light Green",
                "Light Yellow", "Light Pink", "Light Coral", "Light Cyan"
            };

            var action = await DisplayActionSheet("Background Color", "Cancel", null, colorNames);
            var index = Array.IndexOf(colorNames, action);
            
            if (index >= 0)
            {
                BackgroundColor = colors[index];
            }
        }

        private void OnLeftAlignClicked(object sender, EventArgs e)
        {
            alignment = TextAlign.Start;
            UpdateAlignmentProperties();
        }

        private void OnCenterAlignClicked(object sender, EventArgs e)
        {
            alignment = TextAlign.Center;
            UpdateAlignmentProperties();
        }

        private void OnRightAlignClicked(object sender, EventArgs e)
        {
            alignment = TextAlign.End;
            UpdateAlignmentProperties();
        }

        private void UpdateAlignmentProperties()
        {
            OnPropertyChanged(nameof(LeftAlignBackgroundColor));
            OnPropertyChanged(nameof(LeftAlignTextColor));
            OnPropertyChanged(nameof(CenterAlignBackgroundColor));
            OnPropertyChanged(nameof(CenterAlignTextColor));
            OnPropertyChanged(nameof(RightAlignBackgroundColor));
            OnPropertyChanged(nameof(RightAlignTextColor));
        }

        private async void OnInsertClicked(object sender, EventArgs e)
        {
            var action = await DisplayActionSheet("Insert", "Cancel", null, "Image", "Link", "Table", "List");
            
            switch (action)
            {
                case "Image":
                    await DisplayAlert("Insert Image", "Image insertion functionality would be implemented here", "OK");
                    break;
                case "Link":
                    await DisplayAlert("Insert Link", "Link insertion functionality would be implemented here", "OK");
                    break;
                case "Table":
                    await DisplayAlert("Insert Table", "Table insertion functionality would be implemented here", "OK");
                    break;
                case "List":
                    Content += "• List item\n";
                    UpdateHistory();
                    break;
            }
        }

        public event PropertyChangedEventHandler PropertyChanged;
        protected virtual void OnPropertyChanged([System.Runtime.CompilerServices.CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
