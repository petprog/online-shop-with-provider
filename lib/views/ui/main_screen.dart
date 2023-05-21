import 'package:flutter/material.dart';
import 'package:online_shop_with_provider/controller/main_screen_provider.dart';
import 'package:provider/provider.dart';
import '../shared/bottom_nav_bar.dart';
import 'page_list.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFE2E2E2),
          body: Center(child: pageList[mainScreenNotifier.pageIndex]),
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    );
  }
}
