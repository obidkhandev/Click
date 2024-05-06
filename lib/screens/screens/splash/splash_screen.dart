

import 'package:click/screens/local_auth/entry_password.dart';
import 'package:click/screens/local_auth/set_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/local/storage_repository.dart';
import '../../../utils/tools/file_importer.dart';
import '../../routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    if (!mounted) return;

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      bool isNewUser = StorageRepository.getBool(key: "is_new_user");
      if (isNewUser) {
        Navigator.pushReplacementNamed(context, RouteNames.register);
      } else {
        Navigator.pushReplacementNamed(context, RouteNames.onBoardingRoute);
      }
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>EntryPinScreen()));
    }
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppImages.appLogo,
              width: 200.w,
              height: 200.h,
            ),
            // 15.verticalSpace,
            Text(
              "CitiBank",
              style: AppTextStyle.interBold.copyWith(
                  fontFamily: "Poppins",
                  fontSize: 66.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.secondaryColor),
            ),
            Text(
              "The right relationship is everything.",
              style: AppTextStyle.interBold.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.secondaryColor),
            ),

          ],
        ),
      ),
    );
  }
}
