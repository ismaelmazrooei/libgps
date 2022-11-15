import 'package:flutter_decomgps/src/InterfaceDecomGps.dart';
import 'package:location/location.dart';

class DecomLocation implements InterfaceDecomGps {
  int countPoint = 0;
  @override
  getCurentPosition() async {
    final userLocation = await Location.instance.getLocation();
    return userLocation;
  }

  @override
  getOnchangeLocation() async {
    final hasPermision = await Location.instance.hasPermission();
    bool enableService = await Location.instance.serviceEnabled();
    if (hasPermision != PermissionStatus.granted) {
      Location.instance.requestPermission();
    }
    if (!enableService) {
      Location.instance.requestService();
    }
    Location.instance.onLocationChanged.listen((event) {
      countPoint++;
      print(
          '${event.latitude} this is data ${event.longitude}  tedad:${countPoint}');
    }, onDone: () {
      print('پایان اجرای سرویس استریم');
    }, onError: (error) {
      print('برای گرفتن موقعیت  با مشکل مواجه شده ایم');
    });
  }

  @override
  onChangeSettingLocation(
      LocationAccuracy accuracy, int intervl, double distanceFilter) {
    Location.instance.changeSettings(
        accuracy: accuracy, interval: intervl, distanceFilter: distanceFilter);
  }

  @override
  Future<LocationData> getPositionToString() async {
    LocationData locationData = await Location.instance.getLocation();
    return locationData;
  }
}
