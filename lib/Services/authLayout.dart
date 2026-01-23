import 'package:expense_tracker/Page/home.dart';
import 'package:expense_tracker/Page/onBoardScreen.dart';
import 'package:expense_tracker/Services/authServices.dart';
import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key, this.pageIfNotConnected});

  final Widget? pageIfNotConnected;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: authservices,
      builder: (context, authservices, child) {
        return StreamBuilder(
          stream: authservices.authStateChange,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return Home();
            } else {
              return pageIfNotConnected ?? Onboardscreen();
            }
          },
        );
      },
    );
  }
}
