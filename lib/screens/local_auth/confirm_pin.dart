import 'package:click/data/local/storage_repository.dart';
import 'package:click/screens/local_auth/widget/password_buttons.dart';
import 'package:click/screens/routes.dart';
import 'package:click/service/local_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pinput/pinput.dart';

import '../../utils/tools/file_importer.dart';
import 'widget/pit_put_view.dart';


class ConfirmPinScreen extends StatefulWidget {
  const ConfirmPinScreen({super.key, required this.previousPin});

  final String previousPin;

  @override
  State<ConfirmPinScreen> createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends State<ConfirmPinScreen> {
  final TextEditingController pinPutController = TextEditingController();

  final FocusNode focusNode = FocusNode();

  bool isError = false;

  bool biometricsEnabled = false;

  @override
  void initState() {
    BiometricAuthService.canAuthenticate().then((value) {
      if (value) {
        biometricsEnabled = true;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 150.h),
          Text(
            "Pin kodni qayta kiriting!",
            style: AppTextStyle.interSemiBold.copyWith(fontSize: 20),
          ),
          SizedBox(height: 32.h),
          SizedBox(
            width: 200.w,
            child: PinPutTextView(
              isError: isError,
              pinPutFocusNode: focusNode,
              pinPutController: pinPutController,
            ),
          ),
          SizedBox(height: 32.h),
          Text(
            isError ? "Pin kod oldingisi bilan mos emas" : "",
            style: AppTextStyle.interMedium.copyWith(color: Colors.red),
          ),
          CustomKeyboardView(
            onFingerPrintTap: () {},
            number: (number) {
              if (pinPutController.length < 4) {
                isError = false;
                pinPutController.text = "${pinPutController.text}$number";
              }
              if (pinPutController.length == 4) {
                if (widget.previousPin == pinPutController.text) {
                  _setPin(pinPutController.text);
                } else {
                  isError = true;
                  pinPutController.clear();
                }
                pinPutController.text = "";
              }
              setState(() {});
            },
            isBiometricsEnabled: false,
            onClearButtonTap: () {
              if (pinPutController.length > 0) {
                pinPutController.text = pinPutController.text.substring(
                  0,
                  pinPutController.text.length - 1,
                );
              }
            },
          )
        ],
      ),
    );
  }

  Future<void> _setPin(String pin) async {
    await StorageRepository.setString(
      key: "pin_code",
      value: pin,
    );

    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      biometricsEnabled ? RouteNames.touchIdRoute : RouteNames.tabRoute,
          (route) => false,
    );
  }
}