import 'package:oven_app/model/OvenInfo.dart';
import 'package:oven_app/model/interfaces/OvenInfoProvider.dart';

class WifiInfoProvider extends OvenInfoProvider {

  @override
  Future<void> connect() {
    throw UnimplementedError();
  }

  @override
  Future<void> disconnect() {
    throw UnimplementedError();
  }

  @override
  Future<Stream<OvenInfo>> getStream() {
    throw UnimplementedError();
  }

  @override
  bool isConnected() {
    throw UnimplementedError();
  }

}
