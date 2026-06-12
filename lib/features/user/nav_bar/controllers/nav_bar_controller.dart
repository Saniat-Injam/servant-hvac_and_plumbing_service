import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_sizer.dart';

import '../../../../core/utils/constants/icon_path.dart';
import '../../home/presentation/screens/user_home_screen.dart';
import '../../profile/presentation/screen/user_profile_screen.dart';
import '../../service/presentation/screen/service_screen.dart';


class UserNavBarController extends GetxController {
  final _selectedIndex = 0.obs;

  int get currentIndex => _selectedIndex.value;

  void changeIndex(int index) {
    _selectedIndex.value = index;
  }

  final List<Widget> screens = const [
    HomeScreen(),
    ServicesScreen(),
    UserProfileScreen(),
  ];

  final List<String> labels = const ['Home', 'Services', 'Profile'];

  final List<Image> activeIcons = [
    Image.asset(IconPath.homeActiveIcon, height: 26.h, width: 26.w, fit: BoxFit.cover),
    Image.asset(IconPath.serviceActiveIcon, height: 26.h, width: 26.w, fit: BoxFit.cover),
    Image.asset(IconPath.profileActiveIcon, height: 26.h, width: 26.w, fit: BoxFit.cover),

  ];

  final List<Image> inActiveIcons = [
    Image.asset(IconPath.homeInActiveIcon, height: 26.h, width: 26.w, fit: BoxFit.cover),
    Image.asset(IconPath.settingInActiveIcon, height: 26.h, width: 26.w, fit: BoxFit.cover),
    Image.asset(IconPath.profileInActiveIcon, height: 26.h, width: 26.w, fit: BoxFit.cover),

  ];
}
