import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:oven_app/model/constants.dart';

class PizzaSettingsPopup extends StatefulWidget {
  final Logger logger = Logger("PizzaSettingsPopup");

  final String title;
  final String description;
  final String titleInputHint;
  final String okText;
  final String cancelText;

  final IconData currentIcon;

  final Map<IconData, String> icons = {
    Icons.local_pizza_rounded: "Pizza",
    Icons.cake_rounded: "Cake",
    Icons.takeout_dining: "Boiled food",
    Icons.free_breakfast_rounded: "Hot beverage",
    Icons.restaurant_rounded: "Other food",
  };

  final Function(String input, IconData icon) onSubmit;

  PizzaSettingsPopup(
      {this.title = "Input text",
      this.description = "",
      this.titleInputHint = "(optional) change item name",
      this.okText = "Submit",
      this.cancelText = "Cancel",
      this.currentIcon = Icons.local_pizza_rounded,
      this.onSubmit = _emptyFunction});

  static _emptyFunction(String input, IconData icon) {}

  @override
  State<StatefulWidget> createState() {
    return PizzaSettingsPopupState(icons.containsKey( currentIcon ) ? currentIcon : icons.keys.first);
  }
}

class PizzaSettingsPopupState extends State<PizzaSettingsPopup> {
  String newName = "";
  IconData selectedIcon;

  PizzaSettingsPopupState(this.selectedIcon);

  @override
  Widget build(BuildContext context) {
    widget.logger.finest("Rebuilding popup");
    return new AlertDialog(
      title: Text(widget.title),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget.description),
          SizedBox(
            height: 20,
          ),
          TextField(
            onChanged: (updated) {
              newName = updated;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: widget.titleInputHint,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: DropdownButton<IconData>(
              value: selectedIcon,
              items: [
                for (MapEntry<IconData, String> entry in widget.icons.entries)
                  DropdownMenuItem(
                    child: Row(
                      children: [
                        Icon(
                          entry.key,
                          color: Constants.accentColor,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(entry.value),
                      ],
                    ),
                    value: entry.key,
                  ),
              ],
              onChanged: (newIcon) {
                setState(() {
                  widget.logger.info("Selected icon $newIcon");
                  selectedIcon = newIcon ?? selectedIcon;
                });
              },
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
            widget.onSubmit(newName, selectedIcon);
            Navigator.of(context).pop();
          },
          child: Text(widget.okText),
        ),
      ],
    );
  }
}
