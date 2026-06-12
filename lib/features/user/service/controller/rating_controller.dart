
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:servant_hvac_and_plumbing_service/features/user/service/controller/service_controller.dart';


import '../../../../core/common/widgets/app_snack_bar.dart';
import '../../../../core/services/Auth_service.dart';
import '../../../../core/services/network_caller.dart';
import '../../../../core/utils/constants/app_urls.dart';
import '../../../../core/utils/logging/logger.dart';



class RatingController extends GetxController{

  final serviceController = Get.find<ServicesController>();

  RxBool fiveIsClicked = false.obs;
  RxBool fourIsClicked = false.obs;
  RxBool threeIsClicked = false.obs;
  RxBool twoIsClicked = false.obs;
  RxBool oneIsClicked = false.obs;
  RxInt rating = 0.obs;
  final TextEditingController messageTEController = TextEditingController();


  var inProgress = false.obs;

  void createReview({ required String serviceId,}) async {

    if(rating.value == 0){
      AppSnackBar.showError("Please provide rating");
      return;
    }
    if(messageTEController.text.isEmpty){
      AppSnackBar.showError("Please provide review message");
      return;
    }
    EasyLoading.show(status: "Loading...");


    final Map<String, dynamic> requestBody = {

    "rating": rating.value,
    "review": messageTEController.text,
    "serviceId": serviceId

    };
    debugPrint("-------------------------------------------------------------------");
    debugPrint(requestBody.toString());

    try {
      inProgress.value = true;

      final response = await NetworkCaller()
          .postRequest(AppUrls.createRating, body: requestBody,token: AuthService.token);
      final String message = response.responseData['message'];

      if (response.isSuccess) {
        await serviceController.fetchCompleteDetails();
        Get.back();



        EasyLoading.showSuccess(message);


      } else {
        AppSnackBar.showError(message);

      }

    } catch (e) {
      AppLoggerHelper.error('Error: $e');
    } finally {
      EasyLoading.dismiss();
      inProgress.value = false;
    }
  }
}