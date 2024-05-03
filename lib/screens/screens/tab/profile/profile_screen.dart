import 'package:click/bloc/auth/auth_bloc.dart';
import 'package:click/bloc/user_bloc/user_bloc.dart';
import 'package:click/bloc/user_bloc/user_state.dart';
import 'package:click/screens/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.updateScreen,
                  arguments: context.read<UserProfileBloc>().state.userModel,
              );
            },
            icon: Icon(
              Icons.settings,
              size: 24.sp,
            ),
          ),

          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteNames.loginScreen, (route) => false);
              context.read<AuthBloc>().add(LogOutEvent());
            },
            icon: Icon(
              Icons.exit_to_app,
              size: 24.sp,
            ),
          ),
        ],
      ),
      body: BlocConsumer<UserProfileBloc, UserProfileState>(
        builder: (BuildContext context, UserProfileState state) {
          print(state.userModel.userName);
          return Column(
            children: [
              SizedBox(height: 20.h),
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
                    image: state.userModel.imageUrl.isEmpty
                        ? const NetworkImage("https://cdn-icons-png.flaticon.com/512/3135/3135715.png")
                        : NetworkImage(state.userModel.imageUrl)
                    as ImageProvider,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "${state.userModel.lastName} ${state.userModel.userName}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: Container(
                  padding:
                  EdgeInsets.only(left: 10.w, right: 10.w, top: 30.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 3),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: double.infinity),
                        Text(
                          "Email: ${state.userModel.email}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "Last name: ${state.userModel.lastName}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "First name: ${state.userModel.userName}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "Phone number: ${state.userModel.phoneNumber}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        listener: (BuildContext context, UserProfileState state) {},
      ),
    );
  }
}