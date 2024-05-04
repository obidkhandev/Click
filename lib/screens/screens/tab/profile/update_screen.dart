import 'package:click/bloc/user_bloc/user_bloc.dart';
import 'package:click/bloc/user_bloc/user_event.dart';
import 'package:click/screens/routes.dart';
import 'package:click/screens/screens/tab/widgets/save_button.dart';
import 'package:click/screens/screens/tab/widgets/text_input.dart';
import 'package:click/screens/screens/widgets/button_container.dart';
import 'package:click/utils/constants/app_constants.dart';
import 'package:click/utils/tools/file_importer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/user_model.dart';

class UpdateUserScreen extends StatefulWidget {
  const UpdateUserScreen({super.key, required this.userModel});

  final UserModel userModel;

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  late UserModel userModel;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    userModel = widget.userModel;
    emailController.text = userModel.email;
    fullNameController.text = userModel.userName;
    passwordController.text = userModel.password;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              20.verticalSpace,
              Container(
                width: 150.w,
                height: 150.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 3),
                  ],
                  image: DecorationImage(
                    image: userModel.imageUrl.isEmpty
                        ? const NetworkImage(
                            "https://cdn-icons-png.flaticon.com/512/3135/3135715.png")
                        : NetworkImage(userModel.imageUrl) as ImageProvider,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              MyTextFieldWidget(
                keyBoardType: TextInputType.text,
                controller: emailController,
              ),
              MyTextFieldWidget(
                hintText: "last name",
                keyBoardType: TextInputType.text,
                controller: lastNameController,
              ),
              MyTextFieldWidget(
                hintText: "first name",
                keyBoardType: TextInputType.text,
                controller: fullNameController,
              ),
              MyTextFieldWidget(
                keyBoardType: TextInputType.text,
                hintText: "phone number",
                controller: phoneNumberController,
              ),
              MyTextFieldWidget(
                hintText: "password",
                keyBoardType: TextInputType.text,
                controller: passwordController,
                isObscureText: true,
              ),
              10.verticalSpace,
              ButtonContainer(
                title: "Update User",
                background: Colors.blue,
                isLoading: false,
                borderColor: Colors.blue,
                onTap: () {
                  context.read<UserProfileBloc>().add(
                        UpdateUserProfileEvent(
                          userModel: userModel.copyWith(
                            email: emailController.text,
                            userName: fullNameController.text,
                            uuId: FirebaseAuth.instance.currentUser!.uid,
                            lastName: lastNameController.text,
                            phoneNumber: phoneNumberController.text,
                            password: passwordController.text,
                          ),
                        ),
                      );
                  context
                      .read<UserProfileBloc>()
                      .add(GetUserProfileByUuIdEvent());
                  Navigator.pop(context);
                },
              ),
              15.verticalSpace,
              ButtonContainer(
                title: "DELETE USER",
                background: Colors.red,
                isLoading: false,
                borderColor: Colors.red,
                onTap: () {
                  context.read<UserProfileBloc>().add(
                        DeleteUserProfileEvent(
                          userModel: userModel.copyWith(
                            email: emailController.text,
                            userName: fullNameController.text,
                            uuId: FirebaseAuth.instance.currentUser!.uid,
                            lastName: lastNameController.text,
                            phoneNumber: phoneNumberController.text,
                            password: passwordController.text,
                          ),
                        ),
                      );
                  Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool get checkInput {
    return AppValidates.emailExp.hasMatch(emailController.text) &&
        AppValidates.nameRegExp.hasMatch(fullNameController.text);
  }

  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }
}
