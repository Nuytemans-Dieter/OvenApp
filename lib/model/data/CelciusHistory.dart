import 'package:fl_chart/fl_chart.dart';
import 'package:oven_app/model/Temperature.dart';
import 'package:oven_app/model/enums/Units.dart';

class CelciusHistory {
  TemperatureUnit unit;
  List<Temperature> _temperatures = [];
  Function(double newTemperature) onAddTemperature;

  CelciusHistory(
      {this.unit = TemperatureUnit.CELCIUS,
      this.onAddTemperature = emptyFunction});

  static void emptyFunction(double newTemperature) {}

  void addTemperature(Temperature temperature) {
    this._temperatures.add(temperature);
    this.onAddTemperature(temperature.getTemperature(unit));
  }

  List<FlSpot> toFlSpotList() {
    List<FlSpot> data = [];
    for (int i = 0; i < _temperatures.length; i++) {
      data.add(FlSpot(i.toDouble(), _temperatures[i].getTemperature(unit)));
    }
    return data;
  }
}
