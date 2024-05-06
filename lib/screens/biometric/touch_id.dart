import 'package:click/data/local/storage_repository.dart';
import 'package:click/screens/routes.dart';
import 'package:click/screens/screens/widgets/my_custom_button.dart';
import 'package:click/service/local_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';



class TouchIdScreen extends StatefulWidget {
  const TouchIdScreen({super.key});

  @override
  State<TouchIdScreen> createState() => _TouchIdScreenState();
}

class _TouchIdScreenState extends State<TouchIdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 200.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.fingerprint,
                size: 150.sp,
                color: Colors.blue,
              ),
              Icon(
                CupertinoIcons.eye_fill,
                size: 150.sp,
                color: Colors.blue,
              ),
            ],
          ),
          const Spacer(),
          MyCustomButton(
            onTap: enableBiometrics,
            title: "Biometrics Auth",
          ),
          MyCustomButton(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteNames.tabRoute,
                    (route) => false,
              );
            },
            title: "Skip",
          ),
        ],
      ),
    );
  }

  Future<void> enableBiometrics() async {
    bool authenticated = await BiometricAuthService.authenticate();
    if (authenticated) {
      await StorageRepository.setBool(
        key: "biometrics_enabled",
        value: true,
      );
      if (!context.mounted) return;
      showUnicalDialog(errorMessage: "Biometrics enabled");
    } else {
      showUnicalDialog(errorMessage: "Biometrics disabled");
    }
    if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      RouteNames.tabRoute,
          (route) => false,
    );
  }
}



showUnicalDialog({required String errorMessage}) {
  return Fluttertoast.showToast(
    msg: errorMessage,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.red,
    fontSize: 16.0,
  );
}