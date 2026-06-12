import 'package:get/get.dart';

class ChoseRoleController extends GetxController {
  var selectedRole = 'CUSTOMER'.obs;

  void selectRole(String role) {
    selectedRole.value = role;
  }
}