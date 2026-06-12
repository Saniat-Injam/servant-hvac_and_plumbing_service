import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_sizes.dart';
import '../../../../core/common/widgets/show_progress_indicator.dart';
import '../../controller/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationController controller =
        Get.find<NotificationController>();

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text(
          "Notification",
          style: TextStyle(fontSize: getWidth(20), fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),

        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),

      body: Obx(() {
        final notification = controller.getNotificationDetails.value.result;

        if (controller.isLoading.value) {
          return Center(
            child: Column(
              children: [
                SizedBox(height: getHeight(350),),
                ShowProgressIndicator (),
              ],
            ),
          );
        }

        if(notification == null || notification.isEmpty) {
          return Center(
            child: Column(
              children: [
                SizedBox(height: getHeight(350),),
                Text(
                  "No Notifications",
                  style: TextStyle(
                    fontSize: getWidth(16),
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }
        return ListView.separated(
          padding: EdgeInsets.only(
            left: getWidth(16),
            right: getWidth(16),
            top: getHeight(16),
            bottom: getHeight(16),
          ),
          itemCount: notification.length,
          separatorBuilder: (_, __) => SizedBox(height: getWidth(12)),
          itemBuilder: (context, index) {
            final item = notification[index];
            return Container(
              padding: EdgeInsets.only(
                left: getWidth(14),
                right: getWidth(14),
                top: getHeight(14),
                bottom: getHeight(14),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title??"N/A",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: getWidth(15),
                    ),
                  ),
                  SizedBox(height: getHeight(10)),
                  Text(
                    item.body??"",
                    style: TextStyle(
                      fontSize: getWidth(14),
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: getHeight(10)),
                  Text(
                    "Date: ${item.updatedAt?.toLocal().toString().split(' ')[0] ?? "N/A"}",
                    style: TextStyle(
                      fontSize: getWidth(12),
                      color: Colors.grey,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),

      // Bottom Navigation Bar
    );
  }
}
