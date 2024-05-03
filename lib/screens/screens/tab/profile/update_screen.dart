import 'package:click/bloc/user_bloc/user_bloc.dart';
import 'package:click/bloc/user_bloc/user_event.dart';
import 'package:click/screens/routes.dart';
import 'package:click/screens/screens/tab/widgets/save_button.dart';
import 'package:click/screens/screens/tab/widgets/text_input.dart';
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

  @override
  void initState() {
    userModel = widget.userModel;
    emailController.text = userModel.email;
    fullNameController.text = "${userModel.userName} ${userModel.lastName}";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 90.h,
              width: width(context),
            ),
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
            UniversalTextInput(
              controller: emailController,
              hintText: "Email",
              type: TextInputType.emailAddress,
              regExp: AppValidates.emailExp,
              onChange: (v) {
                setState(() {});
              },
              errorTitle: "Invalid input",
            ),
            UniversalTextInput(
              controller: fullNameController,
              hintText: "Full name",
              type: TextInputType.emailAddress,
              regExp: AppValidates.nameRegExp,
              onChange: (v) {
                setState(() {});
              },
              errorTitle: "Invalid input",
            ),
            SaveButton(
              onTab: () {
                context.read<UserProfileBloc>().add(
                      UpdateUserProfileEvent(
                        userModel: userModel.copyWith(
                          email: emailController.text,
                          userName: fullNameController.text,
                          uuId: FirebaseAuth.instance.currentUser!.uid,
                        ),
                      ),
                    );
               Navigator.pushNamed(context, RouteNames.tabRoute);
              },
              active: checkInput,
              loading: false,
            ),
          ],
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

    super.dispose();
  }
}
