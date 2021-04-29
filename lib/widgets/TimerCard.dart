import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:oven_app/model/PizzaInfo.dart';
import 'package:oven_app/model/TimerHelper.dart';
import 'package:oven_app/model/constants.dart';
import 'package:oven_app/widgets/popups/PizzaSettingsPopup.dart';

class TimerCard extends StatefulWidget {
  final Logger logger = Logger("TimerCard");

  final Color color;
  final TimerHelper timerHelper = TimerHelper();
  final PizzaInfo pizzaInfo;

  TimerCard({String title = "", this.color = Colors.grey})
      : pizzaInfo = PizzaInfo(title, Icons.local_pizza_rounded);

  @override
  State<StatefulWidget> createState() {
    return TimerCardState();
  }
}

class TimerCardState extends State<TimerCard> {

  @override
  void initState() {
    super.initState();
    widget.logger.fine("Initialising TimerCard named ${widget.pizzaInfo.title}");
    widget.timerHelper.onCount = () {
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => PizzaSettingsPopup(
              title: 'Change info card',
              cancelText: 'Cancel',
              titleInputHint: '(optional) change item name',
              okText: 'Ok',
              description: 'Change the appearance of this item',
              currentIcon: widget.pizzaInfo.icon,
              onSubmit: (newName, newIcon) {
                setState(() {
                  if (newName != '') widget.pizzaInfo.title = newName;
                  widget.pizzaInfo.icon = newIcon;
                });
              },
            ),
          );
        },
        onLongPress: () {},
        splashColor: Constants.accentColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                widget.pizzaInfo.icon,
                size: 50.0,
                color: Constants.accentColor,
              ),
              SizedBox(
                width: 30.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.pizzaInfo.title,
                    style: Constants.textStyle,
                  ),
                  Text(
                    widget.timerHelper.getPrettyTime(),
                    style: Constants.textStyle,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
