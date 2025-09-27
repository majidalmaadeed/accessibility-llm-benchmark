import React, { useState, useRef } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  TextInput,
  ScrollView,
  StyleSheet,
  Modal,
  Alert,
  Dimensions,
  KeyboardAvoidingView,
  Platform,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';

const { width, height } = Dimensions.get('window');

const RichTextEditor = () => {
  const [content, setContent] = useState('');
  const [isBold, setIsBold] = useState(false);
  const [isItalic, setIsItalic] = useState(false);
  const [isUnderline, setIsUnderline] = useState(false);
  const [fontSize, setFontSize] = useState(16);
  const [textColor, setTextColor] = useState('#000000');
  const [backgroundColor, setBackgroundColor] = useState('#FFFFFF');
  const [alignment, setAlignment] = useState('left');
  const [showStylePanel, setShowStylePanel] = useState(false);
  const [showMediaPanel, setShowMediaPanel] = useState(false);
  const [showColorPicker, setShowColorPicker] = useState(false);
  const [colorType, setColorType] = useState('text'); // text or background
  const [wordCount, setWordCount] = useState(0);
  const [charCount, setCharCount] = useState(0);
  const [isUndoAvailable, setIsUndoAvailable] = useState(false);
  const [isRedoAvailable, setIsRedoAvailable] = useState(false);
  const [history, setHistory] = useState(['']);
  const [historyIndex, setHistoryIndex] = useState(0);
  const [showWordCount, setShowWordCount] = useState(false);
  const [showInsertMenu, setShowInsertMenu] = useState(false);

  const textInputRef = useRef(null);

  const fontSizes = [12, 14, 16, 18, 20, 24, 28, 32, 36, 48];
  const colors = [
    '#000000', '#333333', '#666666', '#999999', '#CCCCCC',
    '#FF0000', '#FF6600', '#FFCC00', '#00FF00', '#0066FF',
    '#6600FF', '#FF00CC', '#FFFFFF', '#FFCCCC', '#CCFFCC',
  ];

  const updateContent = (newContent) => {
    setContent(newContent);
    setWordCount(newContent.trim().split(/\s+/).filter(word => word.length > 0).length);
    setCharCount(newContent.length);
    
    // Update history
    const newHistory = history.slice(0, historyIndex + 1);
    newHistory.push(newContent);
    setHistory(newHistory);
    setHistoryIndex(newHistory.length - 1);
    setIsUndoAvailable(historyIndex > 0);
    setIsRedoAvailable(historyIndex < newHistory.length - 1);
  };

  const handleUndo = () => {
    if (historyIndex > 0) {
      const newIndex = historyIndex - 1;
      setHistoryIndex(newIndex);
      setContent(history[newIndex]);
      setIsUndoAvailable(newIndex > 0);
      setIsRedoAvailable(true);
    }
  };

  const handleRedo = () => {
    if (historyIndex < history.length - 1) {
      const newIndex = historyIndex + 1;
      setHistoryIndex(newIndex);
      setContent(history[newIndex]);
      setIsUndoAvailable(true);
      setIsRedoAvailable(newIndex < history.length - 1);
    }
  };

  const handleBold = () => {
    setIsBold(!isBold);
    // In a real implementation, this would apply bold formatting to selected text
  };

  const handleItalic = () => {
    setIsItalic(!isItalic);
    // In a real implementation, this would apply italic formatting to selected text
  };

  const handleUnderline = () => {
    setIsUnderline(!isUnderline);
    // In a real implementation, this would apply underline formatting to selected text
  };

  const handleFontSizeChange = (size) => {
    setFontSize(size);
    setShowStylePanel(false);
  };

  const handleColorChange = (color) => {
    if (colorType === 'text') {
      setTextColor(color);
    } else {
      setBackgroundColor(color);
    }
    setShowColorPicker(false);
  };

  const handleAlignmentChange = (align) => {
    setAlignment(align);
  };

  const handleInsertImage = () => {
    Alert.alert('Insert Image', 'Image insertion functionality would be implemented here');
    setShowInsertMenu(false);
  };

  const handleInsertLink = () => {
    Alert.alert('Insert Link', 'Link insertion functionality would be implemented here');
    setShowInsertMenu(false);
  };

  const handleInsertTable = () => {
    Alert.alert('Insert Table', 'Table insertion functionality would be implemented here');
    setShowInsertMenu(false);
  };

  const handleInsertList = () => {
    const listItem = '• List item\n';
    updateContent(content + listItem);
    setShowInsertMenu(false);
  };

  const handleSave = () => {
    Alert.alert('Save', 'Document saved successfully');
  };

  const handleExport = () => {
    Alert.alert('Export', 'Choose export format', [
      { text: 'PDF', onPress: () => console.log('Export as PDF') },
      { text: 'Word', onPress: () => console.log('Export as Word') },
      { text: 'HTML', onPress: () => console.log('Export as HTML') },
      { text: 'Cancel', style: 'cancel' },
    ]);
  };

  const renderToolbar = () => (
    <View style={styles.toolbar}>
      <ScrollView horizontal showsHorizontalScrollIndicator={false}>
        <View style={styles.toolbarGroup}>
          <TouchableOpacity
            style={[styles.toolbarButton, isUndoAvailable && styles.toolbarButtonActive]}
            onPress={handleUndo}
            disabled={!isUndoAvailable}
          >
            <Ionicons name="arrow-undo" size={20} color={isUndoAvailable ? "#007AFF" : "#999"} />
          </TouchableOpacity>

          <TouchableOpacity
            style={[styles.toolbarButton, isRedoAvailable && styles.toolbarButtonActive]}
            onPress={handleRedo}
            disabled={!isRedoAvailable}
          >
            <Ionicons name="arrow-redo" size={20} color={isRedoAvailable ? "#007AFF" : "#999"} />
          </TouchableOpacity>
        </View>

        <View style={styles.toolbarSeparator} />

        <View style={styles.toolbarGroup}>
          <TouchableOpacity
            style={[styles.toolbarButton, isBold && styles.toolbarButtonActive]}
            onPress={handleBold}
          >
            <Ionicons name="text" size={20} color={isBold ? "#007AFF" : "#333"} />
          </TouchableOpacity>

          <TouchableOpacity
            style={[styles.toolbarButton, isItalic && styles.toolbarButtonActive]}
            onPress={handleItalic}
          >
            <Ionicons name="text" size={20} color={isItalic ? "#007AFF" : "#333"} />
          </TouchableOpacity>

          <TouchableOpacity
            style={[styles.toolbarButton, isUnderline && styles.toolbarButtonActive]}
            onPress={handleUnderline}
          >
            <Ionicons name="text" size={20} color={isUnderline ? "#007AFF" : "#333"} />
          </TouchableOpacity>
        </View>

        <View style={styles.toolbarSeparator} />

        <View style={styles.toolbarGroup}>
          <TouchableOpacity
            style={styles.toolbarButton}
            onPress={() => setShowStylePanel(true)}
          >
            <Text style={styles.fontSizeText}>{fontSize}</Text>
          </TouchableOpacity>

          <TouchableOpacity
            style={styles.toolbarButton}
            onPress={() => {
              setColorType('text');
              setShowColorPicker(true);
            }}
          >
            <View style={[styles.colorButton, { backgroundColor: textColor }]} />
          </TouchableOpacity>

          <TouchableOpacity
            style={styles.toolbarButton}
            onPress={() => {
              setColorType('background');
              setShowColorPicker(true);
            }}
          >
            <View style={[styles.colorButton, { backgroundColor: backgroundColor }]} />
          </TouchableOpacity>
        </View>

        <View style={styles.toolbarSeparator} />

        <View style={styles.toolbarGroup}>
          <TouchableOpacity
            style={[styles.toolbarButton, alignment === 'left' && styles.toolbarButtonActive]}
            onPress={() => handleAlignmentChange('left')}
          >
            <Ionicons name="text" size={20} color={alignment === 'left' ? "#007AFF" : "#333"} />
          </TouchableOpacity>

          <TouchableOpacity
            style={[styles.toolbarButton, alignment === 'center' && styles.toolbarButtonActive]}
            onPress={() => handleAlignmentChange('center')}
          >
            <Ionicons name="text" size={20} color={alignment === 'center' ? "#007AFF" : "#333"} />
          </TouchableOpacity>

          <TouchableOpacity
            style={[styles.toolbarButton, alignment === 'right' && styles.toolbarButtonActive]}
            onPress={() => handleAlignmentChange('right')}
          >
            <Ionicons name="text" size={20} color={alignment === 'right' ? "#007AFF" : "#333"} />
          </TouchableOpacity>
        </View>

        <View style={styles.toolbarSeparator} />

        <View style={styles.toolbarGroup}>
          <TouchableOpacity
            style={styles.toolbarButton}
            onPress={() => setShowInsertMenu(true)}
          >
            <Ionicons name="add" size={20} color="#333" />
          </TouchableOpacity>

          <TouchableOpacity
            style={styles.toolbarButton}
            onPress={() => setShowWordCount(!showWordCount)}
          >
            <Ionicons name="stats-chart" size={20} color="#333" />
          </TouchableOpacity>
        </View>
      </ScrollView>
    </View>
  );

  const renderStylePanel = () => (
    <Modal
      visible={showStylePanel}
      animationType="slide"
      transparent={true}
      onRequestClose={() => setShowStylePanel(false)}
    >
      <View style={styles.modalOverlay}>
        <View style={styles.modalContent}>
          <View style={styles.modalHeader}>
            <Text style={styles.modalTitle}>Font Size</Text>
            <TouchableOpacity onPress={() => setShowStylePanel(false)}>
              <Ionicons name="close" size={24} color="#666" />
            </TouchableOpacity>
          </View>
          
          <ScrollView style={styles.fontSizeList}>
            {fontSizes.map((size) => (
              <TouchableOpacity
                key={size}
                style={[
                  styles.fontSizeItem,
                  fontSize === size && styles.fontSizeItemSelected,
                ]}
                onPress={() => handleFontSizeChange(size)}
              >
                <Text style={[styles.fontSizeItemText, { fontSize: size }]}>
                  {size}pt
                </Text>
                {fontSize === size && (
                  <Ionicons name="checkmark" size={20} color="#007AFF" />
                )}
              </TouchableOpacity>
            ))}
          </ScrollView>
        </View>
      </View>
    </Modal>
  );

  const renderColorPicker = () => (
    <Modal
      visible={showColorPicker}
      animationType="slide"
      transparent={true}
      onRequestClose={() => setShowColorPicker(false)}
    >
      <View style={styles.modalOverlay}>
        <View style={styles.modalContent}>
          <View style={styles.modalHeader}>
            <Text style={styles.modalTitle}>
              {colorType === 'text' ? 'Text Color' : 'Background Color'}
            </Text>
            <TouchableOpacity onPress={() => setShowColorPicker(false)}>
              <Ionicons name="close" size={24} color="#666" />
            </TouchableOpacity>
          </View>
          
          <View style={styles.colorGrid}>
            {colors.map((color) => (
              <TouchableOpacity
                key={color}
                style={[
                  styles.colorItem,
                  { backgroundColor: color },
                  (colorType === 'text' ? textColor : backgroundColor) === color && styles.colorItemSelected,
                ]}
                onPress={() => handleColorChange(color)}
              >
                {(colorType === 'text' ? textColor : backgroundColor) === color && (
                  <Ionicons name="checkmark" size={16} color={color === '#FFFFFF' ? '#000' : '#FFF'} />
                )}
              </TouchableOpacity>
            ))}
          </View>
        </View>
      </View>
    </Modal>
  );

  const renderInsertMenu = () => (
    <Modal
      visible={showInsertMenu}
      animationType="slide"
      transparent={true}
      onRequestClose={() => setShowInsertMenu(false)}
    >
      <View style={styles.modalOverlay}>
        <View style={styles.modalContent}>
          <View style={styles.modalHeader}>
            <Text style={styles.modalTitle}>Insert</Text>
            <TouchableOpacity onPress={() => setShowInsertMenu(false)}>
              <Ionicons name="close" size={24} color="#666" />
            </TouchableOpacity>
          </View>
          
          <View style={styles.insertMenu}>
            <TouchableOpacity style={styles.insertMenuItem} onPress={handleInsertImage}>
              <Ionicons name="image" size={24} color="#007AFF" />
              <Text style={styles.insertMenuText}>Image</Text>
            </TouchableOpacity>

            <TouchableOpacity style={styles.insertMenuItem} onPress={handleInsertLink}>
              <Ionicons name="link" size={24} color="#007AFF" />
              <Text style={styles.insertMenuText}>Link</Text>
            </TouchableOpacity>

            <TouchableOpacity style={styles.insertMenuItem} onPress={handleInsertTable}>
              <Ionicons name="grid" size={24} color="#007AFF" />
              <Text style={styles.insertMenuText}>Table</Text>
            </TouchableOpacity>

            <TouchableOpacity style={styles.insertMenuItem} onPress={handleInsertList}>
              <Ionicons name="list" size={24} color="#007AFF" />
              <Text style={styles.insertMenuText}>List</Text>
            </TouchableOpacity>
          </View>
        </View>
      </View>
    </Modal>
  );

  const renderWordCount = () => (
    <View style={styles.wordCountPanel}>
      <Text style={styles.wordCountText}>
        Words: {wordCount} | Characters: {charCount}
      </Text>
    </View>
  );

  const renderEditor = () => (
    <KeyboardAvoidingView
      style={styles.editorContainer}
      behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
    >
      <TextInput
        ref={textInputRef}
        style={[
          styles.textEditor,
          {
            fontSize: fontSize,
            color: textColor,
            backgroundColor: backgroundColor,
            textAlign: alignment,
          },
        ]}
        value={content}
        onChangeText={updateContent}
        placeholder="Start typing your document..."
        placeholderTextColor="#999"
        multiline
        textAlignVertical="top"
      />
    </KeyboardAvoidingView>
  );

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <View style={styles.headerLeft}>
          <TouchableOpacity style={styles.headerButton} onPress={handleSave}>
            <Ionicons name="save" size={20} color="#007AFF" />
            <Text style={styles.headerButtonText}>Save</Text>
          </TouchableOpacity>

          <TouchableOpacity style={styles.headerButton} onPress={handleExport}>
            <Ionicons name="download" size={20} color="#007AFF" />
            <Text style={styles.headerButtonText}>Export</Text>
          </TouchableOpacity>
        </View>

        <Text style={styles.headerTitle}>Rich Text Editor</Text>

        <View style={styles.headerRight}>
          <TouchableOpacity
            style={styles.headerButton}
            onPress={() => setShowWordCount(!showWordCount)}
          >
            <Ionicons name="stats-chart" size={20} color="#007AFF" />
          </TouchableOpacity>
        </View>
      </View>

      {renderToolbar()}
      {showWordCount && renderWordCount()}
      {renderEditor()}

      {renderStylePanel()}
      {renderColorPicker()}
      {renderInsertMenu()}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 16,
    backgroundColor: '#fff',
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  headerLeft: {
    flexDirection: 'row',
    gap: 12,
  },
  headerRight: {
    flexDirection: 'row',
    gap: 12,
  },
  headerTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
  },
  headerButton: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 12,
    paddingVertical: 8,
    backgroundColor: '#f0f0f0',
    borderRadius: 8,
    gap: 4,
  },
  headerButtonText: {
    color: '#007AFF',
    fontSize: 14,
    fontWeight: '500',
  },
  toolbar: {
    backgroundColor: '#fff',
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
    paddingVertical: 8,
  },
  toolbarGroup: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 8,
  },
  toolbarSeparator: {
    width: 1,
    height: 32,
    backgroundColor: '#e0e0e0',
    marginHorizontal: 4,
  },
  toolbarButton: {
    width: 40,
    height: 40,
    justifyContent: 'center',
    alignItems: 'center',
    borderRadius: 6,
    marginHorizontal: 2,
  },
  toolbarButtonActive: {
    backgroundColor: '#e3f2fd',
  },
  fontSizeText: {
    fontSize: 14,
    fontWeight: '600',
    color: '#333',
  },
  colorButton: {
    width: 20,
    height: 20,
    borderRadius: 10,
    borderWidth: 1,
    borderColor: '#e0e0e0',
  },
  editorContainer: {
    flex: 1,
    padding: 16,
  },
  textEditor: {
    flex: 1,
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
    backgroundColor: '#fff',
    borderRadius: 8,
    padding: 16,
    textAlignVertical: 'top',
  },
  wordCountPanel: {
    backgroundColor: '#f0f0f0',
    paddingHorizontal: 16,
    paddingVertical: 8,
    borderTopWidth: 1,
    borderTopColor: '#e0e0e0',
  },
  wordCountText: {
    fontSize: 12,
    color: '#666',
    textAlign: 'center',
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  modalContent: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 20,
    width: width - 40,
    maxHeight: height * 0.6,
  },
  modalHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 20,
  },
  modalTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
  },
  fontSizeList: {
    maxHeight: 300,
  },
  fontSizeItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: 12,
    paddingHorizontal: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#f0f0f0',
  },
  fontSizeItemSelected: {
    backgroundColor: '#e3f2fd',
  },
  fontSizeItemText: {
    fontSize: 16,
    color: '#333',
  },
  colorGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
  },
  colorItem: {
    width: 40,
    height: 40,
    borderRadius: 20,
    margin: 4,
    justifyContent: 'center',
    alignItems: 'center',
    borderWidth: 2,
    borderColor: 'transparent',
  },
  colorItemSelected: {
    borderColor: '#007AFF',
  },
  insertMenu: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-around',
  },
  insertMenuItem: {
    alignItems: 'center',
    padding: 16,
    width: '45%',
    marginBottom: 16,
  },
  insertMenuText: {
    fontSize: 14,
    color: '#333',
    marginTop: 8,
  },
});

export default RichTextEditor;
