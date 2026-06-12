import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_colors.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_sizes.dart';
import '../../../../../core/utils/constants/image_path.dart';
import '../../controller/earning_controller.dart';

class EarningsOverviewScreen extends StatelessWidget {
  EarningsOverviewScreen({super.key});

  final EarningsController controller = Get.put(EarningsController());

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Stack(
        children: [
          // Header
          Column(
            children: [
              Container(
                width: double.infinity,
                height: getHeight(200),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff7B4620), Color(0xffD26719)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
            ],
          ),
          Positioned(
            top: getHeight(85),

            child: Center(
              child: Row(
                children: [
                  SizedBox(width: getWidth(18)),
                  GestureDetector(
                    onTap: () {
                      //Get.back();
                    },
                    child: Image.asset(
                      ImagePath.backImage,
                      height: getHeight(50),
                      width: getWidth(50),
                    ),
                  ),
                  SizedBox(width: getWidth(60)),
                  Text(
                    "Earning Overview",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: getWidth(22),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: getHeight(180),
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: getWidth(16), vertical: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Total Revenue Card
                    Obx(() => Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xffE3E3E9), width: 1),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 6,
                              offset: const Offset(0, 2))
                        ],
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: getHeight(40), horizontal: getWidth(20)),
                      child: Column(
                        children: [
                           Text(
                            "Total Revenue",
                            style: TextStyle(fontSize: getWidth(21), fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: getHeight(10)),
                          Text(
                            "\$${controller.totalRevenue.value.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontSize: getWidth(30), fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    )),

                    SizedBox(height: getHeight(20)),

                    // Overview + Dropdown
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xffE3E3E9), width: 1),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 6,
                              offset: const Offset(0, 2))
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Overview",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getWidth(12), vertical: getHeight(8)),
                                decoration: BoxDecoration(
                                  color: Color(0xff7B4620).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8000),
                                  border: Border.all(
                                      color: Color(0xff7B4620), width: getWidth(1)),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "Weekly",
                                      style: TextStyle(
                                          fontSize: getWidth(14), color: AppColors.primary),
                                    ),
                                    SizedBox(width:getWidth(6),),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      color: AppColors.primary,
                                      size: getWidth(20),
                                    ),
                                  ],
                                ),
                              )
                              // Obx(() => Container(
                              //   padding: EdgeInsets.symmetric(
                              //       horizontal: getWidth(12), vertical: getHeight(4)),
                              //   decoration: BoxDecoration(
                              //     color: Color(0xff7B4620).withValues(alpha: 0.1),
                              //     borderRadius: BorderRadius.circular(8000),
                              //     border: Border.all(
                              //         color:  Color(0xff7B4620), width: getWidth(1)),
                              //   ),
                              //   child: DropdownButton<String>(
                              //     value: controller.selectedTimeFrame.value,
                              //     underline: const SizedBox(),
                              //     items: ['Weekly',]
                              //         .map(
                              //           (e) => DropdownMenuItem(
                              //         value: e,
                              //         child: Text(e,
                              //             style: TextStyle(
                              //                 fontSize: getWidth(14),
                              //                 color: AppColors.primary)),
                              //       ),
                              //     )
                              //         .toList(),
                              //     onChanged: (val) {
                              //       if (val != null) controller.setTimeFrame(val);
                              //     },
                              //   ),
                              // ))
                            ],
                          ),

                          SizedBox(height: getHeight(16)),

                          // Chart
                          Obx(() {
                            final labels = controller.selectedTimeFrame.value == "Weekly"
                                ? controller.weeklyData.map((e) => e.day).toList()
                                : [
                              'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'
                            ];
                            return SizedBox(
                              height: getHeight(250),
                              child: LineChart(
                                LineChartData(
                                  minY: 0,
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: List.generate(
                                        labels.length,
                                            (index) => FlSpot(
                                            index.toDouble(),
                                            controller.getRevenueForDay(labels[index])),
                                      ),
                                      isCurved: true,
                                      color: AppColors.primary,
                                      barWidth: getWidth(3),
                                      belowBarData: BarAreaData(
                                        show: true,
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.primary.withOpacity(0.4),
                                            Colors.transparent
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                      dotData: FlDotData(show: true),
                                    ),
                                  ],
                                  titlesData: FlTitlesData(

                                    bottomTitles: AxisTitles(

                                      sideTitles: SideTitles(
                                        showTitles: true,

                                        getTitlesWidget: (value, meta) {

                                          int index = value.toInt();
                                          if (index >= 0 && index < labels.length) {
                                            return Padding(
                                              padding: EdgeInsets.only(top: getHeight(6)),
                                              child: Text(labels[index],
                                                  style: TextStyle(fontSize: getWidth(14))),
                                            );
                                          }
                                          return const Text('');
                                        },
                                        interval: 1,
                                      ),
                                    ),
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        interval:
                                        controller.selectedTimeFrame.value == "Weekly"
                                            ? 50
                                            : 200,
                                        reservedSize: 40,
                                      ),
                                    ),
                                    topTitles: AxisTitles(
                                        sideTitles: SideTitles(showTitles: false)),
                                    rightTitles: AxisTitles(
                                        sideTitles: SideTitles(showTitles: false)),
                                  ),
                                  gridData: FlGridData(
                                    show: true,
                                    drawHorizontalLine: true,
                                    horizontalInterval: controller.selectedTimeFrame.value ==
                                        "Weekly"
                                        ? 50
                                        : 200,
                                    getDrawingHorizontalLine: (value) => FlLine(
                                      color: Colors.grey.shade300,
                                      strokeWidth: 1,
                                    ),
                                  ),
                                  borderData: FlBorderData(show: false),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
