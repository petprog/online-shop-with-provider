import 'package:flutter/material.dart';

import '../shared/app_style.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "This is Profile",
          style: appStyle(40, Colors.black, FontWeight.bold),
        ),
      ),
    );
  }
}
