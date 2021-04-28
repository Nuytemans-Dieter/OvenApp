import 'package:oven_app/model/Temperature.dart';

class OvenInfo {
  final String name;
  final Temperature temperature;

  OvenInfo(this.name, this.temperature);

  OvenInfo.fromMap(Map<String, dynamic> data)
      : name = data['name'] ?? "No name",
        temperature = Temperature(data['celcius'] ?? 20.0);

  Map<String, dynamic> toJson() => {
        'name': name,
        'celcius': temperature.getCelcius(),
      };
}
