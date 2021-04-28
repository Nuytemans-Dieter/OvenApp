import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:oven_app/model/OvenInfo.dart';
import 'package:oven_app/model/interfaces/OvenInfoProvider.dart';
import 'package:oven_app/widgets/Gauge.dart';
import 'package:oven_app/widgets/TimerCard.dart';

import 'model/constants.dart';
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
        primarySwatch: Constants.accentColor,
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

  int pizzaIndex = 1;
  final List<TimerCard> _timerCards;

  _MyHomePageState(this._provider) : _timerCards = [] {
    _provider.connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              FutureBuilder<Stream<OvenInfo>>(
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
                            backgroundColor: Constants.backgroundColor,
                            width: gaugeWidth,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: gaugeWidth / 3),
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
              SizedBox(
                height: 25,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: _timerCards.length,
                  padding: const EdgeInsets.all(5.0),
                  separatorBuilder: (context, index) => SizedBox(),
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (DismissDirection direction) {
                        setState(() {
                          _timerCards[index].timerHelper.stop();
                          _timerCards.removeAt(index);
                        });
                      },
                      child: ListTile(
                        title: _timerCards[index],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pizzaIndex++;
          setState(() {
            _timerCards.add(TimerCard(
              title: "Pizza $pizzaIndex",
            ));
          });
        },
        tooltip: 'Add pizza',
        child: Icon(Icons.add),
      ),
    );
  }
}
