import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:oven_app/model/OvenInfo.dart';
import 'package:oven_app/model/interfaces/OvenInfoProvider.dart';
import 'package:oven_app/pages/Temperature.dart';
import 'package:oven_app/widgets/Curves.dart';
import 'package:oven_app/widgets/Gauge.dart';
import 'package:oven_app/widgets/TimerCard.dart';
import 'package:oven_app/widgets/HelpIcon.dart';

import 'model/constants.dart';
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
          child: Stack(fit: StackFit.expand, children: [
        CustomPaint(
          painter: PizzaListCurve(),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HelpIcon(),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 5, left: 25, right: 25),
                child: Stack(alignment: Alignment.bottomLeft, children: [
                  Card(
                    elevation: 0.0,
                    color: Constants.temperatureCard,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.12,
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.30,
                            right: 25),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Temperature",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Constants.textNormal,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              FutureBuilder<Stream<OvenInfo>>(
                                future: _provider.getStream(),
                                builder: (context, snapshot) =>
                                    StreamBuilder<OvenInfo>(
                                  stream: snapshot.data,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData &&
                                        snapshot.data != null) {
                                      OvenInfo ovenInfo = snapshot.data!;
                                      gaugeKey.currentState?.value =
                                          ovenInfo.temperature.getCelcius();
                                      return Text(
                                        ovenInfo.temperature.toString(),
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Constants.textNormal,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.start,
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              ),
                            ])),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 3, left: 25),
                    child: Hero(
                      tag: "oven",
                      child: Image.asset(
                        'graphics/oven.png',
                        width: 70,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TemperatureScreen(_provider)),
                        );
                      },
                      child: Text(
                        "More",
                        style: TextStyle(
                            fontSize: 15,
                            color: Constants.textLight,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Text("Your pizza's",
                    style: TextStyle(
                        fontSize: 25,
                        color: Constants.textNormal,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center),
              ),
            ),
            Expanded(
              flex: 4,
              child: ListView.separated(
                itemCount: _timerCards.length,
                padding: EdgeInsets.only(top: 1, left: 10, right: 10),
                separatorBuilder: (context, index) => SizedBox(),
                itemBuilder: (context, index) {
                  return Dismissible(
                    direction: DismissDirection.endToStart,
                    key: UniqueKey(),
                    onDismissed: (DismissDirection direction) {
                      setState(() {
                        _timerCards[index].timerHelper.stop();
                        _timerCards.removeAt(index);
                      });
                    },
                    background: Container(
                      color: Colors.transparent,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Image.asset(
                            'graphics/cutter.png',
                            width: 30,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    child: ListTile(
                      title: _timerCards[index],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Stack(
                  alignment: Alignment.bottomCenter,
                  fit: StackFit.expand,
                  children: [
                    CustomPaint(
                      painter: AddPizzaCurve(),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _timerCards.add(TimerCard(
                              title: "Pizza $pizzaIndex",
                            ));
                          });
                          pizzaIndex++;
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                'graphics/pizza-schep.png',
                                width: 50,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                "Add pizza",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Constants.textLight,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ])),
    );
  }
}
