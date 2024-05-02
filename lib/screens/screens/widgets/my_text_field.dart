import 'package:click/utils/colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final RegExp? regExp;
  final String errorText;
  final TextInputType keyBoardType;
  final Widget? suffixIcon;
  final bool isObscureText;
  final FocusNode? focusNode;
  final Widget? prefixIcon;

  const MyTextFieldWidget({
    super.key,
    this.hintText = '',
    required this.keyBoardType,
    required this.controller,
    this.suffixIcon = const SizedBox(),
    this.isObscureText = false,
    this.focusNode,
    this.regExp,
    this.prefixIcon,
    this.errorText = '',
  });

  @override
  State<MyTextFieldWidget> createState() => _MyTextFieldWidgetState();
}

class _MyTextFieldWidgetState extends State<MyTextFieldWidget> {
  bool obscure = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12)
      ),
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.regExp != null
            ? (v) {
          if (v != null && widget.regExp!.hasMatch(v)) {
            return null;
          } else {
            return widget.errorText;
          }
        }
            : null,
        obscureText: obscure,
        focusNode: widget.focusNode,
        controller: widget.controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.mainColor.withOpacity(0.2),
          contentPadding: EdgeInsets.all(10.sp),
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isObscureText
              ? IconButton(
            onPressed: () {
              setState(() {
                obscure = !obscure;
              });
            },
            icon: Icon(
                obscure ? CupertinoIcons.eye : CupertinoIcons.eye_slash),
          )
              : widget.suffixIcon,
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14.sp),
          border: InputBorder.none,
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.w, color: Colors.red),
              borderRadius: BorderRadius.circular(12.sp)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.transparent),
              borderRadius: BorderRadius.circular(12.sp)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.transparent),
              borderRadius: BorderRadius.circular(12.sp)),
        ),
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.black,
        ),
        keyboardType: widget.keyBoardType,
        // maxLines: ,
        textAlign: TextAlign.start,
      ),
    );
  }
}
