import 'dart:math';

import 'package:oven_app/model/OvenInfo.dart';
import 'package:oven_app/model/Temperature.dart';
import 'package:oven_app/model/interfaces/OvenInfoProvider.dart';

class LinearInfoProvider extends OvenInfoProvider {
  final String _ovenName = "Pizza oven";
  final Random _random = new Random();

  late Stream<OvenInfo> _stream;
  bool isReady = false;

  bool isRising = true;
  double temperature = 20;

  LinearInfoProvider() {
    _stream = Stream<OvenInfo>.periodic(Duration(milliseconds: 450), (val) {
      double delta = _random.nextDouble() * 20;
      double actualTemperature =
          isRising ? temperature + delta : temperature - delta;
      temperature = actualTemperature - actualTemperature % 0.25;

      if (temperature <= 0) {
        isRising = true;
      } else if (temperature >= 700) {
        isRising = false;
      }

      return new OvenInfo(_ovenName, new Temperature(temperature));
    }).asBroadcastStream();
    this.isReady = true;
  }

  @override
  Future<Stream<OvenInfo>> getStream() async {
    return _stream;
  }

  @override
  Future<void> connect() async {}

  @override
  Future<void> disconnect() async {
    await _stream.listen((event) {}).cancel();
    this.isReady = false;
  }

  @override
  bool isConnected() {
    return this.isReady;
  }
}
