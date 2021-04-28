import 'dart:convert';
import 'dart:math';
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
  final int bufferLength;

  // State variables
  BluetoothConnection? _connection;
  late Stream<OvenInfo> _stream;
  bool _isReady = false;
  OvenInfo? _newestInfo;

  // Util variables
  final Logger logger = Logger('BluetoothInfoProvider');
  final AsciiCodec ascii = AsciiCodec();

  BluetoothInfoProvider(this._address, {this.bufferLength = 500}) {
    _stream = Stream<OvenInfo>.periodic(Duration(milliseconds: 250), (val) {
      return _newestInfo ?? OvenInfo("name", Temperature(20.0));
    });
  }

  @override
  Future<void> connect() async {
    logger.info('Starting Bluetooth connection');
    try {
      String buffer = "";
      _connection = await BluetoothConnection.toAddress(_address);
      logger.info('Connected to the device');
      _isReady = true;

      _connection!.input.listen((Uint8List bytes) {
        String data = ascii.decode(bytes);
        logger.finer("Received ${bytes.length} bytes, containing $data");

        buffer += data;
        if (data.endsWith("\n")) {
          logger.fine("Received full message: $buffer");
          Map<String, dynamic> data = jsonDecode(buffer);
          this._newestInfo = OvenInfo.fromMap(data);
          buffer = "";
        } else if (buffer.length > this.bufferLength) {
          logger.warning(
              "Max buffer size exceeded with size ${buffer.length}, max size is ${this.bufferLength}");
          buffer = "";
        }
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
