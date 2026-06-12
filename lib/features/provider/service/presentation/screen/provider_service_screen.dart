
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servant_hvac_and_plumbing_service/core/common/widgets/custom_text.dart';

import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/app_sizes.dart';
import '../../controller/provider_service_controller.dart';

import '../widgets/provider_in_progress_widgets.dart';
import '../widgets/provider_complete_widget.dart';

class ProviderServicesScreen extends StatelessWidget {
  const ProviderServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProviderServicesController controller = Get.find<ProviderServicesController>();
    return Scaffold(


      body: Column(
        children: [
          SizedBox(height: getHeight(60),),
          CustomText(text: "Services",fontSize: getWidth(20),fontWeight: FontWeight.w600,),
          SizedBox(height: getHeight(20),),
          Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                  children: List.generate(controller.tabTitles.length, (index) {
                    final isSelected = controller.selectedTab.value == index;
                    return GestureDetector(
                      onTap: () => controller.selectedTab.value = index,
                      child: SizedBox(
                        width: getWidth(180),
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


          Obx(
            () =>
                controller.selectedTab.value == 0
                    ? ProviderInProgressWidgets(controller: controller)

                    : ProviderCompleteWidget(controller: controller)



          ),
        ],
      ),
    );
  }
}






