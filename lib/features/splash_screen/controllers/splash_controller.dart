import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:servant_hvac_and_plumbing_service/routes/app_routes.dart';

import '../../../core/services/Auth_service.dart';
import 'location_service.dart';

class SplashController extends GetxController {
  Future<void> navigateToHomeScreen() async {


    if (await AuthService.hasSeenOnboarding()) {
      if (await AuthService.hasToken()) {
        final userRole = AuthService.userRole;
        if(userRole == "PROVIDER"){
          Get.toNamed(AppRoute.providerNavBarScreen);

        }else{
          Get.toNamed(AppRoute.userNavBarScreen);

        }
      } else {
        // Onboarding seen but no token — go to common screen (login/register)
        Get.offAllNamed(AppRoute.loginScreen);
      }
    } else {
      // Onboarding not seen — show onboarding first
      Get.offAllNamed(
        AppRoute.onBoardingScreen,

      );
    }

  }



  @override
  void onInit() {
    super.onInit();


    if (Platform.isIOS) {
      fetchLocationForIOS();
    } else if (Platform.isAndroid) {
      fetchLocationForAndroid();
    }

  }

  static var latitude = 0.0.obs;
  static var  longitude = 0.0.obs;
  static var address = ''.obs;

  final LocationService _locationService = LocationService();



  Future<void> fetchLocationForIOS() async {
    await _fetchLocation();
  }

  Future<void> fetchLocationForAndroid() async {
    await _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('Location services are disabled.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint('Location permissions are denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint('Location permissions are permanently denied.');
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      latitude.value = position.latitude;
      longitude.value = position.longitude;

      debugPrint('Latitude: ${latitude.value}');
      debugPrint('Longitude: ${longitude.value}');

      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;

        String fullAddress = [
          //placemark.name,

          placemark.administrativeArea,

          placemark.country,
        ]
            .where((element) => element != null && element.isNotEmpty)
            .join(', ');

        address.value = fullAddress; // ✅ Assigning full address to observable
        _locationService.setLocation(
            latitude.value, longitude.value, fullAddress);

        navigateToHomeScreen();
        debugPrint('Address: $fullAddress');
      } else {
        debugPrint('No placemarks found for the location.');
      }
    } catch (e) {
      debugPrint('Error fetching location: $e');
    }
  }
}
