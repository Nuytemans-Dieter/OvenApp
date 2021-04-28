import 'dart:convert';
import 'dart:typed_data';

import 'package:logging/logging.dart';
import 'package:oven_app/model/OvenInfo.dart';
import 'package:oven_app/model/Temperature.dart';
import 'package:oven_app/model/interfaces/OvenInfoProvider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothInfoProvider extends OvenInfoProvider {
  // Settings
  String _address;

  // State variables
  BluetoothConnection? _connection;
  late Stream<OvenInfo> _stream;
  bool _isReady = false;
  OvenInfo? newestInfo;

  // Util variables
  final Logger logger = Logger('BluetoothInfoProvider');
  final AsciiCodec ascii = AsciiCodec();

  BluetoothInfoProvider(this._address) {
    _stream = Stream<OvenInfo>.periodic(Duration(milliseconds: 250), (val) {
      return newestInfo ?? OvenInfo("name", Temperature(20.0));
    });
  }

  @override
  Future<void> connect() async {
    logger.info('Starting Bluetooth connection');
    try {
      _connection = await BluetoothConnection.toAddress(_address);
      logger.info('Connected to the device');
      _isReady = true;

      _connection!.input.listen((Uint8List data) {
        logger.info('Data incoming: ${ascii.decode(data)}');
        _connection!.output.add(data); // Sending data
      }).onDone(() {
        logger.info('Disconnected by remote request');
      });
    } catch (exception) {
      logger.warning('Cannot connect, exception occured');
    }
  }

  @override
  Future<void> disconnect() async {
    _isReady = false;
    _connection?.finish();
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
