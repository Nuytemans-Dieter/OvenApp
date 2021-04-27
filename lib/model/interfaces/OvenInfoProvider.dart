import '../OvenInfo.dart';

abstract class OvenInfoProvider {
  Stream<OvenInfo> getStream();
}
