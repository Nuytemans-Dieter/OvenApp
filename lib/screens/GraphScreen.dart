import 'package:flutter/material.dart';
import 'package:oven_app/model/constants.dart';
import 'package:oven_app/model/data/CelciusHistory.dart';
import 'package:oven_app/widgets/CelciusGraph.dart';

class GraphScreen extends StatefulWidget {
  final CelciusHistory celciusHistory;

  GraphScreen(this.celciusHistory);

  @override
  State<StatefulWidget> createState() {
    return GraphScreenState();
  }
}

class GraphScreenState extends State<GraphScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              CelciusGraph( widget.celciusHistory ),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Go back',
                    style: TextStyle(
                      fontSize: 20.0
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
