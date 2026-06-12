// Controller
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/image_path.dart';

class UserHomeController extends GetxController {
  var username = "Jaden".obs;
  var services = [
    {"title": "Ac Repair", "icon": ImagePath.acImage , "color": Color(0xFF1A2A80).withValues(alpha: 0.1)},
    {"title": "Plumbing", "icon": ImagePath.plumbingImage, "color": Color(0xFF7B4620).withValues(alpha: 0.1)},
    {"title": "Cleaning", "icon": ImagePath.cleaningImage, "color": Color(0xFF8AA624).withValues(alpha: 0.1)},
    {"title": "Electrical", "icon": ImagePath.electricianImage, "color": Color(0xFF799EFF).withValues(alpha: 0.1)},
  ];
}
