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
    widget.logger
        .fine("Initialising TimerCard named ${widget.pizzaInfo.title}");
    widget.timerHelper.onCount = () {
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Constants.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
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
        splashColor: Constants.temperatureCard,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Padding(
                  padding: EdgeInsets.all(7.5),
                  child: Image.asset(
                  'graphics/pizza.png',
                  width: 40,
                  fit: BoxFit.contain,
                ),),
              SizedBox(
                width: 30.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.pizzaInfo.title,
                    style: TextStyle(
                        fontSize: 15,
                        color: Constants.textNormal,
                        fontWeight: FontWeight.w500),
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
