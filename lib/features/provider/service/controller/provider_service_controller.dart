import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/services/Auth_service.dart';
import '../../../../core/services/network_caller.dart';
import '../../../../core/utils/constants/app_urls.dart';
import '../../../user/service/data/complete_service_model.dart';
import '../data/progress_model.dart';





class ProviderServicesController extends GetxController {
  var selectedTab = 0.obs;



  List<String> tabTitles = ['In Progress', 'Complete',];

  String formatDateTime(DateTime dateTime) {
    final formatter = DateFormat("MMMM dd, yyyy 'at' h:mm a");
    return formatter.format(dateTime);
  }


  @override
  void onInit() {
    // TODO: implement onInit
    fetchProgressDetails();
    fetchCompleteDetails();

    super.onInit();
  }

  var isLoading = false.obs;
  var progressServiceDetails = ProgressServiceModel ().obs;



  // Function to fetch course details
  Future<void> fetchProgressDetails() async {
    isLoading.value = true;
    try {


      final response = await NetworkCaller().getRequest(AppUrls.getStatusWiseProviderService(status: "ACCEPTED"),token: AuthService.token);



      if (response.isSuccess) {
        // Check if responseData is a String or Map
        if (response.responseData is Map<String, dynamic>) {
          progressServiceDetails.value = ProgressServiceModel.fromJson(response.responseData);
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
  var completeDetails = CompleteUserServiceModel  ().obs;



  // Function to fetch course details
  Future<void> fetchCompleteDetails() async {
    isLoading1.value = true;
    try {


      final response = await NetworkCaller().getRequest(AppUrls.getStatusWiseProviderService(status: "COMPLETED"),token: AuthService.token);



      if (response.isSuccess) {
        // Check if responseData is a String or Map
        if (response.responseData is Map<String, dynamic>) {
          completeDetails .value = CompleteUserServiceModel .fromJson(response.responseData);
        } else {
          throw Exception('Unexpected response data format');
        }
      }
    } catch (e) {
      // Handle exceptions
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading1.value = false;
    }
  }










}

