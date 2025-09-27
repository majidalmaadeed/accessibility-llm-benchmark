import React, { useState } from 'react';

const RichTextEditor = () => {
  const [content, setContent] = useState('');
  const [isBold, setIsBold] = useState(false);
  const [isItalic, setIsItalic] = useState(false);
  const [isUnderline, setIsUnderline] = useState(false);
  const [fontSize, setFontSize] = useState('14');
  const [fontColor, setFontColor] = useState('#000000');
  const [alignment, setAlignment] = useState('left');
  const [showImageModal, setShowImageModal] = useState(false);
  const [showLinkModal, setShowLinkModal] = useState(false);

  const toggleFormat = (format) => {
    switch (format) {
      case 'bold':
        setIsBold(!isBold);
        break;
      case 'italic':
        setIsItalic(!isItalic);
        break;
      case 'underline':
        setIsUnderline(!isUnderline);
        break;
    }
  };

  const insertList = (type) => {
    const listItem = type === 'bullet' ? '• ' : '1. ';
    setContent(prev => prev + listItem);
  };

  const insertTable = () => {
    const table = `
| Column 1 | Column 2 | Column 3 |
|----------|----------|----------|
| Row 1    | Data 1   | Data 1   |
| Row 2    | Data 2   | Data 2   |
| Row 3    | Data 3   | Data 3   |
`;
    setContent(prev => prev + table);
  };

  const insertImage = () => {
    setShowImageModal(true);
  };

  const insertLink = () => {
    setShowLinkModal(true);
  };

  const insertHorizontalLine = () => {
    setContent(prev => prev + '\n---\n');
  };

  const insertPageBreak = () => {
    setContent(prev => prev + '\n\n--- PAGE BREAK ---\n\n');
  };

  const saveDocument = () => {
    const blob = new Blob([content], { type: 'text/plain' });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'document.txt';
    a.click();
    window.URL.revokeObjectURL(url);
  };

  const loadDocument = () => {
    const input = document.createElement('input');
    input.type = 'file';
    input.accept = '.txt,.md';
    input.onchange = (e) => {
      const file = e.target.files[0];
      if (file) {
        const reader = new FileReader();
        reader.onload = (e) => {
          setContent(e.target.result);
        };
        reader.readAsText(file);
      }
    };
    input.click();
  };

  const printDocument = () => {
    window.print();
  };

  const getWordCount = () => {
    return content.trim().split(/\s+/).filter(word => word.length > 0).length;
  };

  const getCharacterCount = () => {
    return content.length;
  };

  return (
    <div className="container">
      <div className="page-header">
        <h1 className="page-title">Rich Text Editor</h1>
        <p className="page-subtitle">
          Advanced rich text editing interface
        </p>
      </div>

      <div className="card">
        <div className="rich-text-toolbar">
          <button
            className={`toolbar-btn ${isBold ? 'active' : ''}`}
            onClick={() => toggleFormat('bold')}
            title="Bold"
          >
            B
          </button>
          <button
            className={`toolbar-btn ${isItalic ? 'active' : ''}`}
            onClick={() => toggleFormat('italic')}
            title="Italic"
          >
            I
          </button>
          <button
            className={`toolbar-btn ${isUnderline ? 'active' : ''}`}
            onClick={() => toggleFormat('underline')}
            title="Underline"
          >
            U
          </button>
          <div style={{ width: '1px', height: '20px', backgroundColor: '#ddd', margin: '0 5px' }} />
          <button
            className={`toolbar-btn ${alignment === 'left' ? 'active' : ''}`}
            onClick={() => setAlignment('left')}
            title="Align Left"
          >
            ⬅
          </button>
          <button
            className={`toolbar-btn ${alignment === 'center' ? 'active' : ''}`}
            onClick={() => setAlignment('center')}
            title="Align Center"
          >
            ↔
          </button>
          <button
            className={`toolbar-btn ${alignment === 'right' ? 'active' : ''}`}
            onClick={() => setAlignment('right')}
            title="Align Right"
          >
            ➡
          </button>
          <div style={{ width: '1px', height: '20px', backgroundColor: '#ddd', margin: '0 5px' }} />
          <button
            className="toolbar-btn"
            onClick={() => insertList('bullet')}
            title="Bullet List"
          >
            •
          </button>
          <button
            className="toolbar-btn"
            onClick={() => insertList('number')}
            title="Numbered List"
          >
            1.
          </button>
          <button
            className="toolbar-btn"
            onClick={insertTable}
            title="Insert Table"
          >
            ⊞
          </button>
          <div style={{ width: '1px', height: '20px', backgroundColor: '#ddd', margin: '0 5px' }} />
          <button
            className="toolbar-btn"
            onClick={insertImage}
            title="Insert Image"
          >
            🖼
          </button>
          <button
            className="toolbar-btn"
            onClick={insertLink}
            title="Insert Link"
          >
            🔗
          </button>
          <button
            className="toolbar-btn"
            onClick={insertHorizontalLine}
            title="Horizontal Line"
          >
            ➖
          </button>
          <button
            className="toolbar-btn"
            onClick={insertPageBreak}
            title="Page Break"
          >
            📄
          </button>
          <div style={{ width: '1px', height: '20px', backgroundColor: '#ddd', margin: '0 5px' }} />
          <select
            className="toolbar-btn"
            value={fontSize}
            onChange={(e) => setFontSize(e.target.value)}
            style={{ border: '1px solid #ddd', borderRadius: '4px' }}
          >
            <option value="8">8px</option>
            <option value="10">10px</option>
            <option value="12">12px</option>
            <option value="14">14px</option>
            <option value="16">16px</option>
            <option value="18">18px</option>
            <option value="20">20px</option>
            <option value="24">24px</option>
            <option value="32">32px</option>
          </select>
          <input
            type="color"
            value={fontColor}
            onChange={(e) => setFontColor(e.target.value)}
            style={{ width: '30px', height: '30px', border: 'none', borderRadius: '4px' }}
            title="Text Color"
          />
        </div>

        <textarea
          className="rich-text-editor"
          value={content}
          onChange={(e) => setContent(e.target.value)}
          placeholder="Start typing your document here..."
          style={{
            fontFamily: 'inherit',
            fontSize: `${fontSize}px`,
            color: fontColor,
            textAlign: alignment,
            fontWeight: isBold ? 'bold' : 'normal',
            fontStyle: isItalic ? 'italic' : 'normal',
            textDecoration: isUnderline ? 'underline' : 'none'
          }}
        />
      </div>

      <div className="card">
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1rem' }}>
          <h2>Document Actions</h2>
          <div style={{ display: 'flex', gap: '1rem' }}>
            <button className="btn" onClick={saveDocument}>
              Save Document
            </button>
            <button className="btn btn-secondary" onClick={loadDocument}>
              Load Document
            </button>
            <button className="btn btn-secondary" onClick={printDocument}>
              Print
            </button>
          </div>
        </div>
        <div style={{ display: 'flex', gap: '2rem', color: '#666' }}>
          <span>Words: {getWordCount()}</span>
          <span>Characters: {getCharacterCount()}</span>
          <span>Lines: {content.split('\n').length}</span>
        </div>
      </div>

      {showImageModal && (
        <div className="modal">
          <div className="modal-content">
            <div className="modal-header">
              <h3 className="modal-title">Insert Image</h3>
              <button className="modal-close" onClick={() => setShowImageModal(false)}>
                ×
              </button>
            </div>
            <div className="form-group">
              <label className="form-label">Image URL</label>
              <input
                type="url"
                className="form-control"
                placeholder="https://example.com/image.jpg"
              />
            </div>
            <div className="form-group">
              <label className="form-label">Alt Text</label>
              <input
                type="text"
                className="form-control"
                placeholder="Describe the image"
              />
            </div>
            <div className="modal-footer">
              <button className="btn btn-secondary" onClick={() => setShowImageModal(false)}>
                Cancel
              </button>
              <button className="btn" onClick={() => setShowImageModal(false)}>
                Insert Image
              </button>
            </div>
          </div>
        </div>
      )}

      {showLinkModal && (
        <div className="modal">
          <div className="modal-content">
            <div className="modal-header">
              <h3 className="modal-title">Insert Link</h3>
              <button className="modal-close" onClick={() => setShowLinkModal(false)}>
                ×
              </button>
            </div>
            <div className="form-group">
              <label className="form-label">Link URL</label>
              <input
                type="url"
                className="form-control"
                placeholder="https://example.com"
              />
            </div>
            <div className="form-group">
              <label className="form-label">Link Text</label>
              <input
                type="text"
                className="form-control"
                placeholder="Click here"
              />
            </div>
            <div className="modal-footer">
              <button className="btn btn-secondary" onClick={() => setShowLinkModal(false)}>
                Cancel
              </button>
              <button className="btn" onClick={() => setShowLinkModal(false)}>
                Insert Link
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default RichTextEditor;
