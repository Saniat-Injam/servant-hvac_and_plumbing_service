import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:servant_hvac_and_plumbing_service/core/common/widgets/app_snack_bar.dart';
import 'package:servant_hvac_and_plumbing_service/core/common/widgets/custom_elevated_button_widget.dart';
import 'package:servant_hvac_and_plumbing_service/core/common/widgets/custom_outlined_button_widget.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_sizer.dart';

import '../../../../../core/common/widgets/category_text.dart';
import '../../../../../core/common/widgets/custom_text.dart';

import '../../../../../core/common/widgets/formatted_date_text_widget.dart';
import '../../../../../core/common/widgets/progress_indicator.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/app_sizes.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../../../../core/utils/constants/image_path.dart';
import '../../controller/payment_controller.dart';
import '../../controller/service_controller.dart';


class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late final String? token;
  @override
  void initState() {
    // TODO: implement initState
    // token = AuthService.token;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   final serviceController = Get.find<ServicesController>();
    final controller = Get.put(ServicePaymentController());
    final arguments = Get.arguments;
    final String? imagePath = arguments['imagePath'];
    final String? serviceName = arguments['serviceName'];
    final String? address = arguments['address'];
    final String? time = arguments['time'];
    final String? category = arguments['category'];
    final double? price = double.tryParse(arguments['price']);
    final String? serviceId = arguments['serviceId'];
    //
    var servicePrice = price;
    var platformFee = 20.00;
    var total = servicePrice! + platformFee;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getHeight(40)),
            // Top AppBar
            Row(
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.black,
                    size: 20.w,
                  ),
                ),
                SizedBox(width: 120.w),
                CustomText(
                  text: "Payment",
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),

            SizedBox(height: 26.h),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: getWidth(0.2),
                      color: const Color(0xffC8C8C8),
                    ),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                        child: imagePath!= null? Image.network(
                          imagePath,
                          height: getHeight(130),
                          width: getWidth(130),
                          fit: BoxFit.cover,
                        ):Image.asset(
                          ImagePath.noImage,
                          height: getHeight(130),
                          width: getWidth(130),
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: getWidth(12)),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: getHeight(8)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                serviceName ?? "N/A",
                                style: TextStyle(
                                  fontSize: getWidth(16),
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: getHeight(4)),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    IconPath.serviceLocationIcon,
                                    height: getHeight(16),
                                    width: getWidth(16),
                                  ),
                                  SizedBox(width: getWidth(4)),
                                  Expanded(
                                    child: Text(
                                      address ?? "",
                                      style: TextStyle(
                                        fontSize: getWidth(13),
                                        color: AppColors.textGrey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: getHeight(4)),
                              Row(
                                children: [
                                  Image.asset(
                                    IconPath.calenderIcon,
                                    height: getHeight(16),
                                    width: getWidth(16),
                                  ),
                                  SizedBox(width: getWidth(4)),
                                  Expanded(
                                    child: FormattedDateText(
                                      isoDate: time,
                                      style: TextStyle(
                                        fontSize: getWidth(14),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: getHeight(10)),
                              Row(
                                children: [
                                  CategoryText(categoryKey: category),
                                  SizedBox(width: getWidth(10)),
                                  Expanded(
                                    child: Text.rich(
                                      TextSpan(
                                        text: 'Price: ',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "\$$price",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: getWidth(13),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.end,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getHeight(20)),
                Text(
                  "Price Details",
                  style: TextStyle(
                    fontSize: getWidth(16),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: getHeight(20)),
                Container(
                  padding: EdgeInsets.only(
                    left: getWidth(20),
                    right: getWidth(20),
                    top: getHeight(20),
                    bottom: getHeight(20),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xff747474).withValues(alpha: 0.1),
                  ),
                  child: Column(
                    children: [
                      buildPriceRowWidget(
                        title: 'Price',
                        price: servicePrice.toString(),
                      ),
                      SizedBox(height: getHeight(16)),
                      Image.asset(ImagePath.dottedDividerImage),

                      Column(
                        children: [
                          SizedBox(height: getHeight(16)),
                          buildPriceRowWidget(
                            title: 'Allocation Fee',
                            price: platformFee.toString(),
                          ),
                          SizedBox(height: getHeight(16)),
                          Image.asset(ImagePath.dottedDividerImage),
                        ],
                      ),

                      SizedBox(height: getHeight(16)),
                      buildPriceRowWidget(
                        title: 'Total Amount',
                        price: total.toStringAsFixed(1),
                      ),
                      SizedBox(height: getHeight(16)),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),

            // Payment Methods
            CustomText(
              text: "Payment Method",
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 16.h),

            _buildPaymentOption("Stripe", "stripe", controller),

            Spacer(),
            CustomElevatedButtonWidget(
              buttonTitle: "Pay Now ( \$${total.toStringAsFixed(2)} )",
              onPressed: () async {
                if (controller.selectedPaymentMethod.value.isEmpty) {
                  AppSnackBar.showError("Please select payment method");


                } else {
                  try {
                    bool isPaymentSuccessful = await controller.paymentStart(

                      serviceId: serviceId.toString(),



                    );

                    if (isPaymentSuccessful) {
                      //await serviceController.fetchPendingDetails();
                      await serviceController. fetchActiveDetails();
                      await serviceController.fetchCompleteDetails();
                      if (!context.mounted) return;

                      showModalBottomSheet(
                        context: context,
                        backgroundColor: AppColors.backgroundLight,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                        ),
                        builder: (context) {
                          return _buildConfirmationBottomSheet(controller);
                        },
                      );
                      // Navigate or show success
                    } else {
                      // Show error message
                    }
                  } catch (e) {
                    ServicePaymentController.isLoading1 = false;
                    hideProgressIndicator(); // ✅ make sure it's called
                    Get.snackbar(
                      "Error",
                      "Payment failed: $e",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  } finally {
                    // ✅ Ensure this is called no matter what
                    hideProgressIndicator();
                    ServicePaymentController.isLoading1 = false;
                  }
                  debugPrint(controller.selectedPaymentMethod.value);
                  //debugPrint(widget.bookingID);
                  Get.back(); // Or navigate forward
                }
              },
            ),


            //
            SizedBox(height: getHeight(20)),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(
    String title,
    String value,
    ServicePaymentController controller,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Color(0xff747474).withAlpha(26),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(width: getWidth(20)),

          Expanded(
            child: CustomText(
              text: title,
              fontSize: 24.sp,
              fontWeight: FontWeight.w900,
              color: Color(0xff635BFF),
            ),
          ),
          Obx(
            () => Transform.scale(
              scale: 1.1,
              child: Radio<String>(
                value: value,
                groupValue: controller.selectedPaymentMethod.value,
                onChanged: (val) {
                  controller.selectedPaymentMethod.value = val!;
                },
                activeColor: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPriceRowWidget({required String title, required String price}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: getWidth(16), fontWeight: FontWeight.w600),
        ),
        Text(
          "\$ $price",
          style: TextStyle(
            color: Color(0xff0277BD),
            fontSize: getWidth(16),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmationBottomSheet(ServicePaymentController controller) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 17.h),
            Image.asset(ImagePath.ticMarkImage, height: 100, width: 100),
            SizedBox(height: 30.h),
            CustomText(
              text: "Confirm Booking",
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(height: 12.h),
            CustomText(
              text: "Do you want to confirm this booking?",
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),

            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  Get.back();
                },
                child: CustomText(
                  text: "Done",
                  color: AppColors.backgroundLight,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDateToReadable(String dateText) {
    try {
      DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(dateText);
      return DateFormat('d MMMM yyyy').format(parsedDate);
    } catch (e) {
      return "Invalid Date";
    }
  }

  String formatDateTime(DateTime dateTime) {
    final formatter = DateFormat("MMMM dd, yyyy 'at' h:mm a");
    return formatter.format(dateTime);
  }
}
