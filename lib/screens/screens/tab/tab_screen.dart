import 'package:click/bloc/user_bloc/user_bloc.dart';
import 'package:click/bloc/user_bloc/user_event.dart';
import 'package:click/cubit/tab_box_cubit.dart';
import 'package:click/screens/screens/tab/card/card_screen.dart';
import 'package:click/screens/screens/tab/history/history_screen.dart';
import 'package:click/screens/screens/tab/home/home_screen.dart';
import 'package:click/screens/screens/tab/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<Widget> _screens = const [
    CardScreen(),
    HomeScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];
  @override
  void initState() {
    debugPrint("Hello microtask from Tab screen");
    Future.microtask(() {
       context.read<UserProfileBloc>().add(GetUserProfileByUuIdEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TabBoxCubit(),
      child: BlocBuilder<TabBoxCubit, int>(
        builder: (BuildContext context, int state) {
          return Scaffold(
            body: _screens[state],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state,
              onTap: context.read<TabBoxCubit>().changeValue,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.credit_card,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  label: "",
                  activeIcon: Icon(
                    Icons.credit_card,
                    color: Colors.black,
                    size: 24.sp,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.house,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  label: "",
                  activeIcon: Icon(
                    Icons.house,
                    color: Colors.black,
                    size: 24.sp,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.history,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  label: "",
                  activeIcon: Icon(
                    Icons.history,
                    color: Colors.black,
                    size: 24.sp,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  label: "",
                  activeIcon: Icon(
                    Icons.person,
                    color: Colors.black,
                    size: 24.sp,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}