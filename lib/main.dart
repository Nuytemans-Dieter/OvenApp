import 'package:flutter/material.dart';
import 'package:oven_app/model/OvenInfo.dart';
import 'package:oven_app/model/interfaces/OvenInfoProvider.dart';
import 'package:oven_app/model/oven_info_providers/RandomInfoProvider.dart';

import 'model/oven_info_providers/LinearInfoProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza Oven',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Pizza Oven'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final OvenInfoProvider ovenInfoProvider;

  MyHomePage({Key key, this.title})
      : ovenInfoProvider = new LinearInfoProvider(),
        super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            StreamBuilder<OvenInfo>(
              stream: widget.ovenInfoProvider.getStream(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Text(
                        snapshot.data.temperature.toString(),
                        style: TextStyle(
                          fontSize: 35,
                        ),
                      )
                    : Text("??");
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add pizza',
        child: Icon(Icons.add),
      ),
    );
  }
}
