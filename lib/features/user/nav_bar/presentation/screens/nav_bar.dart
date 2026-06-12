import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_sizes.dart';

import '../../../../../core/utils/constants/app_colors.dart';
import '../../controllers/nav_bar_controller.dart';

class UserNavBar extends StatelessWidget {
  const UserNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<UserNavBarController>(
        builder: (creatorNavController) =>
        creatorNavController.screens[creatorNavController.currentIndex],
      ),
      bottomNavigationBar: GetX<UserNavBarController>(
        builder: (navController) {
          return SizedBox(
            height: getHeight(120),
            child: BottomNavigationBar(
              backgroundColor: AppColors.textWhite,
              currentIndex: navController.currentIndex,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: const Color(0xff263238),
              showUnselectedLabels: true,
              onTap: navController.changeIndex,
              items: List.generate(
                navController.activeIcons.length,
                    (index) {
                  return BottomNavigationBarItem(
                    backgroundColor: Colors.white,
                    icon: navController.currentIndex == index
                        ? navController.activeIcons[index]
                        : navController.inActiveIcons[index],
                    label: navController.labels[index],
                    tooltip: navController.labels[index],
                  );
                },
              ),
              selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: getWidth(13),
                color: AppColors.primary,
              ),
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize:getWidth(12),
                color: AppColors.textPrimary,
              ),
            ),
          );
        },
      ),
    );
  }
}
