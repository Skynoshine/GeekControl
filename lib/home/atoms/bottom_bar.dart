import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:geekcontrol/core/routes/routes.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      style: TabStyle.react,
      initialActiveIndex: 0,
      backgroundColor: Colors.transparent,
      activeColor: Colors.black,
      color: Colors.black,
      height: 26,
      items: const [
        TabItem(icon: Icons.home),
        TabItem(icon: Icons.article),
        TabItem(icon: Icons.add),
        TabItem(icon: Icons.notifications),
        TabItem(icon: Icons.person),
      ],
      onTap: (index) => AppRoutes.navigateToIndex(context, index),
    );
  }
}
