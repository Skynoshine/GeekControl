import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:go_router/go_router.dart';

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
      height: 30,
      items: const [
        TabItem(icon: Icons.home),
        TabItem(icon: Icons.newspaper),
        TabItem(icon: Icons.new_releases),
        TabItem(icon: Icons.article),
        TabItem(icon: Icons.person),
      ],
      onTap: (index) => GoRouter.of(context).push(routesIndex(index)),
    );
  }

  routesIndex(int index) {
    switch (index) {
      case 0:
        return '/';
      case 1:
        return '/articles';
      case 2:
        return '/releases';
      case 3:
        return '/spoilers';
      case 4:
        return 'search';
      case 5:
        return 'animeDetails';
      default:
    }
  }
}
