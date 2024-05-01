import 'package:click/bloc/auth/auth_bloc.dart';
import 'package:click/screens/routes.dart';
import 'package:click/screens/screens/widgets/rounded_button.dart';
import 'package:click/utils/tools/file_importer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: BlocConsumer<AuthBloc, AuthState>(
        builder: (BuildContext context, AuthState state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Log In",
                    style: AppTextStyle.interBold.copyWith(
                      color: AppColors.blue1,
                      fontSize: 32.sp,
                    ),
                  ),
                  20.verticalSpace,
                  GestureDetector(
                    onTap: () {},
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
                    controller: emailController,
                    hintText: "Email",
                  ),
                  MyTextFieldWidget(
                    isObscureText: true,
                    keyBoardType: TextInputType.text,
                    controller: passwordController,
                    hintText: "Password",
                  ),
                  20.verticalSpace,
                  Center(
                    child: SizedBox(
                      width: width(context) * 0.8,
                      height: 46.h,
                      child: RoundedButton(
                        text: "Get Started Now",
                        onTap: () {
                          context.read<AuthBloc>().add(
                                LoginEvent(emailController.text,
                                    passwordController.text),
                              );
                        },
                      ),
                    ),
                  ),
                  40.verticalSpace,
                  Text("Don't have an account?",
                      style: AppTextStyle.interSemiBold),
                  20.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, RouteNames.register);
                    },
                    child: Row(
                      children: [
                        Text(
                          "Register",
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
        listener: (BuildContext context, AuthState state) {
          if (state is AuthErrorState) {
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
            Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
          }
        },
      )),
    );
  }
}
