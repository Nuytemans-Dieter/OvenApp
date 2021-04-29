import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextInputPopup extends StatefulWidget {
  final String title;
  final String description;
  final String okText;
  final String cancelText;

  final Function(String input) onSubmit;

  TextInputPopup(
      {this.title = "Input text",
      this.description = "",
      this.okText = "Submit",
      this.cancelText = "Cancel",
      this.onSubmit = _emptyFunction});

  static _emptyFunction(String input) {}

  @override
  State<StatefulWidget> createState() {
    return TextInputPopupState();
  }
}

class TextInputPopupState extends State<TextInputPopup> {
  String value = "";

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: Text(widget.title),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget.description),
          TextField(
            onChanged: (updated) {
              value = updated;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(widget.cancelText),
        ),
        new TextButton(
          onPressed: () {
            widget.onSubmit( value );
            Navigator.of(context).pop();
          },
          child: Text(widget.okText),
        ),
      ],
    );
  }
}
