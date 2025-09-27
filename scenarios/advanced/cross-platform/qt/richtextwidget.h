#ifndef RICHTEXTWIDGET_H
#define RICHTEXTWIDGET_H

#include <QWidget>
#include <QTextEdit>
#include <QPushButton>
#include <QToolBar>
#include <QComboBox>
#include <QSpinBox>
#include <QColorDialog>
#include <QFontDialog>
#include <QFileDialog>
#include <QPrintDialog>
#include <QPrintPreviewDialog>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QGroupBox>
#include <QLabel>
#include <QCheckBox>
#include <QLineEdit>
#include <QListWidget>
#include <QTabWidget>
#include <QSplitter>

class RichTextWidget : public QWidget
{
    Q_OBJECT

public:
    explicit RichTextWidget(QWidget *parent = nullptr);

private slots:
    void bold();
    void italic();
    void underline();
    void strikeout();
    void superscript();
    void subscript();
    void alignLeft();
    void alignCenter();
    void alignRight();
    void alignJustify();
    void changeFont();
    void changeFontSize();
    void changeTextColor();
    void changeBackgroundColor();
    void insertBulletList();
    void insertNumberedList();
    void insertTable();
    void insertImage();
    void insertLink();
    void insertHorizontalLine();
    void insertPageBreak();
    void undo();
    void redo();
    void cut();
    void copy();
    void paste();
    void selectAll();
    void find();
    void replace();
    void goToLine();
    void wordCount();
    void spellCheck();
    void save();
    void saveAs();
    void open();
    void newDocument();
    void print();
    void printPreview();
    void exportPDF();
    void exportHTML();
    void exportRTF();
    void importDocument();
    void showSettings();
    void showHelp();
    void toggleFullscreen();
    void zoomIn();
    void zoomOut();
    void resetZoom();
    void toggleRuler();
    void toggleStatusBar();
    void toggleToolbar();
    void toggleSidebar();
    void changeTheme();
    void changeLanguage();
    void autoSave();
    void checkSpelling();
    void updateWordCount();
    void updateStatusBar();
    void onTextChanged();
    void onSelectionChanged();
    void onCursorPositionChanged();
    void onDocumentModified();
    void onPrintRequested();
    void onExportRequested();
    void onImportRequested();
    void onSettingsChanged();
    void onHelpRequested();

private:
    void setupUI();
    void setupToolbar();
    void setupMenuBar();
    void setupStatusBar();
    void setupSidebar();
    void setupDialogs();
    void updateToolbar();
    void updateStatusBar();
    void updateSidebar();
    void updateDialogs();
    void loadDocument();
    void saveDocument();
    void exportDocument();
    void importDocument();
    void printDocument();
    void printPreviewDocument();
    void exportToPDF();
    void exportToHTML();
    void exportToRTF();
    void importFromDocument();
    void showDocumentSettings();
    void showDocumentHelp();
    void toggleFullscreenMode();
    void zoomInDocument();
    void zoomOutDocument();
    void resetZoomDocument();
    void toggleRulerVisibility();
    void toggleStatusBarVisibility();
    void toggleToolbarVisibility();
    void toggleSidebarVisibility();
    void changeDocumentTheme();
    void changeDocumentLanguage();
    void enableAutoSave();
    void performSpellCheck();
    void updateWordCountDisplay();
    void updateStatusBarDisplay();
    void onDocumentTextChanged();
    void onDocumentSelectionChanged();
    void onDocumentCursorPositionChanged();
    void onDocumentModifiedChanged();
    void onDocumentPrintRequested();
    void onDocumentExportRequested();
    void onDocumentImportRequested();
    void onDocumentSettingsChanged();
    void onDocumentHelpRequested();
    
    // Main Editor
    QTextEdit *m_textEdit;
    QSplitter *m_splitter;
    QTabWidget *m_tabWidget;
    
