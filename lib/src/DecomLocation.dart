import 'package:flutter/material.dart';
import 'package:flutter_decomgps/src/InterfaceDecomGps.dart';
import 'package:location/location.dart';

class DecomLocation implements InterfaceDecomGps {
  int countPoint = 0;
  @override
  getCurentPosition() async {
    if (PermissionStatus.granted != await Location.instance.hasPermission()) {}
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

  //این متد وظیفه فعال کردن سروریس جی پی اس را در بک گراند بر عهده دارد
  @override
  isdBackgroundMdoe() async {
    if (await Location.instance.isBackgroundModeEnabled()) {
      return true;
    } else {
      return Location.instance.enableBackgroundMode(enable: true);
    }
  }
}

class MyDialog extends StatelessWidget {
  const MyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(35),
          color: Colors.grey.shade300),
      child: const AlertDialog(
        title: Text(
          'لطفا در خواست دسترسی را مورد تائید  قرار دهید',
          style: TextStyle(
              fontFamily: 'tahoma', fontSize: 12, color: Colors.black),
        ),
        content: Text(
          'لطفا دسترسی های لازم را به سیستم بدهید',
          style: TextStyle(
              fontFamily: 'tahoma', fontSize: 12, color: Colors.black),
        ),
        actions: [
          TextButton(
              onPressed: null,
              child: Text(
                'متوجه شدم',
                style: TextStyle(
                    fontFamily: 'tahoma', fontSize: 12, color: Colors.black),
              ))
        ],
      ),
    );
  }
}
