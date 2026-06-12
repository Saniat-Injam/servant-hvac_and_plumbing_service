import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:servant_hvac_and_plumbing_service/core/common/widgets/custom_elevated_button_widget.dart';
import 'package:servant_hvac_and_plumbing_service/core/services/Auth_service.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/image_path.dart';

import '../../../../../core/common/widgets/custom_container_drop_down_button.dart';
import '../../../../../core/common/widgets/custom_text.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/app_sizes.dart';

import '../../controller/request_service_controller.dart';

import '../widgets/input_label_widget.dart';
import 'map_screen.dart';

class RequestServiceScreen extends StatelessWidget {
   RequestServiceScreen({super.key});

  final String category = Get.arguments ?? "";

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RequestServiceScreenController>();
    final formKey = GlobalKey<FormState>();

    // if (controller.selectedGender.value.isEmpty) {
    //   controller.selectedGender.value =
    //       myProfileController.profileDetails.value.data?.gender ?? '';
    // }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              SizedBox(height: getHeight(20)),
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back_ios_new_outlined, size: 20),
                    ),

                    SizedBox(width: getWidth(75)),
                    CustomText(
                      text: "Service Request",
                      fontSize: getWidth(20),
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              SizedBox(height: getHeight(20)),
              InputLabel(label: 'Service Name'),
              SizedBox(height: getHeight(8)),
              buildCustomTextFormWidget(
                hintText: "Write service name...",
                controller: controller.serviceNameTEController,
              ),

              InputLabel(label: 'Your Mobile Number'),
              SizedBox(height: getHeight(8)),
              buildCustomTextFormWidget(
                hintText: "Write mobile number...",
                controller: controller.phoneNumberTEController,
                keyboardType: TextInputType.number,
              ),

              InputLabel(label: 'Service Location'),
              SizedBox(height: getHeight(8)),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: getWidth(1),
                    color: AppColors.textFormFieldBorder,
                  ),
                ),
                child: TextField(
                  
                  
                  controller: controller.locationTEController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Select a location",
                    hintStyle: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: getWidth(14),
                      fontWeight: FontWeight.w400,
                    ),
                    suffixIcon: IconButton(onPressed: () async {
                      LatLng? selectedLocation = await Get.to(() => MapScreenProfile());
                      if (selectedLocation != null) {
                        // Store lat/lng in controller
                        controller.setLatLng(selectedLocation.latitude, selectedLocation.longitude);

                        // Convert to address
                        String address = await _getAddressFromLatLng(selectedLocation);
                        controller.locationTEController .text = address;
                      }


                    }, icon: Icon(Icons.location_on_outlined)),

                    contentPadding: EdgeInsets.symmetric(
                      horizontal: getWidth(20),
                      vertical: getHeight(14),
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
           

              InputLabel(label: 'Service Price'),
              SizedBox(height: getHeight(8)),
              buildCustomTextFormWidget(
                hintText: "Write service prices...",
                controller: controller.servicePriceTEController,
                keyboardType: TextInputType.number,
              ),

              InputLabel(label: 'Service Categories'),
              SizedBox(height: getHeight(10)),
              Obx(
                () => CustomContainerDropDownButton(
                  hintText: "Select service categories...",
                  value:
                      controller.selectedCategory.value.isNotEmpty
                          ? controller.selectedCategory.value
                          : null,
                  items: controller.categoryList,
                  onChanged: (value) {
                    controller.setSelected(value!);
                  },
                ),
              ),

              InputLabel(label: 'Service Date'),
              SizedBox(height: getHeight(8)),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: getWidth(1),
                    color: AppColors.textFormFieldBorder,
                  ),
                ),
                child: TextFormField(
                  controller: controller.serviceDateTEController,
                  readOnly: true, // User cannot type manually
                  decoration: InputDecoration(
                    hintText: "Select Service Date",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );

                        if (pickedDate != null) {
                          // Format the date as yyyy-MM-dd
                          String formattedDate =
                          DateFormat("yyyy-MM-dd").format(pickedDate);

                          controller.serviceDateTEController.text = formattedDate; // Set the text field
                        }
                      },
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: getWidth(20),
                      vertical: getHeight(14),
                    ),
                  ),
                ),
              ),

              InputLabel(label: 'Service Description'),
              SizedBox(height: getHeight(8)),
              buildCustomTextFormWidget(
                hintText: "Write service description...",
                controller: controller.serviceDescriptionTEController,
                maxLines: 3,
              ),
              InputLabel(label: 'Upload Image'),

              SizedBox(height: getHeight(12)),
              GestureDetector(
                onTap: () => _showImagePickerDialog(context, controller),
                child: Obx(() => buildCustomUploadImage(controller)),
              ),
              SizedBox(height: getHeight(24)),

              Obx(
                () =>
                    controller.isLoading.value
                        ? SpinKitWave(color: AppColors.primary, size: 30.0)
                        : CustomElevatedButtonWidget(
                          buttonTitle: "Send Request",
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              controller.createServiceRequest(token: AuthService.token!);
                            }
                          },
                        ),
              ),

              SizedBox(height: getHeight(20)),
            ],
          ),
        ),
      ),
    );
  }
   Future<String> _getAddressFromLatLng(LatLng position) async {
     try {
       List<Placemark> placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);
       if (placeMarks.isNotEmpty) {
         Placemark place = placeMarks.first;
         return "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
       }
       return "Unknown location";
     } catch (e) {
       return "Failed to get address";
     }
   }

  Widget buildCustomUploadImage(RequestServiceScreenController controller) {
    return Container(
      width: double.infinity,
      height: getHeight(150),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: getWidth(1), color: Color(0xffA2EADE)),
      ),
      child:
          controller.selectedProfileImage.isNotEmpty
              ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(controller.selectedProfileImage.value),
                  width: double.infinity,
                  height: getHeight(120),
                  fit: BoxFit.fill,
                ),
              )
              //     : myProfileController.profileDetails.value.data?.profileImage != null
              //     ? ClipRRect(
              //   borderRadius: BorderRadius.circular(12),
              //   child: Image.network(
              //     myProfileController.profileDetails.value.data!.profileImage!,
              //     width: double.infinity,
              //     height: 150,
              //     fit: BoxFit.fill,
              //   ),
              // )
              : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        "Upload",
                        style: TextStyle(color: Colors.teal, fontSize: 14),
                      ),
                      SizedBox(width: getWidth(10)),
                      Image.asset(
                        ImagePath.uploadImage,
                        height: getHeight(20),
                        width: getWidth(20),
                      ),
                    ],
                  ),
                ],
              ),
    );
  }

  Widget buildCustomTextFormWidget({
    required TextEditingController? controller,
    required String hintText,
    TextInputType? keyboardType,
    int? maxLines,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: getWidth(1),
          color: AppColors.textFormFieldBorder,
        ),
      ),
      child: TextField(
        maxLines: maxLines ?? 1,
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColors.textGrey,
            fontSize: getWidth(14),
            fontWeight: FontWeight.w400,
          ),

          contentPadding: EdgeInsets.symmetric(
            horizontal: getWidth(20),
            vertical: getHeight(14),
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}

