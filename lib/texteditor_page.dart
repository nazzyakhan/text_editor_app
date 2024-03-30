import 'package:flutter/material.dart';
import 'package:text_editor/text_editor.dart';

class TextEditorPage extends StatefulWidget {
  const TextEditorPage({super.key});

  @override
  State<TextEditorPage> createState() => _TextEditorPageState();
}

class _TextEditorPageState extends State<TextEditorPage> {
  String _texts = "sample_text";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextEditor(
          decoration:
              EditorDecoration(textBackground: TextBackgroundDecoration()),
          backgroundColor: Colors.red.withOpacity(0.5),
          text: _texts,
          fonts: const [
            'Roboto',
            'Lobster',
            'Caveat',
            'Pacifico',
            'Raleway',
            'DancingScript',
            'PlayfairDisplay',
            'Oswald',
            'LobsterTwo',
            'MarckScript',
            'PermanentMarker',
          ],
          onEditCompleted: (style, align, text) {
            setState(() {
              style = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
              align = TextAlign.center;
              text = "sample_text";
            });
          }),
    );
  }
}
