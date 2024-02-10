import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<bool> handleLocationPermission(context) async {
    // bool serviceEnabled;
    LocationPermission permission;

    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //         content: Text(
    //       'Location services are disabled. Please enable the services',
    //       style: TextStyle(fontSize: 14.sp),
    //     )),
    //   );
    //   return false;
    // }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          'Location permissions are denied',
          style: TextStyle(fontSize: 14.sp),
        )));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        'Location permissions are permanently denied, we cannot request permissions.',
        style: TextStyle(fontSize: 14.sp),
      )));
      return false;
    }
    return true;
  }
}
