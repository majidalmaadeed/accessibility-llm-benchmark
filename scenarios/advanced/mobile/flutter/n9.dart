import 'package:flutter/material.dart';

class RichTextEditor extends StatefulWidget {
  const RichTextEditor({Key? key}) : super(key: key);

  @override
  State<RichTextEditor> createState() => _RichTextEditorState();
}

class _RichTextEditorState extends State<RichTextEditor> {
  final TextEditingController _controller = TextEditingController();
  bool isBold = false;
  bool isItalic = false;
  bool isUnderline = false;
  double fontSize = 16;
  Color textColor = Colors.black;
  Color backgroundColor = Colors.white;
  TextAlign alignment = TextAlign.left;
  bool showStylePanel = false;
  bool showMediaPanel = false;
  bool showColorPicker = false;
  String colorType = 'text'; // text or background
  int wordCount = 0;
  int charCount = 0;
  bool isUndoAvailable = false;
  bool isRedoAvailable = false;
  List<String> history = [''];
  int historyIndex = 0;
  bool showWordCount = false;
  bool showInsertMenu = false;

  final List<double> fontSizes = [12, 14, 16, 18, 20, 24, 28, 32, 36, 48];
  final List<Color> colors = [
    Colors.black, Colors.grey[800]!, Colors.grey[600]!, Colors.grey[400]!, Colors.grey[200]!,
    Colors.red, Colors.orange, Colors.amber, Colors.green, Colors.blue,
    Colors.purple, Colors.pink, Colors.white, Colors.red[100]!, Colors.green[100]!,
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateCounts);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateCounts() {
    final text = _controller.text;
    setState(() {
      wordCount = text.trim().split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length;
      charCount = text.length;
    });
  }

  void _updateHistory() {
    final newHistory = history.sublist(0, historyIndex + 1);
    newHistory.add(_controller.text);
    setState(() {
      history = newHistory;
      historyIndex = newHistory.length - 1;
      isUndoAvailable = historyIndex > 0;
      isRedoAvailable = historyIndex < newHistory.length - 1;
    });
  }

  void _handleUndo() {
    if (historyIndex > 0) {
      setState(() {
        historyIndex--;
        _controller.text = history[historyIndex];
        isUndoAvailable = historyIndex > 0;
        isRedoAvailable = true;
      });
    }
  }

  void _handleRedo() {
    if (historyIndex < history.length - 1) {
      setState(() {
        historyIndex++;
        _controller.text = history[historyIndex];
        isUndoAvailable = true;
        isRedoAvailable = historyIndex < history.length - 1;
      });
    }
  }

  void _handleBold() {
    setState(() {
      isBold = !isBold;
    });
    // In a real implementation, this would apply bold formatting to selected text
  }

  void _handleItalic() {
    setState(() {
      isItalic = !isItalic;
    });
    // In a real implementation, this would apply italic formatting to selected text
  }

  void _handleUnderline() {
    setState(() {
      isUnderline = !isUnderline;
    });
    // In a real implementation, this would apply underline formatting to selected text
  }

  void _handleFontSizeChange(double size) {
    setState(() {
      fontSize = size;
      showStylePanel = false;
    });
  }

  void _handleColorChange(Color color) {
    setState(() {
      if (colorType == 'text') {
        textColor = color;
      } else {
        backgroundColor = color;
      }
      showColorPicker = false;
    });
  }

  void _handleAlignmentChange(TextAlign align) {
    setState(() {
      alignment = align;
    });
  }

