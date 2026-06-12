import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:servant_hvac_and_plumbing_service/core/common/widgets/app_snack_bar.dart';

import '../../../../core/services/Auth_service.dart';
import '../../../../core/services/network_caller.dart';
import '../../../../core/utils/constants/app_urls.dart';
import '../data/complete_service_model.dart';
import '../data/pending_user_service_model.dart';





class ServicesController extends GetxController {
  var selectedTab = 0.obs;



  List<String> tabTitles = ['Pending', 'Active', 'Completed',];

  String formatDateTime(DateTime dateTime) {
    final formatter = DateFormat("MMMM dd, yyyy 'at' h:mm a");
    return formatter.format(dateTime);
  }


  @override
  void onInit() {
    // TODO: implement onInit
    fetchPendingDetails();
    fetchActiveDetails();
    fetchCompleteDetails();
    super.onInit();
  }

  var isLoading = false.obs;
  var pendingDetails = PendingUserServiceModel ().obs;



  // Function to fetch course details
  Future<void> fetchPendingDetails() async {
    isLoading.value = true;
    try {


      final response = await NetworkCaller().getRequest(AppUrls.getStatusWiseUserService(status: "PENDING"),token: AuthService.token);



      if (response.isSuccess) {
        // Check if responseData is a String or Map
        if (response.responseData is Map<String, dynamic>) {
          pendingDetails.value = PendingUserServiceModel.fromJson(response.responseData);
        } else {
          throw Exception('Unexpected response data format');
        }
      }
    } catch (e) {
      // Handle exceptions
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }
  var isLoading1 = false.obs;
  var activeDetails = PendingUserServiceModel ().obs;



  // Function to fetch course details
  Future<void> fetchActiveDetails() async {
    isLoading.value = true;
    try {


      final response = await NetworkCaller().getRequest(AppUrls.getStatusWiseUserService(status: "ACCEPTED"),token: AuthService.token);



      if (response.isSuccess) {
        // Check if responseData is a String or Map
        if (response.responseData is Map<String, dynamic>) {
          activeDetails.value = PendingUserServiceModel.fromJson(response.responseData);
        } else {
          throw Exception('Unexpected response data format');
        }
      }
    } catch (e) {
      // Handle exceptions
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  var isLoading2 = false.obs;
  var completedDetails = CompleteUserServiceModel().obs;



  // Function to fetch course details
  Future<void> fetchCompleteDetails() async {
    isLoading.value = true;
    try {


      final response = await NetworkCaller().getRequest(AppUrls.getStatusWiseUserService(status: "COMPLETED"),token: AuthService.token);



      if (response.isSuccess) {
        // Check if responseData is a String or Map
        if (response.responseData is Map<String, dynamic>) {
          completedDetails.value = CompleteUserServiceModel.fromJson(response.responseData);
        } else {
          throw Exception('Unexpected response data format');
        }
      }
    } catch (e) {
      // Handle exceptions
      AppSnackBar.showError('An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }








}

