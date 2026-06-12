import 'package:flutter/material.dart';
import 'package:servant_hvac_and_plumbing_service/core/utils/constants/app_sizes.dart';

class AcceptRequestDialog extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final String confirmButtonTitle,cancelButtonTitle;
  final  IconData iconData;

  const AcceptRequestDialog({
    super.key,
    required this.title,
    required this.description,
    required this.onAccept,
    required this.onReject, required this.confirmButtonTitle, required this.cancelButtonTitle, required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: ModalRoute.of(context)!.animation!,
        curve: Curves.easeOutBack,
      ),
      child: Dialog(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: EdgeInsets.symmetric(horizontal: getWidth(24), vertical:getHeight(24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Gradient Header with Icon
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding:  EdgeInsets.only(right: getWidth(20),left: getWidth(20),top: getHeight(20),bottom: getHeight(20)),
              width: double.infinity,
              child:  Icon(
                iconData,
                color: Colors.white,
                size: 48,
              ),
            ),

            // Title & Description
            Padding(
              padding: EdgeInsets.only(left: getWidth(20),right: getWidth(20),top: getHeight(20),bottom: getHeight(20)),
              child: Column(
                children: [
                  Text(
                    title,
                    style:TextStyle(
                      fontSize: getWidth(22),
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: getHeight(12)),
                  Text(
                    description,
                    style:  TextStyle(
                      fontSize: getWidth(15),
                      color: Colors.black54,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height:getHeight(20)),

                  // Buttons Row
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(vertical:getHeight(16)),
                            elevation: 3,
                          ),
                          onPressed: onReject,
                          child:  Text(
                            cancelButtonTitle,
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      SizedBox(width: getWidth(10)),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(vertical: getHeight(16)),
                            elevation: 3,
                          ),
                          onPressed: onAccept,
                          child: Text(
                            confirmButtonTitle,
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
