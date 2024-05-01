import 'package:click/screens/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/auth/auth_bloc.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(LogOutEvent());
              Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
            },
            child: Text("LogOut"),
          ),
        ));
  }
}
