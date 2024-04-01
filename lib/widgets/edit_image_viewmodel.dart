import 'package:flutter/material.dart';
import 'package:text_editor_app/models/text_info.dart';
import 'package:text_editor_app/onboarding_screen.dart';
import 'package:text_editor_app/widgets/default_button.dart';

abstract class EditImageViewModel extends State<OnBoardingScreen> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController creatorText = TextEditingController();
  int currentIndex = 0;
  List<TextInfo> texts = [];

  removeText(BuildContext context) {
    setState(() {
      texts.removeAt(currentIndex);
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
      currentIndex = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.blueGrey,
        content: Text('Text selected for Styling',
            style: TextStyle(
              color: Colors.white,
            )),
      ),
    );
  }

  String selectedFont = 'Roboto';

  void changeFont(String newFont) {
    setState(() {
      selectedFont = newFont;
      texts[currentIndex].fontFamily = selectedFont;
    });
  }

  changeTextColor(Color color) {
    setState(() {
      texts[currentIndex].color = color;
    });
  }

  increaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize += 2;
    });
  }

  decreaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize -= 2;
    });
  }

  alignLeft() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.left;
    });
  }

  alignCenter() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.center;
    });
  }

  alignRight() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.right;
    });
  }

  boldText() {
    setState(() {
      if (texts[currentIndex].fontWeight == FontWeight.bold) {
        texts[currentIndex].fontWeight = FontWeight.normal;
      } else {
        texts[currentIndex].fontWeight = FontWeight.bold;
      }
    });
  }

  italicText() {
    setState(() {
      if (texts[currentIndex].fontStyle == FontStyle.italic) {
        texts[currentIndex].fontStyle = FontStyle.normal;
      } else {
        texts[currentIndex].fontStyle = FontStyle.italic;
      }
    });
  }

  addLinesToText() {
    setState(() {
      if (texts[currentIndex].text.contains('\n')) {
        texts[currentIndex].text =
            texts[currentIndex].text.replaceAll('\n', ' ');
      } else {
        texts[currentIndex].text =
            texts[currentIndex].text.replaceAll(' ', '\n');
      }
    });
  }

  addNewText(BuildContext context) {
    setState(
      () {
        texts.add(
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
        Navigator.of(context).pop();
      },
    );
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
                textColor: Color.fromARGB(255, 0, 0, 0)),
          ]),
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
                textColor: Color.fromARGB(255, 0, 0, 0)),
          ]),
    );
  }
}
