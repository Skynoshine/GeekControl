import 'package:flutter/material.dart';
import 'package:geekcontrol/home/components/releases_carousel.dart';
import 'package:geekcontrol/home/components/top_rateds_carousel.dart';
import 'package:geekcontrol/core/library/hitagi_cup/features/text/hitagi_text.dart';
import 'package:geekcontrol/home/atoms/bottom_bar.dart';
import 'package:geekcontrol/home/components/banner_carrousel.dart';
import 'package:geekcontrol/home/components/top_bar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: TopBarWidget(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 8,
                bottom: 8,
              ),
              child: HitagiText(
                text: 'Últimas notícias!',
                typography: HitagiTypography.button,
              ),
            ),
            SizedBox(
              height: 150,
              child: BannerCarousel(),
            ),
            ReleasesCarousel(),
            TopRatedsCarousel(),
          ],
        ),
      ),
      bottomNavigationBar: BottomBarWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
