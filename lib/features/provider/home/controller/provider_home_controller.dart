import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_client_sse/constants/sse_request_type_enum.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:get/get.dart';
import 'package:servant_hvac_and_plumbing_service/core/services/Auth_service.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_urls.dart';

import '../../service/data/pending_service_model.dart';

class ProviderHomeController extends GetxController {
  /// List of pending services from SSE
  RxList<PendingServiceModel> timeBaseEventModelList =
      <PendingServiceModel>[].obs;

  /// Loading state
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getAllEventByTimeBaseEvent();
  }

  void getAllEventByTimeBaseEvent() {
    final String authToken = AuthService.token ?? "";

    try {
      debugPrint("---SUBSCRIBING TO SSE---");
      isLoading.value = true; // Start loading

      SSEClient.subscribeToSSE(
        method: SSERequestType.GET,
        url: AppUrls.technicalPendingJob,
        header: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
      ).listen(
            (event) {
          try {
            if (event.data == null || event.data!.isEmpty) {
              debugPrint("Received empty event data.");
              isLoading.value = false;
              return;
            }

            debugPrint("Received SSE Event: ${event.data}");

            final parsedJson = jsonDecode(event.data!);

            if (parsedJson is List) {
              final services = parsedJson
                  .map((e) =>
                  PendingServiceModel.fromJson(e as Map<String, dynamic>))
                  .toList();

              timeBaseEventModelList.assignAll(services);
            } else {
              debugPrint(
                  "Unexpected JSON format: expected List but got ${parsedJson.runtimeType}");
            }

            isLoading.value = false; // Data loaded
          } catch (e) {
            debugPrint('Error parsing SSE event data: $e');
            isLoading.value = false;
          }
        },
        onError: (error) {
          debugPrint('Error in SSE stream: $error');
          isLoading.value = false;
        },
        onDone: () {
          debugPrint('SSE stream is done.');
          isLoading.value = false;
        },
      );
    } catch (e) {
      debugPrint('Error in subscribing to SSE: $e');
      isLoading.value = false;
    }
  }
}
