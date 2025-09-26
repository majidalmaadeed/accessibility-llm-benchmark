'use client';

import { useState, useRef, useEffect } from 'react';
import styles from './RichTextEditor.module.css';

const RichTextEditor = () => {
  const editorRef = useRef(null);
  const [content, setContent] = useState('<p>Start typing your content here...</p>');
  const [isBold, setIsBold] = useState(false);
  const [isItalic, setIsItalic] = useState(false);
  const [isUnderline, setIsUnderline] = useState(false);
  const [fontSize, setFontSize] = useState('16');
  const [fontFamily, setFontFamily] = useState('Arial');
  const [textColor, setTextColor] = useState('#000000');
  const [backgroundColor, setBackgroundColor] = useState('#ffffff');
  const [alignment, setAlignment] = useState('left');
  const [listType, setListType] = useState('none');
  const [showStylePanel, setShowStylePanel] = useState(false);
  const [showMediaPanel, setShowMediaPanel] = useState(false);
  const [wordCount, setWordCount] = useState(0);
  const [charCount, setCharCount] = useState(0);
  const [undoStack, setUndoStack] = useState([]);
  const [redoStack, setRedoStack] = useState([]);
  const [isFullscreen, setIsFullscreen] = useState(false);

  const fontFamilies = [
    'Arial', 'Helvetica', 'Times New Roman', 'Georgia', 'Verdana', 'Courier New'
  ];
  const fontSizes = ['8', '10', '12', '14', '16', '18', '20', '24', '28', '32', '36', '48'];
  const colors = [
    '#000000', '#333333', '#666666', '#999999', '#cccccc', '#ffffff',
    '#ff0000', '#ff6600', '#ffcc00', '#00ff00', '#0066ff', '#6600ff',
    '#ff0066', '#00ffff', '#ffff00', '#ff9900', '#99ff00', '#0099ff'
  ];

  useEffect(() => {
    updateWordCount();
    saveToUndoStack();
  }, []);

  const execCommand = (command, value = null) => {
    document.execCommand(command, false, value || undefined);
    updateToolbarState();
    saveToUndoStack();
  };

  const updateToolbarState = () => {
    setIsBold(document.queryCommandState('bold'));
    setIsItalic(document.queryCommandState('italic'));
    setIsUnderline(document.queryCommandState('underline'));
    
    const selection = window.getSelection();
    if (selection && selection.rangeCount > 0) {
      const range = selection.getRangeAt(0);
      const container = range.commonAncestorContainer;
      const element = container.nodeType === Node.TEXT_NODE ? container.parentElement : container;
      
      if (element) {
        const computedStyle = window.getComputedStyle(element);
        setFontSize(computedStyle.fontSize.replace('px', ''));
        setFontFamily(computedStyle.fontFamily.split(',')[0].replace(/['"]/g, ''));
        setTextColor(computedStyle.color);
        setBackgroundColor(computedStyle.backgroundColor);
        
        const textAlign = computedStyle.textAlign;
        setAlignment(textAlign === 'start' ? 'left' : textAlign);
      }
    }
  };

  const saveToUndoStack = () => {
    const currentContent = editorRef.current?.innerHTML || '';
    setUndoStack(prev => [...prev, currentContent]);
    setRedoStack([]);
  };

  const undo = () => {
    if (undoStack.length > 0) {
      const previousContent = undoStack[undoStack.length - 1];
      setRedoStack(prev => [...prev, content]);
      setContent(previousContent);
      setUndoStack(prev => prev.slice(0, -1));
    }
  };

  const redo = () => {
    if (redoStack.length > 0) {
      const nextContent = redoStack[redoStack.length - 1];
      setUndoStack(prev => [...prev, content]);
      setContent(nextContent);
      setRedoStack(prev => prev.slice(0, -1));
    }
  };

  const handleContentChange = () => {
    const newContent = editorRef.current?.innerHTML || '';
    setContent(newContent);
    updateWordCount();
  };

  const updateWordCount = () => {
    const text = editorRef.current?.innerText || '';
    const words = text.trim().split(/\s+/).filter(word => word.length > 0);
    setWordCount(words.length);
    setCharCount(text.length);
  };

  const handleFontFamilyChange = (event) => {
    const newFontFamily = event.target.value;
    setFontFamily(newFontFamily);
    execCommand('fontName', newFontFamily);
  };

  const handleFontSizeChange = (event) => {
    const newFontSize = event.target.value;
    setFontSize(newFontSize);
    execCommand('fontSize', '7');
    execCommand('foreColor', textColor);
  };

  const handleTextColorChange = (event) => {
    const newTextColor = event.target.value;
    setTextColor(newTextColor);
    execCommand('foreColor', newTextColor);
  };

  const handleBackgroundColorChange = (event) => {
    const newBackgroundColor = event.target.value;
    setBackgroundColor(newBackgroundColor);
    execCommand('backColor', newBackgroundColor);
  };

  const setAlignment = (align) => {
    setAlignment(align);
    switch (align) {
      case 'left':
        execCommand('justifyLeft');
        break;
      case 'center':
        execCommand('justifyCenter');
        break;
      case 'right':
        execCommand('justifyRight');
        break;
      case 'justify':
        execCommand('justifyFull');
        break;
    }
  };

  const setTextColor = (color) => {
    setTextColor(color);
    execCommand('foreColor', color);
  };

  const insertImage = () => {
    const url = prompt('Enter image URL:');
    if (url) {
      execCommand('insertHTML', `<img src="${url}" alt="Inserted image" style="max-width: 100%; height: auto;">`);
    }
  };

  const insertLink = () => {
    const url = prompt('Enter URL:');
    const text = prompt('Enter link text:');
    if (url && text) {
      execCommand('insertHTML', `<a href="${url}">${text}</a>`);
    }
  };

  const insertTable = () => {
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
      execCommand('insertHTML', tableHTML);
    }
  };

  const insertHorizontalRule = () => {
    execCommand('insertHTML', '<hr>');
  };

  const toggleFullscreen = () => {
    setIsFullscreen(!isFullscreen);
  };

  const exportContent = (format) => {
    const text = editorRef.current?.innerText || '';
    const html = editorRef.current?.innerHTML || '';
    
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
  };

  const onEditorFocus = () => {
    updateToolbarState();
  };

  const onEditorKeyUp = () => {
    updateToolbarState();
  };

  const onEditorMouseUp = () => {
    updateToolbarState();
  };

  return (
    <div className={`${styles.richTextEditor} ${isFullscreen ? styles.fullscreen : ''}`}>
      <div className={styles.editorToolbar}>
        <div className={styles.toolbarSection}>
          <button 
            onClick={undo}
            disabled={undoStack.length === 0}
            title="Undo"
            className={styles.toolbarBtn}
          >
            ↶
          </button>
          <button 
            onClick={redo}
            disabled={redoStack.length === 0}
            title="Redo"
            className={styles.toolbarBtn}
          >
            ↷
          </button>
        </div>

        <div className={styles.toolbarSection}>
          <button 
            onClick={() => execCommand('bold')}
            className={`${styles.toolbarBtn} ${isBold ? styles.active : ''}`}
            title="Bold"
          >
            <strong>B</strong>
          </button>
          <button 
            onClick={() => execCommand('italic')}
            className={`${styles.toolbarBtn} ${isItalic ? styles.active : ''}`}
            title="Italic"
          >
            <em>I</em>
          </button>
          <button 
            onClick={() => execCommand('underline')}
            className={`${styles.toolbarBtn} ${isUnderline ? styles.active : ''}`}
            title="Underline"
          >
            <u>U</u>
          </button>
        </div>

        <div className={styles.toolbarSection}>
          <select 
            value={fontFamily}
            onChange={handleFontFamilyChange}
            title="Font Family"
            className={styles.toolbarSelect}
          >
            {fontFamilies.map(font => (
              <option key={font} value={font}>{font}</option>
            ))}
          </select>
          
          <select 
            value={fontSize}
            onChange={handleFontSizeChange}
            title="Font Size"
            className={styles.toolbarSelect}
          >
            {fontSizes.map(size => (
              <option key={size} value={size}>{size}px</option>
            ))}
          </select>
        </div>

        <div className={styles.toolbarSection}>
          <input
            type="color"
            value={textColor}
            onChange={handleTextColorChange}
            title="Text Color"
            className={styles.colorInput}
          />
          <input
            type="color"
            value={backgroundColor}
            onChange={handleBackgroundColorChange}
            title="Background Color"
            className={styles.colorInput}
          />
        </div>

        <div className={styles.toolbarSection}>
          <button 
            onClick={() => setAlignment('left')}
            className={`${styles.toolbarBtn} ${alignment === 'left' ? styles.active : ''}`}
            title="Align Left"
          >
            ⬅
          </button>
          <button 
            onClick={() => setAlignment('center')}
            className={`${styles.toolbarBtn} ${alignment === 'center' ? styles.active : ''}`}
            title="Align Center"
          >
            ↔
          </button>
          <button 
            onClick={() => setAlignment('right')}
            className={`${styles.toolbarBtn} ${alignment === 'right' ? styles.active : ''}`}
            title="Align Right"
          >
            ➡
          </button>
          <button 
            onClick={() => setAlignment('justify')}
            className={`${styles.toolbarBtn} ${alignment === 'justify' ? styles.active : ''}`}
            title="Justify"
          >
            ⬌
          </button>
        </div>

        <div className={styles.toolbarSection}>
          <button 
            onClick={() => execCommand('insertUnorderedList')}
            className={`${styles.toolbarBtn} ${listType === 'unordered' ? styles.active : ''}`}
            title="Bullet List"
          >
            •
          </button>
          <button 
            onClick={() => execCommand('insertOrderedList')}
            className={`${styles.toolbarBtn} ${listType === 'ordered' ? styles.active : ''}`}
            title="Numbered List"
          >
            1.
          </button>
        </div>

        <div className={styles.toolbarSection}>
          <button 
            onClick={() => setShowStylePanel(!showStylePanel)}
            className={`${styles.toolbarBtn} ${showStylePanel ? styles.active : ''}`}
            title="Styles"
          >
            Styles
          </button>
          <button 
            onClick={() => setShowMediaPanel(!showMediaPanel)}
            className={`${styles.toolbarBtn} ${showMediaPanel ? styles.active : ''}`}
            title="Media"
          >
            Media
          </button>
        </div>

        <div className={styles.toolbarSection}>
          <button 
            onClick={() => exportContent('html')}
            title="Export HTML"
            className={styles.toolbarBtn}
          >
            Export HTML
          </button>
          <button 
            onClick={() => exportContent('text')}
            title="Export Text"
            className={styles.toolbarBtn}
          >
            Export Text
          </button>
          <button 
            onClick={toggleFullscreen}
            title="Toggle Fullscreen"
            className={styles.toolbarBtn}
          >
            {isFullscreen ? '⤢' : '⤡'}
          </button>
        </div>
      </div>

      {showStylePanel && (
        <div className={styles.stylePanel}>
          <h4>Quick Styles</h4>
          <div className={styles.styleButtons}>
            <button onClick={() => execCommand('formatBlock', 'h1')} className={styles.styleBtn}>Heading 1</button>
            <button onClick={() => execCommand('formatBlock', 'h2')} className={styles.styleBtn}>Heading 2</button>
            <button onClick={() => execCommand('formatBlock', 'h3')} className={styles.styleBtn}>Heading 3</button>
            <button onClick={() => execCommand('formatBlock', 'p')} className={styles.styleBtn}>Paragraph</button>
            <button onClick={() => execCommand('formatBlock', 'blockquote')} className={styles.styleBtn}>Quote</button>
            <button onClick={() => execCommand('formatBlock', 'pre')} className={styles.styleBtn}>Code</button>
          </div>
          
          <h4>Text Colors</h4>
          <div className={styles.colorPalette}>
            {colors.map(color => (
              <button
                key={color}
                className={styles.colorBtn}
                style={{ backgroundColor: color }}
                onClick={() => setTextColor(color)}
                title={color}
              />
            ))}
          </div>
        </div>
      )}

      {showMediaPanel && (
        <div className={styles.mediaPanel}>
          <h4>Insert Media</h4>
          <div className={styles.mediaButtons}>
            <button onClick={insertImage} className={styles.mediaBtn}>Insert Image</button>
            <button onClick={insertLink} className={styles.mediaBtn}>Insert Link</button>
            <button onClick={insertTable} className={styles.mediaBtn}>Insert Table</button>
            <button onClick={insertHorizontalRule} className={styles.mediaBtn}>Insert Line</button>
          </div>
        </div>
      )}

      <div className={styles.editorContainer}>
        <div
          ref={editorRef}
          className={styles.editorContent}
          contentEditable
          dangerouslySetInnerHTML={{ __html: content }}
          onInput={handleContentChange}
          onMouseUp={onEditorMouseUp}
          onKeyUp={onEditorKeyUp}
          onFocus={onEditorFocus}
        />
      </div>

      <div className={styles.editorFooter}>
        <div className={styles.wordCount}>
          <span>Words: {wordCount}</span>
          <span>Characters: {charCount}</span>
        </div>
        <div className={styles.editorStatus}>
          <span>Ready</span>
        </div>
      </div>
    </div>
  );
};

export default RichTextEditor;
