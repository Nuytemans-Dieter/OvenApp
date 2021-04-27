import 'package:oven_app/model/Temperature.dart';
import 'package:oven_app/model/enums/Units.dart';

class OvenInfo {
  final String name;
  final Temperature temperature;

  OvenInfo(this.name, this.temperature);
}
