import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:flutter/material.dart';
import 'package:geekcontrol/animes/articles/controller/articles_controller.dart';
import 'package:geekcontrol/animes/sites_enum.dart';

class HitagiFloattingButton extends StatelessWidget {
  final ArticlesController _ct;

  const HitagiFloattingButton({super.key, required ArticlesController ct})
      : _ct = ct;

  @override
  Widget build(BuildContext context) {
    return AnimatedFloatingActionButton(
      fabButtons: <Widget>[
        _buildImageFabButton(
          image: 'assets/intoxi.png',
          heroTag: 'intoxi',
          onPressed: () {
            _ct.changedSite(SitesEnum.intoxi);
          },
          isSelected: _ct.currenctIndex == 3,
        ),
        _buildImageFabButton(
          image: 'assets/otakuPT_icon.png',
          heroTag: 'otakuPT',
          onPressed: () {
            _ct.changedSite(SitesEnum.otakuPt);
          },
          isSelected: _ct.currenctIndex == 2,
        ),
        _buildImageFabButton(
          image: 'assets/animes_new.png',
          heroTag: 'animes_new',
          onPressed: () {
            _ct.changedSite(SitesEnum.animesNew);
          },
          isSelected: _ct.currenctIndex == 1,
        ),
      ],
      animatedIconData: AnimatedIcons.list_view,
      colorStartAnimation: Colors.white,
      colorEndAnimation: Colors.white,
    );
  }

  Widget _buildImageFabButton({
    required String image,
    required VoidCallback onPressed,
    required String heroTag,
    required bool isSelected,
  }) {
    return FloatingActionButton(
      onPressed: onPressed,
      heroTag: heroTag,
      tooltip: 'Pressione',
      backgroundColor: isSelected
          ? const Color.fromARGB(255, 247, 167, 167)
          : const Color.fromARGB(122, 255, 255, 255),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          image,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
