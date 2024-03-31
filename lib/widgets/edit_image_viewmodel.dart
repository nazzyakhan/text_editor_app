import 'package:flutter/material.dart';
import 'package:text_editor_app/models/text_info.dart';
import 'package:text_editor_app/onboarding_screen.dart';
import 'package:text_editor_app/widgets/default_button.dart';

abstract class EditImageViewModel extends State<OnBoardingScreen> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController creatorText = TextEditingController();

  List<TextInfo> texts = [];

  addNewText(BuildContext context) {
    setState(
      () {
        texts.add(
          TextInfo(
              text: textEditingController.text,
              left: 0,
              top: 0,
              color: Colors.black,
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
}
