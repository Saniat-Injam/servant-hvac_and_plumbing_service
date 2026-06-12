// import 'dart:developer';
//
// import 'package:flutter/material.dart';
//
// import 'package:get/get.dart';
//
//
// import '../../../../core/services/Auth_service.dart';
// import '../../../../core/services/network_caller.dart';
//
// import '../../../../core/utils/constants/app_urls.dart';
//
//
// class ServicePaymentController extends GetxController {
//
//
//
//
//   RxString selectedPaymentMethod = ''.obs;
//   String? serviceId1;
//   String? amount1;
//   String? offerId1;
//
//
//   static bool isLoading1 = false;
//
//   // Future<void> savePaymentMethodStart({
//   //   required String customerId1,
//   //   required double price1,
//   //   required String pmId,
//   //   required String bookingID1,
//   // }) async {
//   //
//   // }
//
//   Future<bool> paymentStart({required String serviceId,required String amount,required String offerId}) async {
//     serviceId1 = serviceId;
//     amount1 = amount;
//     offerId1 = offerId;
//     debugPrint("Subscription ID: $serviceId1");
//     debugPrint("Amount: $amount1");
//
//     return await setupPaymentMethod();
//   }
//
//   Future<bool> setupPaymentMethod() async {
//     try {
//       String? setupIntentClientSecret = await _createSetupIntent();
//
//       if (setupIntentClientSecret == null) {
//         log('Setup Intent creation failed');
//         return false;
//       }
//
//       log('Setup Intent Created: $setupIntentClientSecret');
//
//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           setupIntentClientSecret: setupIntentClientSecret,
//           merchantDisplayName: "Bd Calling IT",
//         ),
//       );
//
//       return await _confirmSetupIntent(setupIntentClientSecret);
//     } catch (e) {
//       log('Setup Failed: $e');
//       return false;
//     }
//   }
//
//   Future<String?> _createSetupIntent() async {
//     try {
//       final Dio dio = Dio();
//       Map<String, dynamic> data = {
//         "payment_method_types[]": "card",
//       };
//
//       final response = await dio.post(
//         "https://api.stripe.com/v1/setup_intents",
//         data: data,
//         options: Options(
//           contentType: Headers.formUrlEncodedContentType,
//           headers: {
//             "Authorization": "Bearer $stripeSecretKey",
//           },
//         ),
//       );
//
//       if (response.data != null) {
//         log('Setup Intent Response: ${response.data}');
//         return response.data["client_secret"];
//       }
//       return null;
//     } catch (e) {
//       log('Error creating SetupIntent: $e');
//       return null;
//     }
//   }
//
//   Future<bool> _confirmSetupIntent(String setupIntentClientSecret) async {
//     try {
//       await Stripe.instance.presentPaymentSheet();
//       log('Setup Successful!');
//       return await _getSetupDetails(setupIntentClientSecret);
//     } catch (e) {
//       log('Setup Confirmation Failed: $e');
//       return false;
//     }
//   }
//
//   Future<bool> _getSetupDetails(String setupIntentClientSecret) async {
//     try {
//       final Dio dio = Dio();
//       final setupIntentId = setupIntentClientSecret.split('_secret')[0];
//
//       log('Setup Intent ID: $setupIntentId');
//
//       final response = await dio.get(
//         "https://api.stripe.com/v1/setup_intents/$setupIntentId",
//         options: Options(
//           headers: {
//             "Authorization": "Bearer $stripeSecretKey",
//             "Content-Type": 'application/x-www-form-urlencoded'
//           },
//         ),
//       );
//
//       if (response.data != null && response.data['payment_method'] != null) {
//         String paymentMethodId = response.data['payment_method'];
//         log('Payment Method ID: $paymentMethodId');
//         return await paymentConfirm(paymentMethodId);
//       }
//
//       return false;
//     } catch (e) {
//       log('Failed to retrieve setup details: $e');
//       return false;
//     }
//   }
//
//   Future<bool> paymentConfirm(String pmId) async {
//     final body = {
//       "paymentMethodId": pmId,
//       "serviceId" : serviceId1,
//       "offerId": offerId1,
//
//       "amount" : double.tryParse(amount1.toString()),
//     };
//
//     log('Payment Confirm Request: $body');
//     isLoading1 = true;
//     showProgressIndicator();
//
//     try {
//       final response = await NetworkCaller().postRequest(
//         AppUrls.confirmPayment,
//         body: body,
//         token: AuthService.token,
//       );
//
//       log('Response Status Code: ${response.statusCode}');
//       log('Response Data: ${response.responseData}');
//
//       if (response.statusCode == 201 || response.statusCode == 200) {
//         isLoading1 = false;
//         hideProgressIndicator();
//         await Future.delayed(Duration(milliseconds: 150));
//         AppSnackBar.showSuccess("Payment Successfully Done");
//         return true;
//       } else {
//         isLoading1 = false;
//         hideProgressIndicator();
//         AppSnackBar.showError("Please try again.");
//         return false;
//       }
//     } catch (e) {
//       isLoading1 = false;
//       hideProgressIndicator();
//       log('An error occurred: $e');
//       AppSnackBar.showError('Payment failed: $e');
//       return false;
//     }
//   }
//
//
//
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     AuthService.init();
//     super.onInit();
//   }
// }
