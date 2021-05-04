import 'package:flutter/material.dart';
import 'package:oven_app/model/constants.dart';
import 'package:oven_app/widgets/HelpCard.dart';
import 'package:oven_app/widgets/Curves.dart';

class HelpScreen extends StatefulWidget {
  HelpScreen() {}

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  _HelpScreenState() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BlackBox',
      theme: ThemeData(
          fontFamily: "roboto",
          scaffoldBackgroundColor: Constants.backgroundColor),
      home: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Constants.backgroundColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Constants.textLight,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Stack(
            fit: StackFit.expand,
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                top: 0.3,
                child: Hero(
                  tag: "oven",
                  child: Image.asset(
                    'graphics/hat.png',
                    width: 115,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              CustomPaint(
                painter: HelpScreenCurve(),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  Text(
                    "How to prepare the perfect pizza!",
                    style: TextStyle(
                        fontSize: 20,
                        color: Constants.textNormal,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  HelpCard(
                    description: "Preheat the oven to XXX degrees",
                    iconPath: "graphics/oven.png",
                  ),
                  HelpCard(
                    description: "Gather ingredients to create the pizza dough",
                    iconPath: "graphics/flour.png",
                  ),
                  HelpCard(
                    description: "Gently create a round dough shape",
                    iconPath: "graphics/dough.png",
                  ),
                  HelpCard(
                    description:
                        "Decorate your pizza with your favorite ingrediënts",
                    iconPath: "graphics/ingredients.png",
                  ),
                  HelpCard(
                    description:
                        "Let your pizza bake in the oven for XX minutes",
                    iconPath: "graphics/pizza-schep.png",
                  ),
                  HelpCard(
                    description: "When done, cut your pizza",
                    iconPath: "graphics/cutter.png",
                  ),
                  HelpCard(
                    description: "Serve and enjoy!",
                    iconPath: "graphics/serve.png",
                  ),
                ],
              )
            ],
          )),
    );
  }
}
