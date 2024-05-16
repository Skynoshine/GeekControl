import 'package:flutter/material.dart';
import '../atoms/bottom_bar.dart';
import '../components/banner_carrousel.dart';
import '../components/top_bar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: TopBarWidget(),
      ),
      body: BannerCarousel(),
      bottomNavigationBar: BottomBarWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
