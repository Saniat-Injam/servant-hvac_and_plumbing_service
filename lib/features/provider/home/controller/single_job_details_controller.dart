import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../core/common/widgets/app_snack_bar.dart';
import '../../../../core/services/Auth_service.dart';
import '../../../../core/services/network_caller.dart';
import '../../../../core/utils/constants/app_urls.dart';
import '../../../../core/utils/logging/logger.dart';
import '../../../user/service/controller/service_controller.dart';
import '../data/single_job_details_model.dart';

class SingleJobDetailsController extends GetxController {

  final serviceController = Get.find<ServicesController>();
  var isLoading = false.obs;
  var jobDetails = SingleJobDetails().obs;



  Future<void> fetchProfileDetails({required String jobId}) async {
    isLoading.value = true;
    try {
      final response = await NetworkCaller().getRequest(
        AppUrls.getSingleJobDetails(jobId: jobId),
        token: AuthService.token,
      );

      if (response.isSuccess) {
        if (response.responseData is Map<String, dynamic>) {
          jobDetails.value =SingleJobDetails.fromJson(response.responseData);

          /// Example: API returns speciality as `["AC_REPAIR","CLEANING"]`
         //  final branchList = (profileDetails.value.result?.speciality ?? []).cast<String>();
         // // selectedCategories.value = branchesFromList(branchList);
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



  void changeStatus({required String status,required String jobId}) async {

    EasyLoading.show(status: "Loading...");

    final Map<String, dynamic> requestBody = {
      "jobId":jobId,
      "status":status
    };




    try {
      final response = await NetworkCaller()
          .patchRequest(AppUrls.updateJobStatus, body: requestBody,token: AuthService.token);
      if(response.statusCode == 401){
        EasyLoading.dismiss();
        AppSnackBar.showError("We sent you a new onboarding URL. Please complete your Stripe setup.");
        return;

      }
      final String message = response.responseData['message'];




      if (response.isSuccess) {
        //final String token = response.responseData['result']["token"];
        await serviceController.fetchActiveDetails();
        EasyLoading.showSuccess(message);









      } else {
        AppSnackBar.showError(message);

      }

    } catch (e) {
      AppLoggerHelper.error('Error: $e');
    } finally {
      EasyLoading.dismiss();

    }
  }
}