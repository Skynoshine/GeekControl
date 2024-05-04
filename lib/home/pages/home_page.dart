import 'package:flutter/material.dart';
import 'package:geekcontrol/anime/pages/anime_info_page.dart';
import 'package:geekcontrol/home/atoms/bottom_bar.dart';
import 'package:geekcontrol/home/components/appbar_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarHome(),
      ),
      body: AnimeDetailsPage(),
      bottomNavigationBar: BottomBarWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
