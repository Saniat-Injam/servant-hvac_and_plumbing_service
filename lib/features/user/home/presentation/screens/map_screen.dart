import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_sizer.dart';

import '../../../../../core/common/widgets/custom_text.dart';
import '../../../../../core/utils/constants/app_sizes.dart';
import '../../../../splash_screen/controllers/splash_controller.dart';

class MapScreenProfile extends StatefulWidget {
  const MapScreenProfile({super.key});

  @override
  MapScreenProfileState createState() => MapScreenProfileState();
}

class MapScreenProfileState extends State<MapScreenProfile> {

 // final splashController = Get.put(SplashController());
  LatLng? selectedLocation;
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: LatLng(SplashController.latitude.value, SplashController.longitude.value), zoom: 14),
            onMapCreated: (controller) => mapController = controller,
            onTap: (LatLng latLng) {
              setState(() => selectedLocation = latLng);
            },
            markers: selectedLocation != null
                ? {
              Marker(markerId: MarkerId("selected"), position: selectedLocation!)
            }
                : {},
          ),
          Positioned(
            top: getHeight(60),
            child: Padding(
              padding:  EdgeInsets.only(left: getWidth(16),right: getWidth(16)),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child:  Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
                  ),
                  SizedBox(width: 80.w),
                  CustomText(
                    text: "Select Location",
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedLocation != null) {
            Get.back(result: selectedLocation);
          }
        },
        child: Icon(Icons.check,size: 30,weight: 6,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
