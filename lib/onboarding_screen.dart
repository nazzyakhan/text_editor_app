import 'package:flutter/material.dart';
import 'package:text_editor/text_editor.dart';
import 'package:text_editor_app/texteditor_page.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  String _texts = "sample_text";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: PageView(
          children: [
            Stack(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/img4.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    TextEditor(
                        backgroundColor: Colors.black.withOpacity(0.5),
                        text: _texts,
                        decoration: EditorDecoration(
                          doneButton: Icon(Icons.done, color: Colors.white),
                          fontFamily: Icon(Icons.title, color: Colors.white),
                          colorPalette: Icon(Icons.palette,
                              color: Colors.white, size: 50),
                          textBackground: TextBackgroundDecoration(),
                        ),
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
                            style = TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold);
                            align = TextAlign.center;
                            text = "sample_text";
                          });
                        }),
                  ],
                ),
              ],
            ),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img6.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img2.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img4.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
