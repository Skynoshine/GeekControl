import 'package:flutter/material.dart';
import 'package:geekcontrol/routes/routes.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentRouteName = ModalRoute.of(context)!.settings.name;

    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.home_outlined),
            onPressed: () {
              if (currentRouteName != RoutesName.home.route) {
                Navigator.pushNamed(context, RoutesName.home.route);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_chart_rounded),
            onPressed: () {
              if (currentRouteName != RoutesName.reviews.route) {
                Navigator.pushNamed(context, RoutesName.reviews.route);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_2),
            onPressed: () {
              if (currentRouteName != RoutesName.profile.route) {
                Navigator.pushNamed(context, RoutesName.profile.route);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.library_books_rounded),
            onPressed: () {
              if (currentRouteName != RoutesName.settings.route) {
                Navigator.pushNamed(context, RoutesName.settings.route);
              }
            },
          ),
        ],
      ),
    );
  }
}
