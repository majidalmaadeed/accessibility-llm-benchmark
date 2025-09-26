import React, { useState, useRef, useEffect } from 'react';
import './RichTextEditor.css';

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
    const text = editorRef.current?.innerText || '';
    const words = text.trim().split(/\s+/).filter(word => word.length > 0);
    setWordCount(words.length);
    setCharCount(text.length);
  }, [content]);

  const execCommand = (command, value = null) => {
    document.execCommand(command, false, value);
    updateToolbarState();
    saveToUndoStack();
  };

  const updateToolbarState = () => {
    setIsBold(document.queryCommandState('bold'));
    setIsItalic(document.queryCommandState('italic'));
    setIsUnderline(document.queryCommandState('underline'));
    
    const selection = window.getSelection();
    if (selection.rangeCount > 0) {
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
      default:
        break;
    }
  };

  return (
    <div className={`rich-text-editor ${isFullscreen ? 'fullscreen' : ''}`}>
      <div className="editor-toolbar">
        <div className="toolbar-section">
          <button 
            onClick={undo}
            disabled={undoStack.length === 0}
            title="Undo"
          >
            ↶
          </button>
          <button 
            onClick={redo}
            disabled={redoStack.length === 0}
            title="Redo"
          >
            ↷
          </button>
        </div>

        <div className="toolbar-section">
          <button 
            onClick={() => execCommand('bold')}
            className={isBold ? 'active' : ''}
            title="Bold"
          >
            <strong>B</strong>
          </button>
          <button 
            onClick={() => execCommand('italic')}
            className={isItalic ? 'active' : ''}
            title="Italic"
          >
            <em>I</em>
          </button>
          <button 
            onClick={() => execCommand('underline')}
            className={isUnderline ? 'active' : ''}
            title="Underline"
          >
            <u>U</u>
          </button>
        </div>

        <div className="toolbar-section">
          <select 
            value={fontFamily}
            onChange={(e) => {
              setFontFamily(e.target.value);
              execCommand('fontName', e.target.value);
            }}
            title="Font Family"
          >
            {fontFamilies.map(font => (
              <option key={font} value={font}>{font}</option>
            ))}
          </select>
          
          <select 
            value={fontSize}
            onChange={(e) => {
              setFontSize(e.target.value);
              execCommand('fontSize', '7');
              execCommand('foreColor', textColor);
            }}
            title="Font Size"
          >
            {fontSizes.map(size => (
              <option key={size} value={size}>{size}px</option>
            ))}
          </select>
        </div>

        <div className="toolbar-section">
          <input
            type="color"
            value={textColor}
            onChange={(e) => {
              setTextColor(e.target.value);
              execCommand('foreColor', e.target.value);
            }}
            title="Text Color"
          />
          <input
            type="color"
            value={backgroundColor}
            onChange={(e) => {
              setBackgroundColor(e.target.value);
              execCommand('backColor', e.target.value);
            }}
            title="Background Color"
          />
        </div>

        <div className="toolbar-section">
          <button 
            onClick={() => {
              setAlignment('left');
              execCommand('justifyLeft');
            }}
            className={alignment === 'left' ? 'active' : ''}
            title="Align Left"
          >
            ⬅
          </button>
          <button 
            onClick={() => {
              setAlignment('center');
              execCommand('justifyCenter');
            }}
            className={alignment === 'center' ? 'active' : ''}
            title="Align Center"
          >
            ↔
          </button>
          <button 
            onClick={() => {
              setAlignment('right');
              execCommand('justifyRight');
            }}
            className={alignment === 'right' ? 'active' : ''}
            title="Align Right"
          >
            ➡
          </button>
          <button 
            onClick={() => {
              setAlignment('justify');
              execCommand('justifyFull');
            }}
            className={alignment === 'justify' ? 'active' : ''}
            title="Justify"
          >
            ⬌
          </button>
        </div>

        <div className="toolbar-section">
          <button 
            onClick={() => {
              setListType('unordered');
              execCommand('insertUnorderedList');
            }}
            className={listType === 'unordered' ? 'active' : ''}
            title="Bullet List"
          >
            •
          </button>
          <button 
            onClick={() => {
              setListType('ordered');
              execCommand('insertOrderedList');
            }}
            className={listType === 'ordered' ? 'active' : ''}
            title="Numbered List"
          >
            1.
          </button>
        </div>

        <div className="toolbar-section">
          <button 
            onClick={() => setShowStylePanel(!showStylePanel)}
            className={showStylePanel ? 'active' : ''}
            title="Styles"
          >
            Styles
          </button>
          <button 
            onClick={() => setShowMediaPanel(!showMediaPanel)}
            className={showMediaPanel ? 'active' : ''}
            title="Media"
          >
            Media
          </button>
        </div>

        <div className="toolbar-section">
          <button 
            onClick={() => exportContent('html')}
            title="Export HTML"
          >
            Export HTML
          </button>
          <button 
            onClick={() => exportContent('text')}
            title="Export Text"
          >
            Export Text
          </button>
          <button 
            onClick={toggleFullscreen}
            title="Toggle Fullscreen"
          >
            {isFullscreen ? '⤢' : '⤡'}
          </button>
        </div>
      </div>

      {showStylePanel && (
        <div className="style-panel">
          <h4>Quick Styles</h4>
          <div className="style-buttons">
            <button onClick={() => execCommand('formatBlock', 'h1')}>Heading 1</button>
            <button onClick={() => execCommand('formatBlock', 'h2')}>Heading 2</button>
            <button onClick={() => execCommand('formatBlock', 'h3')}>Heading 3</button>
            <button onClick={() => execCommand('formatBlock', 'p')}>Paragraph</button>
            <button onClick={() => execCommand('formatBlock', 'blockquote')}>Quote</button>
            <button onClick={() => execCommand('formatBlock', 'pre')}>Code</button>
          </div>
          
          <h4>Text Colors</h4>
          <div className="color-palette">
            {colors.map(color => (
              <button
                key={color}
                className="color-btn"
                style={{ backgroundColor: color }}
                onClick={() => {
                  setTextColor(color);
                  execCommand('foreColor', color);
                }}
                title={color}
              />
            ))}
          </div>
        </div>
      )}

      {showMediaPanel && (
        <div className="media-panel">
          <h4>Insert Media</h4>
          <div className="media-buttons">
            <button onClick={insertImage}>Insert Image</button>
            <button onClick={insertLink}>Insert Link</button>
            <button onClick={insertTable}>Insert Table</button>
            <button onClick={insertHorizontalRule}>Insert Line</button>
          </div>
        </div>
      )}

      <div className="editor-container">
        <div
          ref={editorRef}
          className="editor-content"
          contentEditable
          dangerouslySetInnerHTML={{ __html: content }}
          onInput={handleContentChange}
          onMouseUp={updateToolbarState}
          onKeyUp={updateToolbarState}
          onFocus={updateToolbarState}
        />
      </div>

      <div className="editor-footer">
        <div className="word-count">
          <span>Words: {wordCount}</span>
          <span>Characters: {charCount}</span>
        </div>
        <div className="editor-status">
          <span>Ready</span>
        </div>
      </div>
    </div>
  );
};

export default RichTextEditor;
