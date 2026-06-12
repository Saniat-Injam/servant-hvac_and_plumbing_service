
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/common/widgets/custom_text.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/app_sizes.dart';

import '../../controller/service_controller.dart';


import '../widgets/active_widgets.dart';
import '../widgets/complete_widgets.dart';
import '../widgets/pending_widget.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ServicesController controller = Get.find<ServicesController>();
    return Scaffold(
      backgroundColor: AppColors.textWhite,

      body: Column(
        children: [
          SizedBox(height: getHeight(50),),
          CustomText(text: "Services",fontSize: getWidth(22),fontWeight: FontWeight.w600,),
          SizedBox(height: getHeight(30),),
          Obx(
                () => Padding(
              padding: EdgeInsets.symmetric(horizontal:getWidth(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(controller.tabTitles.length, (index) {
                  final isSelected = controller.selectedTab.value == index;
                  return GestureDetector(
                    onTap: () => controller.selectedTab.value = index,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: getWidth(10)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            controller.tabTitles[index],
                            style: TextStyle(
                              color: isSelected ? AppColors.primary : Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: getWidth(18),
                            ),
                          ),
                          SizedBox(height: getHeight(10),),
                          if (isSelected)
                            Container(

                              height: getHeight(4),
                              width: getWidth(100),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          const SizedBox(height: 8),
          Obx(
            () =>
                controller.selectedTab.value == 0
                    ? PendingWidget(controller: controller)
                    : controller.selectedTab.value == 1
                    ? ActiveWidgets(controller: controller)

                    :  CompleteWidget(controller: controller)

          ),
        ],
      ),
    );
  }
}






