import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/common/widgets/custom_text.dart';
import '../../../../core/utils/constants/app_sizes.dart';
import '../../../../core/utils/constants/image_path.dart';

class CustomDialogBox extends StatelessWidget {
  const CustomDialogBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.symmetric(horizontal: getWidth(24)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            SizedBox(height: getHeight(32)),
            Image.asset(ImagePath.successImage,height: getHeight(100),width: getWidth(100),),
            SizedBox(height: getHeight(20),),
            CustomText(text: "Success!",fontSize: getWidth(21),fontWeight: FontWeight.w700,),
            SizedBox(height: getHeight(10),),
            CustomText(text: "Your account is verified \nsuccessfully.",fontSize: getWidth(15),fontWeight: FontWeight.w400,textAlign: TextAlign.center,),
            SizedBox(height: getHeight(24),),
            CupertinoActivityIndicator(
              radius: 25, // size of the spinner
              color: Color(0xff7B4620).withValues(alpha: 0.7), // iOS-style blue
            ),
            SizedBox(height: getHeight(32),),

          ],
        ));
  }
}