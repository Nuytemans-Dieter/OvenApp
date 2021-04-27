import 'package:oven_app/model/enums/Units.dart';

class Temperature {
  double _temperatureCelcius;

  Temperature(this._temperatureCelcius);

  void setCelcius(double temperature) {
    _temperatureCelcius = temperature;
  }

  double getCelcius() {
    return _temperatureCelcius;
  }

  double getTemperature(TemperatureUnit unit) {
    double temperature;

    switch (unit) {
      case TemperatureUnit.CELCIUS:
        temperature = getCelcius();
        break;

      case TemperatureUnit.FAHRENHEIT:
        temperature = (_temperatureCelcius * 1.8) + 32;
        break;

      case TemperatureUnit.KELVIN:
        temperature = _temperatureCelcius + 273.15;
        break;
    }

    return temperature;
  }
}
