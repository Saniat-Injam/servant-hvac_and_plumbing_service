import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:servant_hvac_and_plumbing_service/core/services/Auth_service.dart';

import '../../../../core/common/widgets/app_snack_bar.dart';
import '../../../../core/services/network_caller.dart';
import '../../../../core/utils/constants/app_urls.dart';
import '../data/get_my_profile_model.dart';

enum Speciality {
  AC_REPAIR,
  PLUMBING,
  CLEANING,
  ELECTRICIAN
}

class UserProfileController extends GetxController {


  var profileImage = "https://i.pravatar.cc/300".obs;
  var localImage = Rx<File?>(null);

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      localImage.value = File(pickedFile.path);
      updateProfile(imagePath: pickedFile.path);
    }
  }

  Future<void> logout() async {
    await AuthService.logoutUser();
  }

  /// Category display names
  final Map<String, String> categories = {
    "AC_REPAIR": 'AC Repair',
    "PLUMBING": 'Plumbing',
    "CLEANING": 'Cleaning',
    "ELECTRICIAN": 'Electrical',
  };

  /// Parse a string into enum
  Speciality? branchFromString(String? branchStr) {
    if (branchStr == null) return null;
    return Speciality.values.firstWhereOrNull(
          (b) => b.toString().split('.').last.toUpperCase() == branchStr.toUpperCase(),
    );
  }

  /// Parse a list of strings into enum list
  List<Speciality> branchesFromList(List<String>? branchList) {
    if (branchList == null) return [];
    return branchList
        .map((b) => branchFromString(b))
        .whereType<Speciality>()
        .toList();
  }

  var isLoading = false.obs;
  var profileDetails = GetMyProfile().obs;

  /// Store multiple selected categories
  var selectedCategories = <Speciality>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfileDetails();
  }

  Future<void> fetchProfileDetails() async {
    isLoading.value = true;
    try {
      final response = await NetworkCaller().getRequest(
        AppUrls.getMe,
        token: AuthService.token,
      );

      if (response.isSuccess) {
        if (response.responseData is Map<String, dynamic>) {
          profileDetails.value = GetMyProfile.fromJson(response.responseData);

          /// Example: API returns speciality as `["AC_REPAIR","CLEANING"]`
          final branchList = (profileDetails.value.result?.speciality ?? []).cast<String>();
          selectedCategories.value = branchesFromList(branchList);
        } else {
          throw Exception('Unexpected response data format');
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Toggle selection
  void toggleCategory(Speciality category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  /// Convert back to string list (for API request)
  List<String> get selectedCategoryStrings =>
      selectedCategories.map((c) => c.toString().split('.').last).toList();



  Future<void> updateProfile({
    required String imagePath
}



      ) async {
    isLoading.value = true;
    EasyLoading.show(status: "Loading...");
    Map<String, dynamic> requestBody = {


    }
    ;



    try {
      await _sendPutRequestWithHeadersAndImagesOnly(
          AppUrls.updateProfile,
          requestBody,
          imagePath,
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
      imagePath,

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

      if (imagePath != null && imagePath.isNotEmpty) {
        log('Attaching image: $imagePath');
        request.files.add(await http.MultipartFile.fromPath(
          'profileImage',
          imagePath,
        ));
      }


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



        await fetchProfileDetails();



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
