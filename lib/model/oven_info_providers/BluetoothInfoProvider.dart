import 'package:flutter_blue/flutter_blue.dart';
import 'package:logging/logging.dart';
import 'package:oven_app/model/OvenInfo.dart';
import 'package:oven_app/model/Temperature.dart';
import 'package:oven_app/model/interfaces/OvenInfoProvider.dart';

class BluetoothInfoProvider extends OvenInfoProvider {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  final Logger log = Logger('BluetoothInfoProvider');

  bool _isReady = false;
  late Stream<OvenInfo> _stream;
  BluetoothDevice? _device;

  OvenInfo? newestInfo;

  BluetoothInfoProvider() {
    _stream = Stream<OvenInfo>.periodic(Duration(milliseconds: 250), (val) {
      return newestInfo ?? OvenInfo("name", Temperature(20.0));
    });
  }

  @override
  Future<void> connect() async {
    // Start scanning
    flutterBlue.startScan(timeout: Duration(seconds: 4));

    // Listen to scan results
    flutterBlue.scanResults.listen((results) async {
      int numResults = results.length;
      log.info("Found $numResults bluetooth devices");

      for (ScanResult result in results) {
        String name = result.device.name;
        String id = result.device.id.id;

        log.info("  Device: $name with ID $id");
      }

      if (results.isNotEmpty) {
        var device = results.last.device;
        _device = device;
        String id = device.id.id;
        log.info("Attempting to connect to $id");
        try {
          await device.connect(timeout: Duration(seconds: 10));
          log.info("Connected to $id");
          _isReady = true;
        } catch (e) {
          String exception = e.toString();
          log.warning("Connecting to $id failed: $exception");
        }
      }
    });

//    List<BluetoothService> services = await _device!.discoverServices();
//    services.forEach((service) {
    // do something with service
//    });
  }

  @override
  Future<void> disconnect() async {
    _isReady = false;
  }

  @override
  bool isConnected() {
    return _isReady;
  }

  @override
  Future<Stream<OvenInfo>> getStream() async {
    return _stream;
  }
}
