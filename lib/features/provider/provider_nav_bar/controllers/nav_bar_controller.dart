import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_sizer.dart';

import '../../../../core/utils/constants/icon_path.dart';
import '../../../user/profile/presentation/screen/user_profile_screen.dart';

import '../../earning/presentation/screens/earning_over_view_screen.dart';
import '../../home/presentation/screens/provider_home_screen.dart';
import '../../service/presentation/screen/provider_service_screen.dart';



class ProviderNavBarController extends GetxController {
  final _selectedIndex = 0.obs;

  int get currentIndex => _selectedIndex.value;

  void changeIndex(int index) {
    _selectedIndex.value = index;
  }

  final List<Widget> screens = [
    const EngineerHomeScreen (),
    const ProviderServicesScreen(),
    EarningsOverviewScreen(),
    const UserProfileScreen(),
  ];

  final List<String> labels = const ['Home', 'Services','Earnings','Profile'];

  final List<Image> activeIcons = [
    Image.asset(IconPath.homeActiveIcon, height: 26.h, width: 26.w, fit: BoxFit.cover),
    Image.asset(IconPath.serviceActiveIcon, height: 26.h, width: 26.w, fit: BoxFit.cover),
    Image.asset(IconPath.earningActiveIcon, height: 26.h, width: 26.w, fit: BoxFit.cover),
    Image.asset(IconPath.profileActiveIcon, height: 26.h, width: 26.w, fit: BoxFit.cover),

  ];

  final List<Image> inActiveIcons = [
    Image.asset(IconPath.homeInActiveIcon, height: 26.h, width: 26.w, fit: BoxFit.cover),
    Image.asset(IconPath.settingInActiveIcon, height: 26.h, width: 26.w, fit: BoxFit.cover),
    Image.asset(IconPath.earningInActiveIcon , height: 26.h, width: 26.w, fit: BoxFit.cover),
    Image.asset(IconPath.profileInActiveIcon, height: 26.h, width: 26.w, fit: BoxFit.cover),

  ];
}
