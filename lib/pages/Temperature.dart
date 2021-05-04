import 'package:flutter/material.dart';
import 'package:oven_app/model/OvenInfo.dart';
import 'package:oven_app/model/constants.dart';
import 'package:oven_app/model/interfaces/OvenInfoProvider.dart';
import 'package:oven_app/widgets/Gauge.dart';
import 'package:oven_app/widgets/Curves.dart';

class TemperatureScreen extends StatefulWidget {
  late OvenInfoProvider ovenInfoProvider;

  TemperatureScreen(OvenInfoProvider ovenInfoProvider) {
    this.ovenInfoProvider = ovenInfoProvider;
  }

  @override
  _TemperatureScreenState createState() =>
      _TemperatureScreenState(ovenInfoProvider);
}

class _TemperatureScreenState extends State<TemperatureScreen> {
  OvenInfoProvider ovenInfoProvider;
  GlobalKey<GaugeState> gaugeKey = GlobalKey();
  static const double gaugeWidth = 120;

  _TemperatureScreenState(this.ovenInfoProvider) {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BlackBox',
      theme: ThemeData(
          fontFamily: "roboto",
          scaffoldBackgroundColor: Constants.temperatureCard),
      home: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Constants.temperatureCard,
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
                    'graphics/oven.png',
                    width: 150,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              CustomPaint(
                painter: TemperatureScreenCurve(),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width * 0.9,
                top: 180,
                child: Column(children: [
                  Text(
                    "Temperature",
                    style: TextStyle(
                        fontSize: 22,
                        color: Constants.textNormal,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<Stream<OvenInfo>>(
                    future: ovenInfoProvider.getStream(),
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
                                padding:
                                    const EdgeInsets.only(top: gaugeWidth / 2),
                                child: Text(
                                  ovenInfo.temperature.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
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
                    height: 30,
                  ),
                  Text(
                    "Settings",
                    style: TextStyle(
                        fontSize: 22,
                        color: Constants.textNormal,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Max: ",
                            style: TextStyle(
                                fontSize: 17,
                                color: Constants.textLight,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            "950",
                            style: TextStyle(
                                fontSize: 22,
                                color: Constants.textNormal,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Card(
                        elevation: 0.0,
                        color: Constants.buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                            padding: EdgeInsets.all(1.5),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: null,
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      "-10",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Constants.textNormal,
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 0.2,
                                  height: 25,
                                  color: Constants.textNormal,
                                ),
                                InkWell(
                                  onTap: null,
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      " -1 ",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Constants.textNormal,
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 0.2,
                                  height: 25,
                                  color: Constants.textNormal,
                                ),
                                InkWell(
                                  onTap: null,
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      " +1 ",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Constants.textNormal,
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 0.2,
                                  height: 25,
                                  color: Constants.textNormal,
                                ),
                                InkWell(
                                  onTap: null,
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      "+10",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Constants.textNormal,
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Min: ",
                            style: TextStyle(
                                fontSize: 17,
                                color: Constants.textLight,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            "123",
                            style: TextStyle(
                                fontSize: 22,
                                color: Constants.textNormal,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Card(
                        elevation: 0.0,
                        color: Constants.buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                            padding: EdgeInsets.all(1.5),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: null,
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      "-10",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Constants.textNormal,
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 0.2,
                                  height: 25,
                                  color: Constants.textNormal,
                                ),
                                InkWell(
                                  onTap: null,
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      " -1 ",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Constants.textNormal,
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 0.2,
                                  height: 25,
                                  color: Constants.textNormal,
                                ),
                                InkWell(
                                  onTap: null,
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      " +1 ",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Constants.textNormal,
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 0.2,
                                  height: 25,
                                  color: Constants.textNormal,
                                ),
                                InkWell(
                                  onTap: null,
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      "+10",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Constants.textNormal,
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Graph",
                    style: TextStyle(
                        fontSize: 22,
                        color: Constants.textNormal,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "placeholder for temperature-time graph",
                    style: TextStyle(
                        fontSize: 17,
                        color: Constants.textLight,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                  ),
                ]),
              ),
            ],
          )),
    );
  }
}
