import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:servant_hvac_and_plumbing_service/core/services/Auth_service.dart';

import '../../../../../core/common/widgets/custom_drop_down_button_1.dart';
import '../../../../../core/common/widgets/custom_elevated_button_widget.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/app_sizes.dart';
import '../../../../../core/utils/constants/image_path.dart';
import '../../../home/presentation/screens/map_screen.dart';
import '../../../home/presentation/widgets/input_label_widget.dart';
import '../../controller/edit_profile_controller.dart';

class UserEditProfileScreen extends StatelessWidget {
  const UserEditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserEditProfileController>();


    final arguments = Get.arguments ?? {};

    // Full name & Address
    controller.fullNameTEController.text = arguments['fullName'] ?? '';
    controller.addressTEController.text = arguments['address'] ?? '';
    // Latitude & Longitude (handle String/double)
    controller.selectedLatitude.value = (arguments['latitude'] is String)
        ? double.tryParse(arguments['latitude']) ?? 0.0
        : (arguments['latitude'] ?? 0.0);

    controller.selectedLongitude.value = (arguments['longitude'] is String)
        ? double.tryParse(arguments['longitude']) ?? 0.0
        : (arguments['longitude'] ?? 0.0);
    // Handle Gender (enum or string)
    final genderArg = arguments['gender'];
    if (genderArg != null) {
      controller.selectedGender.value =
      genderArg is String ? genderArg : genderArg.toString().split('.').last;
    }

    // Handle Speciality (enum or string)
    final List<dynamic>? specialityFromArgs = arguments['speciality'];
    controller.selectedCategories.value = specialityFromArgs != null
        ? specialityFromArgs
        .map((e) => e is String ? e : e.toString().split('.').last)
        .toList()
        : [];

    return Scaffold(
      body: Stack(
        children: [
          // Header background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff7B4620), Color(0xffD26719)],
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
          // Back button & Title
          Positioned(
            top: getHeight(85),
            child: Row(
              children: [
                SizedBox(width: getWidth(18)),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Image.asset(ImagePath.backImage,
                      height: getHeight(50), width: getWidth(50)),
                ),
                SizedBox(width: getWidth(80)),
                Text(
                  "Edit Profile",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: getWidth(22),
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          // Form Container
          Positioned(
            top: getHeight(185),
            left: 0,
            right: 0,
            child: Container(
              height: AppSizes.height,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: getWidth(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: getHeight(10)),
                    buildTextField("Full Name", "Type your name", controller.fullNameTEController),
                    SizedBox(height: getHeight(10)),

                    if(AuthService.userRole == "PROVIDER")
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputLabel(label: "Service Speciality"),
                          SizedBox(height: getHeight(10)),
                          Obx(() {
                            final selectedLabels = controller.selectedCategories
                                .map((key) => controller.categories[key] ?? key)
                                .toList();
                            return Container(
                              decoration: BoxDecoration(
                                color: Color(0xffF9F9FB),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ExpansionTile(
                                title: Text(
                                  selectedLabels.isEmpty
                                      ? "Select your service speciality"
                                      : selectedLabels.join(", "),
                                  style: TextStyle(
                                      color: selectedLabels.isEmpty
                                          ? AppColors.textGrey
                                          : Colors.black,
                                      fontSize: getWidth(15)),
                                ),
                                children: controller.categories.entries.map((entry) {
                                  final key = entry.key;
                                  final label = entry.value;
                                  return Obx(() {
                                    final isSelected =
                                    controller.selectedCategories.contains(key);
                                    return CheckboxListTile(
                                      value: isSelected,
                                      title: Text(label),
                                      onChanged: (_) => controller.toggleCategory(key),
                                    );
                                  });
                                }).toList(),
                              ),
                            );
                          }),
                          SizedBox(height: getHeight(10)),
                        ],
                      ),

                    // Service Speciality


                    // Address Field
                    InputLabel(label: "Address"),
                    SizedBox(height: getHeight(10)),
                    buildAddressField(controller),
                    SizedBox(height: getHeight(10)),

                    // Gender Dropdown
                    InputLabel(label: "Gender"),
                    SizedBox(height: getHeight(10)),
                    Obx(() {
                      // Convert controller key (MALE/FEMALE) to label (Male/Female)
                      final selectedGenderLabel = controller.selectedGender.value != null
                          ? controller.genderList[controller.selectedGender.value!]
                          : null;

                      return CustomContainerDropDownButton1<String>(
                        hintText: "Select Gender",
                        value: selectedGenderLabel, // must match one of the items
                        items: controller.genderList.values.toList(), // labels
                        onChanged: (value) {
                          if (value != null) {
                            // Convert label back to key
                            final selectedKey = controller.genderList.entries
                                .firstWhere((entry) => entry.value == value)
                                .key;
                            controller.setSelected(selectedKey);
                          }
                        },
                      );
                    }),
                    SizedBox(height: getHeight(150)),


                    // Submit Button
                    CustomElevatedButtonWidget(
                      buttonTitle: "Submit",
                      onPressed: controller.updateProfile
                    ),
                    SizedBox(height: getHeight(30)),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputLabel(label: label),
        SizedBox(height: getHeight(10)),
        Container(
          padding: EdgeInsets.symmetric(vertical: getHeight(4), horizontal: getWidth(8)),
          decoration: BoxDecoration(
            color: Color(0xffF9F9FB),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: hint,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: getHeight(10),
                horizontal: getWidth(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildAddressField(UserEditProfileController controller) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: getHeight(4), horizontal: getWidth(8)),
      decoration: BoxDecoration(
        color: Color(0xffF9F9FB),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller.addressTEController,
        decoration: InputDecoration(
          hintText: "Select your location",
          suffixIcon: IconButton(
            icon: Icon(Icons.location_on_outlined),
            onPressed: () async {
              LatLng? selectedLocation = await Get.to(() => MapScreenProfile());
              if (selectedLocation != null) {
                controller.setLatLng(
                    selectedLocation.latitude, selectedLocation.longitude);
                String address = await _getAddressFromLatLng(selectedLocation);
                controller.addressTEController.text = address;
              }
            },
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: getHeight(10),
            horizontal: getWidth(10),
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
        ),
      ),
    );
  }

  Future<String> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        return "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      }
      return "Unknown location";
    } catch (e) {
      return "Failed to get address";
    }
  }
}
