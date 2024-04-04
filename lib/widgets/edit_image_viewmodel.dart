import 'package:flutter/material.dart';
import 'package:text_editor_app/models/text_info.dart';
import 'package:text_editor_app/onboarding_screen.dart';
import 'package:text_editor_app/widgets/default_button.dart';

abstract class EditImageViewModel extends State<OnBoardingScreen> {
  TextEditingController textEditingController = TextEditingController();
  int currentTextIndex = 0;
  int currentTextHistoryListIndex = 0;

  List<List<TextInfo>> textHistoryList = [];

  List<TextInfo> currTexts = [];

  removeText(BuildContext context) {
    setState(() {
      currTexts.removeAt(currentTextIndex);
      Navigator.of(context).pop();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Deleted',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  setCurrentIndex(BuildContext context, int index) {
    setState(() {
      currentTextIndex = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.blueGrey,
        content: Text(
          'Text selected for Styling',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  String selectedFont = 'Roboto';

  void updateTextHistoryList(List<TextInfo> newTextList) {
    textHistoryList.add(newTextList);
    currentTextHistoryListIndex = textHistoryList.length - 1;
  }

  void changeFont(String newFont) {
    print(textHistoryList);
    setState(() {
      selectedFont = newFont;
      currTexts[currentTextIndex].fontFamily = selectedFont;
      updateTextHistoryList(currTexts);
    });
  }

  changeTextColor(Color color) {
    setState(() {
      currTexts[currentTextIndex].color = color;
      updateTextHistoryList(currTexts);
    });
  }

  increaseFontSize() {
    setState(() {
      currTexts[currentTextIndex].fontSize += 2;
      updateTextHistoryList(currTexts);
    });
  }

  decreaseFontSize() {
    setState(() {
      currTexts[currentTextIndex].fontSize -= 2;
      updateTextHistoryList(currTexts);
    });
  }

  alignLeft() {
    setState(() {
      currTexts[currentTextIndex].textAlign = TextAlign.left;
      updateTextHistoryList(currTexts);
    });
  }

  alignCenter() {
    setState(() {
      currTexts[currentTextIndex].textAlign = TextAlign.center;
      updateTextHistoryList(currTexts);
    });
  }

  alignRight() {
    setState(() {
      currTexts[currentTextIndex].textAlign = TextAlign.right;
      updateTextHistoryList(currTexts);
    });
  }

  boldText() {
    setState(() {
      if (currTexts[currentTextIndex].fontWeight == FontWeight.bold) {
        currTexts[currentTextIndex].fontWeight = FontWeight.normal;
      } else {
        currTexts[currentTextIndex].fontWeight = FontWeight.bold;
      }
      updateTextHistoryList(currTexts);
    });
  }

  italicText() {
    setState(() {
      if (currTexts[currentTextIndex].fontStyle == FontStyle.italic) {
        currTexts[currentTextIndex].fontStyle = FontStyle.normal;
      } else {
        currTexts[currentTextIndex].fontStyle = FontStyle.italic;
      }
      updateTextHistoryList(currTexts);
    });
  }

  addLinesToText() {
    setState(() {
      if (currTexts[currentTextIndex].text.contains('\n')) {
        currTexts[currentTextIndex].text =
            currTexts[currentTextIndex].text.replaceAll('\n', ' ');
      } else {
        currTexts[currentTextIndex].text =
            currTexts[currentTextIndex].text.replaceAll(' ', '\n');
      }
      updateTextHistoryList(currTexts);
    });
  }

  addNewText(BuildContext context) {
    setState(() {
      currTexts.add(
        TextInfo(
            text: textEditingController.text,
            left: 0,
            top: 0,
            color: Colors.black,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            textAlign: TextAlign.left),
      );
      updateTextHistoryList(currTexts);
      Navigator.of(context).pop();
    });
  }

  addNewDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Add New Text',
        ),
        content: TextField(
          controller: textEditingController,
          maxLines: 5,
          decoration: const InputDecoration(
            suffixIcon: Icon(
              Icons.edit,
            ),
            filled: true,
            hintText: 'Your Text Here..',
          ),
        ),
        actions: <Widget>[
          DefaultButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Back'),
            color: Colors.white,
            textColor: Color.fromARGB(255, 243, 193, 250),
          ),
          DefaultButton(
            onPressed: () => addNewText(context),
            child: const Text('Add Text'),
            color: Color.fromARGB(255, 205, 158, 216),
            textColor: Color.fromARGB(255, 0, 0, 0),
          ),
        ],
      ),
    );
  }

  addDeleteDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Do you want to delete this text?',
        ),
        actions: <Widget>[
          DefaultButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Back'),
            color: Colors.white,
            textColor: Color.fromARGB(255, 243, 193, 250),
          ),
          DefaultButton(
            onPressed: () => removeText(context),
            child: const Text('DELETE'),
            color: Color.fromARGB(255, 205, 158, 216),
            textColor: Color.fromARGB(255, 0, 0, 0),
          ),
        ],
      ),
    );
  }
}