  void _handleInsertImage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Image insertion functionality would be implemented here')),
    );
    setShowInsertMenu(false);
  }

  void _handleInsertLink() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Link insertion functionality would be implemented here')),
    );
    setShowInsertMenu(false);
  }

  void _handleInsertTable() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Table insertion functionality would be implemented here')),
    );
    setShowInsertMenu(false);
  }

  void _handleInsertList() {
    final listItem = '• List item\n';
    _controller.text += listItem;
    _updateHistory();
    setShowInsertMenu(false);
  }

  void _handleSave() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Document saved successfully')),
    );
  }

  void _handleExport() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export'),
        content: const Text('Choose export format'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Exporting as PDF...')),
              );
            },
            child: const Text('PDF'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Exporting as Word...')),
              );
            },
            child: const Text('Word'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Exporting as HTML...')),
              );
            },
            child: const Text('HTML'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Rich Text Editor'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _handleSave,
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _handleExport,
          ),
          IconButton(
            icon: const Icon(Icons.analytics),
            onPressed: () => setState(() => showWordCount = !showWordCount),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildToolbar(),
          if (showWordCount) _buildWordCountPanel(),
          Expanded(
            child: _buildEditor(),
          ),
        ],
      ),
    );
  }

  Widget _buildToolbar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildToolbarGroup([
              _buildToolbarButton(
                icon: Icons.undo,
                isActive: isUndoAvailable,
                onPressed: isUndoAvailable ? _handleUndo : null,
              ),
              _buildToolbarButton(
                icon: Icons.redo,
                isActive: isRedoAvailable,
                onPressed: isRedoAvailable ? _handleRedo : null,
              ),
            ]),
            _buildToolbarSeparator(),
            _buildToolbarGroup([
              _buildToolbarButton(
                icon: Icons.format_bold,
                isActive: isBold,
                onPressed: _handleBold,
              ),
              _buildToolbarButton(
                icon: Icons.format_italic,
                isActive: isItalic,
                onPressed: _handleItalic,
              ),
              _buildToolbarButton(
                icon: Icons.format_underlined,
                isActive: isUnderline,
                onPressed: _handleUnderline,
              ),
            ]),
            _buildToolbarSeparator(),
            _buildToolbarGroup([
              _buildToolbarButton(
                text: fontSize.toInt().toString(),
                onPressed: () => setState(() => showStylePanel = true),
              ),
              _buildColorButton(
                color: textColor,
                onPressed: () {
                  setState(() {
                    colorType = 'text';
                    showColorPicker = true;
                  });
                },
              ),
              _buildColorButton(
                color: backgroundColor,
                onPressed: () {
                  setState(() {
                    colorType = 'background';
                    showColorPicker = true;
                  });
                },
              ),
            ]),
            _buildToolbarSeparator(),
            _buildToolbarGroup([
              _buildToolbarButton(
                icon: Icons.format_align_left,
                isActive: alignment == TextAlign.left,
                onPressed: () => _handleAlignmentChange(TextAlign.left),
              ),
              _buildToolbarButton(
                icon: Icons.format_align_center,
                isActive: alignment == TextAlign.center,
                onPressed: () => _handleAlignmentChange(TextAlign.center),
              ),
              _buildToolbarButton(
                icon: Icons.format_align_right,
                isActive: alignment == TextAlign.right,
                onPressed: () => _handleAlignmentChange(TextAlign.right),
              ),
            ]),
            _buildToolbarSeparator(),
            _buildToolbarGroup([
              _buildToolbarButton(
                icon: Icons.add,
                onPressed: () => setState(() => showInsertMenu = true),
              ),
              _buildToolbarButton(
                icon: Icons.analytics,
                onPressed: () => setState(() => showWordCount = !showWordCount),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildToolbarGroup(List<Widget> children) {
    return Row(
      children: children.map((child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: child,
      )).toList(),
    );
  }

  Widget _buildToolbarSeparator() {
    return Container(
      width: 1,
      height: 32,
      color: Colors.grey[300],
      margin: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  Widget _buildToolbarButton({
    IconData? icon,
    String? text,
    bool isActive = false,
    VoidCallback? onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isActive ? Colors.blue[100] : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: icon != null
              ? Icon(
                  icon,
                  size: 20,
                  color: isActive ? Colors.blue : Colors.grey[600],
                )
              : Text(
                  text ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildColorButton({
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[300]!),
        ),
      ),
    );
  }

  Widget _buildWordCountPanel() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey[200],
      child: Text(
        'Words: $wordCount | Characters: $charCount',
        style: const TextStyle(fontSize: 12, color: Colors.grey),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildEditor() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _controller,
        style: TextStyle(
          fontSize: fontSize,
          color: textColor,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
          decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
        ),
        textAlign: alignment,
        maxLines: null,
        expands: true,
        decoration: const InputDecoration(
          hintText: 'Start typing your document...',
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16),
        ),
        onChanged: (text) => _updateHistory(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Rich Text Editor'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _handleSave,
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _handleExport,
          ),
          IconButton(
            icon: const Icon(Icons.analytics),
            onPressed: () => setState(() => showWordCount = !showWordCount),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildToolbar(),
          if (showWordCount) _buildWordCountPanel(),
          Expanded(
            child: _buildEditor(),
          ),
        ],
      ),
      bottomSheet: showStylePanel ? _buildStylePanel() : null,
      bottomSheet: showColorPicker ? _buildColorPicker() : null,
      bottomSheet: showInsertMenu ? _buildInsertMenu() : null,
    );
  }

  Widget _buildStylePanel() {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Font Size',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => setState(() => showStylePanel = false),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: fontSizes.length,
              itemBuilder: (context, index) {
                final size = fontSizes[index];
                final isSelected = fontSize == size;
                return ListTile(
                  title: Text(
                    '${size.toInt()}pt',
                    style: TextStyle(fontSize: size),
                  ),
                  trailing: isSelected ? const Icon(Icons.check, color: Colors.blue) : null,
                  onTap: () => _handleFontSizeChange(size),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorPicker() {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  colorType == 'text' ? 'Text Color' : 'Background Color',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => setState(() => showColorPicker = false),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: colors.length,
              itemBuilder: (context, index) {
                final color = colors[index];
                final isSelected = (colorType == 'text' ? textColor : backgroundColor) == color;
                return GestureDetector(
                  onTap: () => _handleColorChange(color),
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.grey[300]!,
                        width: isSelected ? 3 : 1,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          )
                        : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsertMenu() {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Insert',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => setState(() => showInsertMenu = false),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInsertMenuItem(
                  icon: Icons.image,
                  label: 'Image',
                  onTap: _handleInsertImage,
                ),
                _buildInsertMenuItem(
                  icon: Icons.link,
                  label: 'Link',
                  onTap: _handleInsertLink,
                ),
                _buildInsertMenuItem(
                  icon: Icons.grid_on,
                  label: 'Table',
                  onTap: _handleInsertTable,
                ),
                _buildInsertMenuItem(
                  icon: Icons.list,
                  label: 'List',
                  onTap: _handleInsertList,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsertMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: Colors.blue),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
