import 'package:click/utils/colors/app_colors.dart';
import 'package:click/utils/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function() onTap;

  const RoundedButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),

          ),
        ),
        child: Text(
          text,
          style: AppTextStyle.interBold.copyWith(color: AppColors.mainColor),
        ));
  }
}
