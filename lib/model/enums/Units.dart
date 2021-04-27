enum TemperatureUnit { CELCIUS, FAHRENHEIT, KELVIN }

extension TemperatureSymbolHelper on TemperatureUnit {
  String getSymbol() {
    switch (this) {
      case TemperatureUnit.CELCIUS:
        return "°C";
      case TemperatureUnit.FAHRENHEIT:
        return "F";
      case TemperatureUnit.KELVIN:
        return "K";
      default:
        return "?";
    }
  }
}
