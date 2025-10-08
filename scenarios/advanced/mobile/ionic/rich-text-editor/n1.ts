import { Component, OnInit } from '@angular/core';
import { AlertController, ModalController } from '@ionic/angular';

@Component({
  selector: 'app-rich-text-editor',
  templateUrl: './rich-text-editor.page.html',
  styleUrls: ['./rich-text-editor.page.scss'],
})
export class RichTextEditorPage implements OnInit {
  content = '';
  isBold = false;
  isItalic = false;
  isUnderline = false;
  fontSize = 16;
  textColor = '#000000';
  backgroundColor = '#FFFFFF';
  alignment = 'left';
  showWordCount = false;
  isUndoAvailable = false;
  isRedoAvailable = false;
  history: string[] = [''];
  historyIndex = 0;
  wordCount = 0;
  charCount = 0;

  // Modal states
  showFontSizeModal = false;
  showColorPickerModal = false;
  showInsertModal = false;
  colorPickerTitle = '';
  colorPickerType = 'text';

  fontSizes = [12, 14, 16, 18, 20, 24, 28, 32, 36, 48];
  colors = [
    '#000000', '#333333', '#666666', '#999999', '#CCCCCC',
    '#FF0000', '#FF6600', '#FFCC00', '#00FF00', '#0066FF',
    '#6600FF', '#FF00CC', '#FFFFFF', '#FFCCCC', '#CCFFCC'
  ];

  constructor(
    private alertController: AlertController,
    private modalController: ModalController
  ) {}

  ngOnInit() {
    this.updateHistory();
  }

  onContentChanged() {
    this.updateWordCount();
    this.updateHistory();
  }

  updateWordCount() {
    if (!this.content.trim()) {
      this.wordCount = 0;
      this.charCount = 0;
    } else {
      this.wordCount = this.content.trim().split(/\s+/).filter(word => word.length > 0).length;
      this.charCount = this.content.length;
    }
  }

  updateHistory() {
    const newHistory = this.history.slice(0, this.historyIndex + 1);
    newHistory.push(this.content);
    this.history = newHistory;
    this.historyIndex = newHistory.length - 1;
    this.isUndoAvailable = this.historyIndex > 0;
    this.isRedoAvailable = this.historyIndex < newHistory.length - 1;
  }

  onSaveClicked() {
    this.presentAlert('Save', 'Document saved successfully');
  }

  async onExportClicked() {
    const alert = await this.alertController.create({
      header: 'Export',
      message: 'Choose export format',
      buttons: [
        {
          text: 'PDF',
          handler: () => this.presentAlert('Export', 'Exporting as PDF...')
        },
        {
          text: 'Word',
          handler: () => this.presentAlert('Export', 'Exporting as Word...')
        },
        {
          text: 'HTML',
          handler: () => this.presentAlert('Export', 'Exporting as HTML...')
        },
        {
          text: 'Cancel',
          role: 'cancel'
        }
      ]
    });
    await alert.present();
  }

  onStatsClicked() {
    this.showWordCount = !this.showWordCount;
  }

  onUndoClicked() {
    if (this.historyIndex > 0) {
      this.historyIndex--;
      this.content = this.history[this.historyIndex];
      this.isUndoAvailable = this.historyIndex > 0;
      this.isRedoAvailable = true;
    }
  }

  onRedoClicked() {
    if (this.historyIndex < this.history.length - 1) {
      this.historyIndex++;
      this.content = this.history[this.historyIndex];
      this.isUndoAvailable = true;
      this.isRedoAvailable = this.historyIndex < this.history.length - 1;
    }
  }

  onBoldClicked() {
    this.isBold = !this.isBold;
    // In a real implementation, this would apply bold formatting to selected text
  }

  onItalicClicked() {
    this.isItalic = !this.isItalic;
    // In a real implementation, this would apply italic formatting to selected text
  }

  onUnderlineClicked() {
    this.isUnderline = !this.isUnderline;
    // In a real implementation, this would apply underline formatting to selected text
  }

  onFontSizeClicked() {
    this.showFontSizeModal = true;
  }

  onFontSizeSelected(size: number) {
    this.fontSize = size;
    this.showFontSizeModal = false;
  }

  onFontSizeModalDismissed() {
    this.showFontSizeModal = false;
  }

  onTextColorClicked() {
    this.colorPickerType = 'text';
    this.colorPickerTitle = 'Text Color';
    this.showColorPickerModal = true;
  }

  onBackgroundColorClicked() {
    this.colorPickerType = 'background';
    this.colorPickerTitle = 'Background Color';
    this.showColorPickerModal = true;
  }

  onColorSelected(color: string) {
    if (this.colorPickerType === 'text') {
      this.textColor = color;
    } else {
      this.backgroundColor = color;
    }
    this.showColorPickerModal = false;
  }

  isColorSelected(color: string): boolean {
    if (this.colorPickerType === 'text') {
      return this.textColor === color;
    } else {
      return this.backgroundColor === color;
    }
  }

  onColorPickerModalDismissed() {
    this.showColorPickerModal = false;
  }

  onLeftAlignClicked() {
    this.alignment = 'left';
  }

  onCenterAlignClicked() {
    this.alignment = 'center';
  }

  onRightAlignClicked() {
    this.alignment = 'right';
  }

  onInsertClicked() {
    this.showInsertModal = true;
  }

  onInsertImage() {
    this.presentAlert('Insert Image', 'Image insertion functionality would be implemented here');
    this.showInsertModal = false;
  }

  onInsertLink() {
    this.presentAlert('Insert Link', 'Link insertion functionality would be implemented here');
    this.showInsertModal = false;
  }

  onInsertTable() {
    this.presentAlert('Insert Table', 'Table insertion functionality would be implemented here');
    this.showInsertModal = false;
  }

  onInsertList() {
    this.content += '• List item\n';
    this.updateHistory();
    this.showInsertModal = false;
  }

  onInsertModalDismissed() {
    this.showInsertModal = false;
  }

  async presentAlert(header: string, message: string) {
    const alert = await this.alertController.create({
      header: header,
      message: message,
      buttons: ['OK']
    });
    await alert.present();
  }
}
