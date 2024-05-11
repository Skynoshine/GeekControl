import 'package:flutter/material.dart';
import 'package:geekcontrol/home/atoms/bottom_bar.dart';
import 'package:geekcontrol/home/components/top_bar_widget.dart';
import 'package:geekcontrol/home/components/banner_carrousel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: TopBarWidget(),
      ),
      body: BannerCarousel(),
      bottomNavigationBar: const BottomBarWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
