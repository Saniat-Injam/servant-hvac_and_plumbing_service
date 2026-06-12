import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_urls.dart';

import '../../service/controller/service_controller.dart';

/// Enum for service categories
enum Speciality {
  AC_REPAIR,
  PLUMBING,
  CLEANING,
  ELECTRICIAN,
}

/// Extension to map enum -> display name and API value
extension SpecialityExtension on Speciality {
  String get displayName {
    switch (this) {
      case Speciality.AC_REPAIR:
        return "AC Repair";
      case Speciality.PLUMBING:
        return "Plumbing";
      case Speciality.CLEANING:
        return "Cleaning";
      case Speciality.ELECTRICIAN:
        return "Electrical";
    }
  }

  String get apiValue => name; // e.g., AC_REPAIR, PLUMBING
}

class RequestServiceScreenController extends GetxController {
  final String selectedCategory1;

  RequestServiceScreenController(this.selectedCategory1);

  final ServicesController controller = Get.find<ServicesController>();

  // Controllers for text fields
  TextEditingController serviceNameTEController = TextEditingController();
  TextEditingController servicePriceTEController = TextEditingController();
  TextEditingController phoneNumberTEController = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController locationTEController = TextEditingController();
  TextEditingController serviceDateTEController = TextEditingController();
  TextEditingController serviceDescriptionTEController = TextEditingController();

  var isValid = false.obs;
  var isLoading = false.obs;

  /// Category list (display values for dropdown)
  var categoryList = Speciality.values.map((e) => e.displayName).toList().obs;

  /// Selected category (display name)
  late RxString selectedCategory;

  /// Selected images
  var selectedProfileImage = ''.obs;
  var selectedCoverImage = ''.obs;

  /// Selected location
  var selectedLatitude = 0.0.obs;
  var selectedLongitude = 0.0.obs;

  @override
  void onInit() {
    // ensure selectedCategory is always valid
    if (categoryList.contains(selectedCategory1)) {
      selectedCategory = selectedCategory1.obs;
    } else {
      selectedCategory = categoryList.first.obs;
    }
    super.onInit();
  }

  /// Set selected category from dropdown
  void setSelected(String value) {
    selectedCategory.value = value;
  }

  /// Set latitude and longitude
  void setLatLng(double lat, double lng) {
    selectedLatitude.value = lat;
    selectedLongitude.value = lng;
  }

  /// Clear all fields
  void clearAllFields() {
    serviceNameTEController.clear();
    servicePriceTEController.clear();
    phoneNumberTEController.clear();
    userName.clear();
    locationTEController.clear();
    serviceDateTEController.clear();
    serviceDescriptionTEController.clear();

    selectedCategory.value = categoryList.first;
    selectedProfileImage.value = '';
    selectedCoverImage.value = '';

    selectedLatitude.value = 0.0;
    selectedLongitude.value = 0.0;
  }

  /// Pick profile image
  Future<void> pickProfileImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      selectedProfileImage.value = pickedFile.path;
    }
  }

  /// Pick cover image
  Future<void> pickCoverImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      selectedCoverImage.value = pickedFile.path;
    }
  }

  /// Find enum by display name
  Speciality? get selectedEnum {
    try {
      return Speciality.values.firstWhere(
              (e) => e.displayName == selectedCategory.value);
    } catch (_) {
      return null;
    }
  }

  /// Get API-compatible value of selected category
  String? get selectedCategoryApiValue {
    return selectedEnum?.apiValue;
  }

  /// Pick service date and time in user's local timezone
  Future<void> pickServiceDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final localDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        serviceDateTEController.text =
        localDateTime.toLocal().toString().substring(0, 16);

        debugPrint("Selected Local DateTime: $localDateTime");
      }
    }
  }

  /// Create service request
  Future<void> createServiceRequest({required String token}) async {
    if (selectedCategoryApiValue == null) {
      Get.snackbar(
        'Error',
        'Selected category is invalid',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    Map<String, dynamic> requestBody = {
      "serviceName": serviceNameTEController.text,
      "phonNumber": phoneNumberTEController.text.trim(),
      "location": {
        "address": locationTEController.text,
        "long": selectedLongitude.value,
        "lat": selectedLatitude.value,
      },
      "price": int.tryParse(servicePriceTEController.text) ?? 0,
      "categories": [selectedCategoryApiValue],
      "serviceDate": DateTime.parse(serviceDateTEController.text)
          .toLocal() // ensure it's treated as local
          .toUtc()   // convert to UTC
          .toIso8601String(),
      "desc": serviceDescriptionTEController.text,
    };

    debugPrint("Request Body: $requestBody");

    try {
      await _sendPostRequestWithHeadersAndImages(
        AppUrls.createService,
        requestBody,
        selectedProfileImage.value,
        token,
      );
    } catch (e) {
      log('Error creating request service: $e');
      Get.snackbar(
        'Error',
        'Failed to create request service. Please try again.',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Send POST request with optional image
  Future<void> _sendPostRequestWithHeadersAndImages(
      String url,
      Map<String, dynamic> body,
      String? profileImagePath,
      String? token) async {
    if (token == null || token.isEmpty) {
      Get.snackbar(
        'Error',
        'Token is invalid or expired.',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.headers.addAll({
        'Authorization': "Bearer $token",
      });

      request.fields['bodyData'] = jsonEncode(body);

      if (profileImagePath != null && profileImagePath.isNotEmpty) {
        log('Attaching profile image: $profileImagePath');
        request.files.add(await http.MultipartFile.fromPath(
          'serviceImage',
          profileImagePath,
        ));
      }

      var response = await request.send();
      debugPrint("Response Status Code: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        await controller.fetchPendingDetails();
        clearAllFields();
        Get.snackbar(
          'Success',
          'Service request created successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        var errorResponse = await response.stream.bytesToString();
        log('Response error: $errorResponse');
        Get.snackbar(
          'Error',
          'Failed to create service request.',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      log('Request error: $e');
      Get.snackbar(
        'Error',
        'Failed to create service request. Please try again.',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }
}
