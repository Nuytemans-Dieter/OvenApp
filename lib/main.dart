import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:oven_app/model/OvenInfo.dart';
import 'package:oven_app/model/interfaces/OvenInfoProvider.dart';
import 'package:oven_app/widgets/TemperatureGauge.dart';

import 'model/oven_info_providers/BluetoothInfoProvider.dart';
import 'model/oven_info_providers/LinearInfoProvider.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.loggerName}: ${record.message}');
  });
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

  MyHomePage({Key? key, this.title = ""})
      : ovenInfoProvider = Foundation
                .kReleaseMode // Always use Bluetooth in release mode, if statement will be removed by compiler (kReleaseMode is a constant)
            ? BluetoothInfoProvider()
            : LinearInfoProvider(),
        //: LinearInfoProvider(),
        super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState(ovenInfoProvider);
}

class _MyHomePageState extends State<MyHomePage> {
  OvenInfoProvider _provider;

  _MyHomePageState(this._provider) {
    _provider.connect();
  }

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
            Gauge(),
            FutureBuilder<Stream<OvenInfo>>(
              future: _provider.getStream(),
              builder: (context, snapshot) => StreamBuilder<OvenInfo>(
                stream: snapshot.data,
                builder: (context, snapshot) {
                  return snapshot.hasData && snapshot.data != null
                      ? Text(
                          snapshot.data!.temperature.toString(),
                          style: TextStyle(
                            fontSize: 35,
                          ),
                        )
                      : Text("??");
                },
              ),
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
