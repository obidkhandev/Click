import 'package:click/utils/tools/file_importer.dart';



class BoardingPageTwo extends StatelessWidget {
  const BoardingPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.onBoard2,
          width: 280.w,
          height: 230.h,
        ),
        20.verticalSpace,
        Text(
          textAlign: TextAlign.center,
          "Your Financial Partner for Life: Citibank",
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
