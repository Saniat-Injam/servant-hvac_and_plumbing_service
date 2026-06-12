import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:servant_hvac_and_plumbing_service/features/user/profile/controller/user_profile_controller.dart';

import '../../../../core/common/widgets/app_snack_bar.dart';
import '../../../../core/services/Auth_service.dart';
import '../../../../core/utils/constants/app_urls.dart';


class UserEditProfileController extends GetxController{

  final profileController = Get.find<UserProfileController>();
  final fullNameTEController = TextEditingController();
  final addressTEController = TextEditingController();

  var selectedLatitude = 0.0.obs;
  var selectedLongitude = 0.0.obs;

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

  var selectedGender = RxnString(); // Nullable observable

  final Map<String, String> genderList = {
    "MALE": "Male",
    "FEMALE": "Female",
  };

  void setSelected(String value) {
    selectedGender.value = value;
  }

  var isLoading = false.obs;





  Future<void> updateProfile(



      ) async {
    isLoading.value = true;
    EasyLoading.show(status: "Loading...");
    Map<String, dynamic> requestBody = {
      "fullName": fullNameTEController.text,

      "location": {
        "address":addressTEController.text,
        "lat": selectedLatitude.value,
        "long": selectedLongitude.value
      },
      "gender":selectedGender.value,
      "speciality": selectedCategories,

    }
    ;



    try {
      await _sendPutRequestWithHeadersAndImagesOnly(
        AppUrls.updateProfile,
        requestBody,
        AuthService.token
      );
    } catch (e) {
      log('Error updating profile: $e');
      AppSnackBar.showError('Failed to update profile. Please try again.');

    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _sendPutRequestWithHeadersAndImagesOnly(
      String url,
      Map<String, dynamic> body,

      String? token,
      ) async {
    if (token == null || token.isEmpty) {
      AppSnackBar.showError('Token is invalid or expired.');

      return;
    }

    try {
      var request = http.MultipartRequest('PATCH', Uri.parse(url));

      request.headers.addAll({
        'Authorization': "Bearer $token",
      });

      request.fields['bodyData'] = jsonEncode(body);

      // if (imagePath != null && imagePath.isNotEmpty) {
      //   log('Attaching image: $imagePath');
      //   request.files.add(await http.MultipartFile.fromPath(
      //     'profileImage',
      //     imagePath,
      //   ));
      // }
      // if (cvPdfPath != null && cvPdfPath.isNotEmpty) {
      //   log('Attaching image: $cvPdfPath');
      //   request.files.add(await http.MultipartFile.fromPath(
      //     'CVFile',
      //     cvPdfPath,
      //   ));
      // }

      log('Request Headers: ${request.headers}');
      log('Request Fields: ${request.fields}');

      var response = await request.send();
      debugPrint("----------------------------------------------------------");
      var responseData = await http.Response.fromStream(response);
      final String message1 = responseData.body;
      log('Response Data: $message1');

      final decoded = jsonDecode(responseData.body);
      final String message = decoded['message'] ?? 'No message provided';
      log('Message: $message');

      debugPrint(response.statusCode.toString());

      if (response.statusCode == 200 || response.statusCode == 201) {
        EasyLoading.showSuccess(message);
        EasyLoading.dismiss();



        await profileController.fetchProfileDetails();



      } else {
        var errorResponse = await response.stream.bytesToString();
        EasyLoading.dismiss();
        log('Response error: $errorResponse');
        AppSnackBar.showError('Failed to upload profile. Please try again.');

      }
    } catch (e) {
      EasyLoading.dismiss();
      log('Request error: $e');
      AppSnackBar.showError('An error occurred: $e');

    }
  }









}