Future<void> _showImagePickerDialog(BuildContext context, controller) async {
  final ImageSource? source = await Get.dialog<ImageSource>(
    Center(
      child: Material(
        color: Colors.transparent,
        child: AnimatedScale(
          scale: 1,
          duration: const Duration(milliseconds: 300),
          child: Container(
            width: Get.width * 0.85,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withValues(alpha: 0.2),
                  blurRadius: 12,
                  spreadRadius: 3,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Circular icon with gradient
                Container(
                  padding: EdgeInsets.only(
                    left: getWidth(16),
                    right: getWidth(16),
                    top: getHeight(16),
                    bottom: getHeight(16),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: const Icon(
                    Icons.image_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                ),

                SizedBox(height: getHeight(16)),
                Text(
                  "Select Image Source",
                  style: TextStyle(
                    fontSize: getWidth(20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: getHeight(10)),
                Text(
                  "Pick an image from your gallery or take a new one",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textGrey,
                    fontSize: getWidth(14),
                  ),
                ),
                SizedBox(height: getHeight(20)),

                // Camera Button with gradient
                GestureDetector(
                  onTap: () => Get.back(result: ImageSource.camera),
                  child: Container(
                    height: getHeight(50),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt_outlined, color: Colors.white),
                        SizedBox(width: getWidth(10)),
                        Text(
                          "Camera",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: getWidth(16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: getHeight(12)),

                // Gallery Button with outline
                GestureDetector(
                  onTap: () => Get.back(result: ImageSource.gallery),
                  child: Container(
                    height: getHeight(50),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.teal, width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.photo_library_outlined, color: Colors.teal),
                        SizedBox(width: getWidth(8)),
                        Text(
                          "Gallery",
                          style: TextStyle(fontSize: getWidth(16)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    barrierColor: Colors.black54, // Dimmed background
  );

  if (source != null) {
    controller.pickProfileImage(source);
  }
}