    // Toolbar
    QToolBar *m_toolBar;
    QPushButton *m_boldButton;
    QPushButton *m_italicButton;
    QPushButton *m_underlineButton;
    QPushButton *m_strikeoutButton;
    QPushButton *m_superscriptButton;
    QPushButton *m_subscriptButton;
    QPushButton *m_alignLeftButton;
    QPushButton *m_alignCenterButton;
    QPushButton *m_alignRightButton;
    QPushButton *m_alignJustifyButton;
    QComboBox *m_fontCombo;
    QComboBox *m_fontSizeCombo;
    QPushButton *m_textColorButton;
    QPushButton *m_backgroundColorButton;
    QPushButton *m_bulletListButton;
    QPushButton *m_numberedListButton;
    QPushButton *m_tableButton;
    QPushButton *m_imageButton;
    QPushButton *m_linkButton;
    QPushButton *m_horizontalLineButton;
    QPushButton *m_pageBreakButton;
    
    // File Operations
    QPushButton *m_newButton;
    QPushButton *m_openButton;
    QPushButton *m_saveButton;
    QPushButton *m_saveAsButton;
    QPushButton *m_printButton;
    QPushButton *m_printPreviewButton;
    QPushButton *m_exportButton;
    QPushButton *m_importButton;
    
    // Edit Operations
    QPushButton *m_undoButton;
    QPushButton *m_redoButton;
    QPushButton *m_cutButton;
    QPushButton *m_copyButton;
    QPushButton *m_pasteButton;
    QPushButton *m_selectAllButton;
    QPushButton *m_findButton;
    QPushButton *m_replaceButton;
    QPushButton *m_goToLineButton;
    
    // View Operations
    QPushButton *m_zoomInButton;
    QPushButton *m_zoomOutButton;
    QPushButton *m_resetZoomButton;
    QPushButton *m_fullscreenButton;
    QPushButton *m_rulerButton;
    QPushButton *m_statusBarButton;
    QPushButton *m_toolbarButton;
    QPushButton *m_sidebarButton;
    
    // Tools
    QPushButton *m_wordCountButton;
    QPushButton *m_spellCheckButton;
    QPushButton *m_settingsButton;
    QPushButton *m_helpButton;
    
    // Sidebar
    QGroupBox *m_sidebarGroup;
    QListWidget *m_documentList;
    QListWidget *m_styleList;
    QListWidget *m_templateList;
    QListWidget *m_recentList;
    
    // Status Bar
    QLabel *m_statusLabel;
    QLabel *m_wordCountLabel;
    QLabel *m_lineCountLabel;
    QLabel *m_columnCountLabel;
    QLabel *m_zoomLabel;
    QLabel *m_encodingLabel;
    QLabel *m_languageLabel;
    
    // Dialogs
    QColorDialog *m_colorDialog;
    QFontDialog *m_fontDialog;
    QFileDialog *m_fileDialog;
    QPrintDialog *m_printDialog;
    QPrintPreviewDialog *m_printPreviewDialog;
    
    // Data
    QString m_currentFile;
    QString m_documentTitle;
    QString m_documentAuthor;
    QString m_documentSubject;
    QString m_documentKeywords;
    QString m_documentComments;
    QFont m_currentFont;
    QColor m_currentTextColor;
    QColor m_currentBackgroundColor;
    int m_currentFontSize;
    int m_currentZoom;
    bool m_isModified;
    bool m_isFullscreen;
    bool m_isRulerVisible;
    bool m_isStatusBarVisible;
    bool m_isToolbarVisible;
    bool m_isSidebarVisible;
    bool m_isAutoSaveEnabled;
    bool m_isSpellCheckEnabled;
    QString m_currentTheme;
    QString m_currentLanguage;
    QList<QString> m_recentFiles;
    QList<QString> m_documentStyles;
    QList<QString> m_documentTemplates;
    QMap<QString, QVariant> m_documentSettings;
    QMap<QString, QVariant> m_editorSettings;
    QMap<QString, QVariant> m_viewSettings;
    QMap<QString, QVariant> m_toolSettings;
    QMap<QString, QVariant> m_helpSettings;
};

#endif // RICHTEXTWIDGET_H
