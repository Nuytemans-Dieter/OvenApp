import '../OvenInfo.dart';

abstract class OvenInfoProvider {
  Future<void> connect();
  Future<void> disconnect();
  bool isConnected();
  Future<Stream<OvenInfo>> getStream();
}
