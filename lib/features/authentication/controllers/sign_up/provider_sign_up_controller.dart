import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../../core/common/widgets/app_snack_bar.dart';
import '../../../../core/utils/constants/app_urls.dart';
import '../../../../core/utils/logging/logger.dart';
import '../../../../routes/app_routes.dart';




class ProviderSignUpController extends GetxController {

  final nameTEController = TextEditingController();
  final shortDescriptionTEController = TextEditingController();
  final locationTEController = TextEditingController();
  final emailTEController = TextEditingController();
  final confirmPasswordTEController = TextEditingController();
  final passwordTECController = TextEditingController();

  var obscurePassword = true.obs;
  void togglePasswordVisibility() => obscurePassword.value = !obscurePassword.value;

  var obscureConfirmPassword = true.obs;
  void toggleConfirmPasswordVisibility() => obscureConfirmPassword.value = !obscureConfirmPassword.value;



  var selectedLatitude = 0.0.obs;
  var selectedLongitude = 0.0.obs;

  //var selectedCategories = <Speciality>[].obs;



  void setLatLng(double lat, double lng) {
    selectedLatitude.value = lat;
    selectedLongitude.value = lng;
  }

  final Map<String, String> categories = {
    "AC_REPAIR": 'AC Repair',
    "PLUMBING": 'Plumbing',
    "CLEANING": 'Cleaning',
    "ELECTRICIAN": 'Electrical',
  };

  var selectedCategories = <String>[].obs;

  void toggleCategory(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }
  var licenseImage = Rx<File?>(null);
  var imagePath = ''.obs;
  var idImagePath = ''.obs;
  var idImage = Rx<File?>(null);

  final picker = ImagePicker();

  Future<void> pickImage(bool isLicense) async {
    final pickedFile = await picker.pickImage(
      source: await _selectImageSource(),
      imageQuality: 70,
    );
    if (pickedFile != null) {
      if (isLicense) {
        licenseImage.value = File(pickedFile.path);
        imagePath.value = pickedFile.path;
      } else {
        idImage.value = File(pickedFile.path);
        idImagePath.value = pickedFile.path;
      }
    }
  }

  Future<ImageSource> _selectImageSource() async {
    return await Get.dialog<ImageSource>(
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
                    color: Colors.brown.withValues(alpha: 0.2),
                    blurRadius: 12,
                    spreadRadius: 3,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Circular icon
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.brown.shade400, Colors.brown.shade600],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Icon(
                      Icons.image_outlined,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),

                  const SizedBox(height: 16),
                  const Text(
                    "Select Image Source",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Pick an image from your gallery or take a new one",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 20),

                  // Camera Button with gradient
                  GestureDetector(
                    onTap: () => Get.back(result: ImageSource.camera),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.brown.shade400, Colors.brown.shade700],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            "Camera",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Gallery Button with outline
                  GestureDetector(
                    onTap: () => Get.back(result: ImageSource.gallery),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.brown, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.photo_library_outlined, color: Colors.brown),
                          SizedBox(width: 8),
                          Text(
                            "Gallery",
                            style: TextStyle(color: Colors.brown, fontSize: 16),
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
      barrierColor: Colors.black54, // Slightly dark background
    ) ?? ImageSource.gallery;
  }


  Future<void> createProviderAccount() async {


    if (passwordTECController.text != confirmPasswordTEController.text) {
      AppSnackBar.showError('Passwords do not match');
      return;
    }
    if (selectedCategories.isEmpty) {
      AppSnackBar.showError('Please select at least one category');
      return;
    }
    if (imagePath.value.isEmpty) {
      AppSnackBar.showError('Please upload your license image');
      return;
    }
    if (idImagePath.value.isEmpty) {
      AppSnackBar.showError('Please upload your ID image');
      return;
    }
    if(!GetUtils.isEmail(emailTEController.text.trim())) {
      AppSnackBar.showError('Please enter a valid email address');
      return;
    }
    if(passwordTECController.text.length < 6) {
      AppSnackBar.showError('Password must be at least 6 characters long');
      return;
    }
    if(locationTEController.text.isEmpty) {
      AppSnackBar.showError('Please enter your location');
      return;
    }
    if(shortDescriptionTEController.text.isEmpty) {
      AppSnackBar.showError('Please enter a short description');
      return;
    }
    EasyLoading.show(status: "Loading...");

    // Convert enum selections to string for API


    Map<String, dynamic> requestBody = {
      "fullName": nameTEController.text,
      "email": emailTEController.text.trim(),
      "password": passwordTECController.text,
      "role": "PROVIDER",
      "location": {
        "long": selectedLongitude.value,
        "lat": selectedLatitude.value,
        "address":locationTEController.text
      },"speciality":selectedCategories
    };

    try {
      await _sendPutRequestWithHeadersAndImagesOnly(
        AppUrls.createAccount,
        requestBody,

      );
    } catch (e) {
      EasyLoading.dismiss();
      log('Error updating profile: $e');
      AppSnackBar.showError('Failed to update profile. Please try again.');
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> _sendPutRequestWithHeadersAndImagesOnly(
      String url,
      Map<String, dynamic> body,


      ) async {


    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));



      request.fields['bodyData'] = jsonEncode(body);

      if (imagePath.value.isNotEmpty) {
        log('Attaching image: ${imagePath.value}');
        request.files.add(await http.MultipartFile.fromPath(
          'license',
          imagePath.value,
        ));
      }
      if (idImagePath.value.isNotEmpty) {

        // hello
        log('Attaching image: ${idImagePath.value}');
        request.files.add(await http.MultipartFile.fromPath(
          'nid',
          idImagePath.value,
        ));
      }

      log('Request Headers: ${request.headers}');
      log('Request Fields: ${request.fields}');

      var response = await request.send();

      log("Response status: ${response.statusCode}");
      if(response.statusCode == 409){
        EasyLoading.dismiss();
        AppSnackBar.showError("User Already exists");
        return;

      }
      final resBody = await response.stream.bytesToString();
      final json = jsonDecode(resBody);
      final message = json["message"];

      debugPrint("-------------------------------${response.statusCode}------------------------------------");

      debugPrint("-------------------$message-----------------------------");
      AppLoggerHelper.error('Error: $message');

      if (response.statusCode == 200 || response.statusCode == 201) {


        final data = json["result"];
        final String token = data ["token"];

        Get.toNamed(AppRoute.forgotOTPScreen, arguments: {
          "isSignUp": true,
          "email": emailTEController.text,
          "token":token

        });

        EasyLoading.showSuccess(message);

      } else {
        EasyLoading.showError(message);
        final errorResponse = await response.stream.bytesToString();
        log('Error Response: $errorResponse');
        //AppSnackBar.showError('Failed to upload profile. Please try again.');
      }
    } catch (e) {
      EasyLoading.dismiss();
      log('Request error: $e');
      AppSnackBar.showError('An error occurred: $e');
    }
  }


}