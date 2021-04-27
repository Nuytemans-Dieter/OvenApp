import 'dart:math';

import 'package:oven_app/model/OvenInfo.dart';
import 'package:oven_app/model/Temperature.dart';
import 'package:oven_app/model/interfaces/OvenInfoProvider.dart';

class RandomInfoProvider extends OvenInfoProvider {
  final String _ovenName = "Pizza oven";
  final Random _random = new Random();

  @override
  Stream<OvenInfo> getStream() {
    Stream<OvenInfo> stream =
        Stream<OvenInfo>.periodic(Duration(milliseconds: 500), (val) {
      double actualTemperature = _random.nextDouble() * 625;
      double rounding = actualTemperature % 0.25;
      double measuredTemperature = actualTemperature - rounding;
      return new OvenInfo(_ovenName, new Temperature(measuredTemperature));
    });
    return stream;
  }
}
