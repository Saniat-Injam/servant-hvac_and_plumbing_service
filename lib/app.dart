import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:servant_hvac_and_plumbing_service/routes/app_routes.dart';
import 'core/bindings/controller_binder.dart';
import 'core/utils/constants/app_sizer.dart';
import 'core/utils/constants/app_sizes.dart';
import 'core/utils/theme/theme.dart';


class PlatformUtils {
  static bool get isIOS =>
      foundation.defaultTargetPlatform == TargetPlatform.iOS;
  static bool get isAndroid =>
      foundation.defaultTargetPlatform == TargetPlatform.android;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoute.init,
          getPages: AppRoute.routes,
          initialBinding: ControllerBinder(),
          themeMode: ThemeMode.light,
          theme: _getLightTheme(),
          darkTheme: _getDarkTheme(),
          defaultTransition:
              PlatformUtils.isIOS ? Transition.cupertino : Transition.fade,
          locale: Get.deviceLocale,
          builder: EasyLoading.init(),
        );
      },
    );
  }

  ThemeData _getLightTheme() {
    return PlatformUtils.isIOS
        ? AppTheme.lightTheme.copyWith(platform: TargetPlatform.iOS)
        : AppTheme.lightTheme;
  }

  ThemeData _getDarkTheme() {
    return PlatformUtils.isIOS
        ? AppTheme.darkTheme.copyWith(platform: TargetPlatform.iOS)
        : AppTheme.darkTheme;
  }
}
