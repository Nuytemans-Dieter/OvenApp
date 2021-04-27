import 'dart:math';

import 'package:oven_app/model/OvenInfo.dart';
import 'package:oven_app/model/Temperature.dart';
import 'package:oven_app/model/interfaces/OvenInfoProvider.dart';

class LinearInfoProvider extends OvenInfoProvider {
  final String _ovenName = "Pizza oven";
  final Random _random = new Random();

  bool isRising = true;
  double temperature = 20;

  @override
  Stream<OvenInfo> getStream() {
    Stream<OvenInfo> stream =
        Stream<OvenInfo>.periodic(Duration(milliseconds: 750), (val) {
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
    });
    return stream;
  }
}
