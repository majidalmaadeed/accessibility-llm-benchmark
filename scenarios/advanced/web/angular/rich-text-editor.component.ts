import { Component, OnInit, ViewChild, ElementRef } from '@angular/core';

@Component({
  selector: 'app-rich-text-editor',
  templateUrl: './rich-text-editor.component.html',
  styleUrls: ['./rich-text-editor.component.css']
})
export class RichTextEditorComponent implements OnInit {
  @ViewChild('editorRef', { static: false }) editorRef!: ElementRef<HTMLDivElement>;

  content: string = '<p>Start typing your content here...</p>';
  isBold: boolean = false;
  isItalic: boolean = false;
  isUnderline: boolean = false;
  fontSize: string = '16';
  fontFamily: string = 'Arial';
  textColor: string = '#000000';
  backgroundColor: string = '#ffffff';
  alignment: string = 'left';
  listType: string = 'none';
  showStylePanel: boolean = false;
  showMediaPanel: boolean = false;
  wordCount: number = 0;
  charCount: number = 0;
  undoStack: string[] = [];
  redoStack: string[] = [];
  isFullscreen: boolean = false;

  fontFamilies: string[] = [
    'Arial', 'Helvetica', 'Times New Roman', 'Georgia', 'Verdana', 'Courier New'
  ];
  fontSizes: string[] = ['8', '10', '12', '14', '16', '18', '20', '24', '28', '32', '36', '48'];
  colors: string[] = [
    '#000000', '#333333', '#666666', '#999999', '#cccccc', '#ffffff',
    '#ff0000', '#ff6600', '#ffcc00', '#00ff00', '#0066ff', '#6600ff',
    '#ff0066', '#00ffff', '#ffff00', '#ff9900', '#99ff00', '#0099ff'
  ];

  constructor() { }

  ngOnInit(): void {
    this.updateWordCount();
  }

  ngAfterViewInit(): void {
    this.saveToUndoStack();
  }

  execCommand(command: string, value: string | null = null): void {
    document.execCommand(command, false, value || undefined);
    this.updateToolbarState();
    this.saveToUndoStack();
  }

  updateToolbarState(): void {
    this.isBold = document.queryCommandState('bold');
    this.isItalic = document.queryCommandState('italic');
    this.isUnderline = document.queryCommandState('underline');
    
    const selection = window.getSelection();
    if (selection && selection.rangeCount > 0) {
      const range = selection.getRangeAt(0);
      const container = range.commonAncestorContainer;
      const element = container.nodeType === Node.TEXT_NODE ? container.parentElement : container as Element;
      
      if (element) {
        const computedStyle = window.getComputedStyle(element);
        this.fontSize = computedStyle.fontSize.replace('px', '');
        this.fontFamily = computedStyle.fontFamily.split(',')[0].replace(/['"]/g, '');
        this.textColor = computedStyle.color;
        this.backgroundColor = computedStyle.backgroundColor;
        
        const textAlign = computedStyle.textAlign;
        this.alignment = textAlign === 'start' ? 'left' : textAlign;
      }
    }
  }

  saveToUndoStack(): void {
    const currentContent = this.editorRef?.nativeElement?.innerHTML || '';
    this.undoStack.push(currentContent);
    this.redoStack = [];
  }

  undo(): void {
    if (this.undoStack.length > 0) {
      const previousContent = this.undoStack.pop() || '';
      this.redoStack.push(this.content);
      this.content = previousContent;
    }
  }

  redo(): void {
    if (this.redoStack.length > 0) {
      const nextContent = this.redoStack.pop() || '';
      this.undoStack.push(this.content);
      this.content = nextContent;
    }
  }

  handleContentChange(): void {
    this.content = this.editorRef?.nativeElement?.innerHTML || '';
    this.updateWordCount();
  }

  updateWordCount(): void {
    const text = this.editorRef?.nativeElement?.innerText || '';
    const words = text.trim().split(/\s+/).filter(word => word.length > 0);
    this.wordCount = words.length;
    this.charCount = text.length;
  }

  handleFontFamilyChange(event: Event): void {
    const target = event.target as HTMLSelectElement;
    this.fontFamily = target.value;
    this.execCommand('fontName', target.value);
  }

  handleFontSizeChange(event: Event): void {
    const target = event.target as HTMLSelectElement;
    this.fontSize = target.value;
    this.execCommand('fontSize', '7');
    this.execCommand('foreColor', this.textColor);
  }

  handleTextColorChange(event: Event): void {
    const target = event.target as HTMLInputElement;
    this.textColor = target.value;
    this.execCommand('foreColor', target.value);
  }

  handleBackgroundColorChange(event: Event): void {
    const target = event.target as HTMLInputElement;
    this.backgroundColor = target.value;
    this.execCommand('backColor', target.value);
  }

  setAlignment(align: string): void {
    this.alignment = align;
    switch (align) {
      case 'left':
        this.execCommand('justifyLeft');
        break;
      case 'center':
        this.execCommand('justifyCenter');
        break;
      case 'right':
        this.execCommand('justifyRight');
        break;
      case 'justify':
        this.execCommand('justifyFull');
        break;
    }
  }

  setTextColor(color: string): void {
    this.textColor = color;
    this.execCommand('foreColor', color);
  }

  insertImage(): void {
    const url = prompt('Enter image URL:');
    if (url) {
      this.execCommand('insertHTML', `<img src="${url}" alt="Inserted image" style="max-width: 100%; height: auto;">`);
    }
  }

  insertLink(): void {
    const url = prompt('Enter URL:');
    const text = prompt('Enter link text:');
    if (url && text) {
      this.execCommand('insertHTML', `<a href="${url}">${text}</a>`);
    }
  }

  insertTable(): void {
    const rows = prompt('Number of rows:', '3');
    const cols = prompt('Number of columns:', '3');
    if (rows && cols) {
      let tableHTML = '<table border="1" style="border-collapse: collapse; width: 100%;">';
      for (let i = 0; i < parseInt(rows); i++) {
        tableHTML += '<tr>';
        for (let j = 0; j < parseInt(cols); j++) {
          tableHTML += '<td style="padding: 8px; border: 1px solid #ccc;">Cell</td>';
        }
        tableHTML += '</tr>';
      }
      tableHTML += '</table>';
      this.execCommand('insertHTML', tableHTML);
    }
  }

  insertHorizontalRule(): void {
    this.execCommand('insertHTML', '<hr>');
  }

  toggleFullscreen(): void {
    this.isFullscreen = !this.isFullscreen;
  }

  exportContent(format: string): void {
    const text = this.editorRef?.nativeElement?.innerText || '';
    const html = this.editorRef?.nativeElement?.innerHTML || '';
    
    switch (format) {
      case 'html':
        const blob = new Blob([html], { type: 'text/html' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = 'document.html';
        a.click();
        break;
      case 'text':
        const textBlob = new Blob([text], { type: 'text/plain' });
        const textUrl = URL.createObjectURL(textBlob);
        const textA = document.createElement('a');
        textA.href = textUrl;
        textA.download = 'document.txt';
        textA.click();
        break;
    }
  }

  onEditorFocus(): void {
    this.updateToolbarState();
  }

  onEditorKeyUp(): void {
    this.updateToolbarState();
  }

  onEditorMouseUp(): void {
    this.updateToolbarState();
  }
}
