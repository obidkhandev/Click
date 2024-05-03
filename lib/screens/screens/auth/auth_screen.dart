import 'package:click/bloc/auth/auth_bloc.dart';
import 'package:click/bloc/user_bloc/user_bloc.dart';
import 'package:click/bloc/user_bloc/user_event.dart';
import 'package:click/data/models/user_model.dart';
import 'package:click/screens/routes.dart';
import 'package:click/screens/screens/widgets/button_container.dart';
import 'package:click/utils/tools/file_importer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../utils/constants/app_constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  bool isLoadButton = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: BlocConsumer<AuthBloc, AuthState>(
        buildWhen: (last, current) {
          if (current is! AuthErrorState || current is! AuthSuccessState) {
            return true;
          }
          return false;
        },
        builder: (BuildContext context, AuthState state) {
          if (state is AuthLoadState) {
            isLoadButton = true;
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Register",
                    style: AppTextStyle.interBold.copyWith(
                      color: AppColors.blue1,
                      fontSize: 32.sp,
                    ),
                  ),
                  20.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      context.read<AuthBloc>().add(LoginWithGoogle());
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      decoration: BoxDecoration(
                          color: AppColors.mainColor.withOpacity(.2),
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppImages.googleIcon),
                          10.horizontalSpace,
                          Text(
                            "Google",
                            style: AppTextStyle.interLight,
                          ),
                        ],
                      ),
                    ),
                  ),
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width(context) / 4,
                        child: const Divider(),
                      ),
                      10.horizontalSpace,
                      Text("or",
                          style: TextStyle(
                              color: const Color(0xff486484), fontSize: 18.sp)),
                      10.horizontalSpace,
                      SizedBox(
                        width: width(context) / 4,
                        child: const Divider(),
                      ),
                    ],
                  ),
                  MyTextFieldWidget(
                    keyBoardType: TextInputType.text,
                    controller: nameController,
                    hintText: "Name",
                  ),
                  MyTextFieldWidget(
                    keyBoardType: TextInputType.text,
                    controller: emailController,
                    hintText: "Email",
                    regExp: AppValidates.emailExp,
                  ),
                  MyTextFieldWidget(
                    isObscureText: true,
                    regExp: AppValidates.passwordExp,
                    keyBoardType: TextInputType.text,
                    controller: passwordController,
                    hintText: "Password",
                  ),
                  MyTextFieldWidget(
                    isObscureText: true,
                    keyBoardType: TextInputType.text,
                    controller: confirmController,
                    hintText: "Confirm Password",
                  ),
                  20.verticalSpace,
                  Center(
                    child: SizedBox(
                      width: width(context) * 0.8,
                      height: 46.h,
                      child: ButtonContainer(
                        onTap: () {
                          context.read<AuthBloc>().add(
                                RegisterEvent(
                                  UserModel(
                                      imageUrl: '',
                                      email: emailController.text,
                                      userName: nameController.text,
                                      lastName: '',
                                      password: passwordController.text,
                                      phoneNumber: '',
                                      uuId: '',
                                      userId: ''),
                                  confirmController.text,
                                ),
                              );
                        },
                        title: 'Register',
                        isLoading: isLoadButton,
                        borderColor: AppColors.secondaryColor,
                      ),
                    ),
                  ),
                  40.verticalSpace,
                  Text("Already have an account?",
                      style: AppTextStyle.interSemiBold),
                  20.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.loginScreen);
                    },
                    child: Row(
                      children: [
                        Text(
                          "LOGIN",
                          style: AppTextStyle.interMedium
                              .copyWith(color: AppColors.secondaryColor),
                        ),
                        10.horizontalSpace,
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: AppColors.secondaryColor,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listenWhen: (last, current) {
          if (current is AuthErrorState || current is AuthSuccessState) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context, AuthState state) {
          if (state is AuthErrorState) {
            isLoadButton = false;
            Fluttertoast.showToast(
                msg: state.errorText,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          if (state is AuthSuccessState) {
            context.read<UserProfileBloc>().add(
                  AddUserProfileEvent(
                    userModel: UserModel(
                        imageUrl: '',
                        email: emailController.text,
                        userName: nameController.text,
                        lastName: '',
                        password: passwordController.text,
                        phoneNumber: '',
                        uuId: '',
                        userId: '',
                    ),
                  ),
                );
            isLoadButton = false;
            Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
          }
        },
      )),
    );
  }
}
