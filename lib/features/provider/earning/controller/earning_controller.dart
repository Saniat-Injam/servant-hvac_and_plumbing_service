
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:servant_hvac_and_plumbing_service/core/services/Auth_service.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_urls.dart';
import '../data/earning_over_view_model.dart';


class EarningsController extends GetxController {
  var totalRevenue = 0.0.obs;
  var weeklyData = <Weekly>[].obs;
  var selectedTimeFrame = "Weekly".obs;

  final dio = Dio();

  @override
  void onInit() {
    super.onInit();
    fetchEarnings();
  }

  Future<void> fetchEarnings() async {
    try {
      final response =
      await dio.get(AppUrls.earningOverView, options: Options(
        headers: {
          "Authorization": "Bearer ${AuthService.token}", // ✅ Pass your JWT or access token here
          "Content-Type": "application/json",
        },
      ),); // replace local_url
      if (response.statusCode == 200) {
        final model = EarningOverviewModel.fromJson(response.data);
        if (model.success) {
          totalRevenue.value = model.result.totalRevenue;
          weeklyData.assignAll(model.result.weekly);
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch earnings');
      print(e);
    }
  }

  double getRevenueForDay(String day) {
    final item = weeklyData.firstWhereOrNull((e) => e.day == day);
    return item?.total ?? 0.0;
  }

  void setTimeFrame(String value) {
    selectedTimeFrame.value = value;
  }
}
