import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:oven_app/model/OvenInfo.dart';
import 'package:oven_app/model/interfaces/OvenInfoProvider.dart';
import 'package:oven_app/widgets/Gauge.dart';

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
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(title: 'Pizza Oven'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final OvenInfoProvider ovenInfoProvider;

  MyHomePage({Key? key, this.title = ""})
      : ovenInfoProvider =
            LinearInfoProvider() /*BluetoothInfoProvider("00:13:EF:02:1C:E2", bufferLength: 150)*/,
        super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState(ovenInfoProvider);
}

class _MyHomePageState extends State<MyHomePage> {
  OvenInfoProvider _provider;
  GlobalKey<GaugeState> gaugeKey = GlobalKey();

  static const double gaugeWidth = 350;

  _MyHomePageState(this._provider) {
    _provider.connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: FutureBuilder<Stream<OvenInfo>>(
            future: _provider.getStream(),
            builder: (context, snapshot) => StreamBuilder<OvenInfo>(
              stream: snapshot.data,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  OvenInfo ovenInfo = snapshot.data!;
                  gaugeKey.currentState?.value =
                      ovenInfo.temperature.getCelcius();
                  return Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Gauge(
                        key: gaugeKey,
                        defaultValue: ovenInfo.temperature.getCelcius(),
                        width: gaugeWidth,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: gaugeWidth / 4),
                        child: Text(
                          ovenInfo.temperature.toString(),
                          style: TextStyle(
                            fontSize: 35,
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
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
