import 'package:click/utils/colors/app_colors.dart';
import 'package:click/utils/images/app_images.dart';
import 'package:click/utils/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoardingPageOne extends StatelessWidget {
  const BoardingPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.onBoard1,
          width: 300.w,
          height: 200.h,
        ),
        20.verticalSpace,
        Text(
          textAlign: TextAlign.center,
          "The right relationship is everything.",
          style: AppTextStyle.interBold
              .copyWith(color: AppColors.blue1, fontSize: 24.sp),
        ),
        10.verticalSpace,
        Text(
          textAlign: TextAlign.center,
          "Your Trusted Partner in Financial Success",
          style: AppTextStyle.interLight.copyWith(
            color: AppColors.blue1,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        100.verticalSpace,
      ],
    );
  }
}
