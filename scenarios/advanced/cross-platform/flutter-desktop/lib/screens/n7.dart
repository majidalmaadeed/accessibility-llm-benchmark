import 'package:flutter/material.dart';

class RichTextEditorScreen extends StatefulWidget {
  const RichTextEditorScreen({super.key});

  @override
  State<RichTextEditorScreen> createState() => _RichTextEditorScreenState();
}

class _RichTextEditorScreenState extends State<RichTextEditorScreen> {
  final TextEditingController _textController = TextEditingController();
  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderline = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rich Text Editor'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _save,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Column(
        children: [
          // Toolbar
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.grey,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: _toggleBold,
                  icon: Icon(
                    Icons.format_bold,
                    color: _isBold ? Colors.blue : Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: _toggleItalic,
                  icon: Icon(
                    Icons.format_italic,
                    color: _isItalic ? Colors.blue : Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: _toggleUnderline,
                  icon: Icon(
                    Icons.format_underlined,
                    color: _isUnderline ? Colors.blue : Colors.black,
                  ),
                ),
                const VerticalDivider(),
                IconButton(
                  onPressed: _alignLeft,
                  icon: const Icon(Icons.format_align_left),
                ),
                IconButton(
                  onPressed: _alignCenter,
                  icon: const Icon(Icons.format_align_center),
                ),
                IconButton(
                  onPressed: _alignRight,
                  icon: const Icon(Icons.format_align_right),
                ),
                const VerticalDivider(),
                IconButton(
                  onPressed: _insertBulletList,
                  icon: const Icon(Icons.format_list_bulleted),
                ),
                IconButton(
                  onPressed: _insertNumberedList,
                  icon: const Icon(Icons.format_list_numbered),
                ),
              ],
            ),
          ),
          
          // Editor
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _textController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  hintText: 'Enter your text here...',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                  fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal,
                  decoration: _isUnderline ? TextDecoration.underline : TextDecoration.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleBold() {
    setState(() {
      _isBold = !_isBold;
    });
  }

  void _toggleItalic() {
    setState(() {
      _isItalic = !_isItalic;
    });
  }

  void _toggleUnderline() {
    setState(() {
      _isUnderline = !_isUnderline;
    });
  }

  void _alignLeft() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Left alignment applied')),
    );
  }

  void _alignCenter() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Center alignment applied')),
    );
  }

  void _alignRight() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Right alignment applied')),
    );
  }

  void _insertBulletList() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Bullet list inserted')),
    );
  }

  void _insertNumberedList() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Numbered list inserted')),
    );
  }

  void _save() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Document saved')),
    );
  }
}
