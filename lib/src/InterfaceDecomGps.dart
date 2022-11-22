import 'package:location/location.dart';

abstract class InterfaceDecomGps {
  getCurentPosition();
  getOnchangeLocation();
  onChangeSettingLocation(
      LocationAccuracy accuracy, int intervl, double distanceFilter);
  Future<LocationData> getPositionToString();
  isdBackgroundMdoe();
}
