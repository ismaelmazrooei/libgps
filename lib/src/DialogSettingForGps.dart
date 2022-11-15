import 'package:flutter/material.dart';
import 'package:flutter_decomgps/src/ApiSetLocation.dart';
import 'package:flutter_decomgps/src/RibonController.dart';
import 'package:flutter_decomgps/src/decom_hateli.dart';
import 'package:location/location.dart';

class DialogSetting extends StatefulWidget {
  const DialogSetting({super.key});

  @override
  State<DialogSetting> createState() => _DialogSettingState();
}

class _DialogSettingState extends State<DialogSetting> {
  late TextEditingController editIntervalNumber;
  @override
  void initState() {
    editIntervalNumber = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    editIntervalNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(
          'تنظیمات جی پی اس ',
          style: TextStyle(
              fontFamily: 'Tahoma', fontSize: 14, color: Colors.black),
        ),
        content: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey),
            child: getListSwitchTile()));
  }

  Location _location = Location();
  ApiSetting apiSetting = ApiSetting();
  Riboncontroller backGrounEnableController = Riboncontroller();
  Riboncontroller hasPermissionController = Riboncontroller();
  getListSwitchTile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DecomHotli<Riboncontroller>(
          value: backGrounEnableController,
          builder: (context, value, child) {
            return SwitchListTile(
              value: apiSetting.getBackGroundMode,
              onChanged: (value) {
                apiSetting.setBackGroundMode = value;
                backGrounEnableController.invalidate();
              },
              title: Text('فعال بودن در  پشت زمینه برنامه'),
            );
          },
        ),
        DecomHotli<Riboncontroller>(
          value: hasPermissionController,
          builder: (context, value, child) {
            return SwitchListTile(
              value: apiSetting.hasPermission,
              onChanged: (value) {
                apiSetting.hasPermission = value;
                final hasPermision = _location.hasPermission();
                if (hasPermision != PermissionStatus.granted) {
                  final permisionRequest = _location.requestPermission();
                }
                hasPermissionController.invalidate();
              },
              title: Text('سترسی به مکان یاب داده شود'),
            );
          },
        ),
        TextField(
          onChanged: (value) {
            apiSetting.setInterval = value as int;
          },
          keyboardType: TextInputType.number,
          controller: editIntervalNumber,
          decoration: InputDecoration(
              prefixIcon: TextButton(
                  onPressed: () {
                    editIntervalNumber.clear();
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black),
                    child: const Icon(
                      Icons.close,
                      color: Colors.amber,
                    ),
                  ))),
        )
      ],
    );
  }
}
