import 'package:get/get.dart';

import '../../../../core/services/Auth_service.dart';
import '../../../../core/services/network_caller.dart';
import '../../../../core/utils/constants/app_urls.dart';

import '../data/notification_model.dart';


class NotificationController extends GetxController {


  @override
  void onInit() {
    fetchNotificationDetails();
    super.onInit();

  }





  var isLoading = false.obs;
  var getNotificationDetails = NotificationModel().obs;



  // Function to fetch course details
  Future<void> fetchNotificationDetails() async {
    isLoading.value = true;
    try {


      final response = await NetworkCaller().getRequest(AppUrls.getNotification,token: AuthService.token);



      if (response.isSuccess) {
        // Check if responseData is a String or Map
        if (response.responseData is Map<String, dynamic>) {
          getNotificationDetails.value = NotificationModel.fromJson(response.responseData);

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


}



