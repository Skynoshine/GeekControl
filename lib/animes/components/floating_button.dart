import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:flutter/material.dart';
import 'package:geekcontrol/animes/articles/controller/articles_controller.dart';
import 'package:geekcontrol/animes/sites_enum.dart';

class FloattingButton extends StatelessWidget {
  final ArticlesController ct;

  const FloattingButton({super.key, required this.ct});

  @override
  Widget build(BuildContext context) {
    return AnimatedFloatingActionButton(
      fabButtons: <Widget>[
        _buildImageFabButton(
          image: 'assets/intoxi.png',
          heroTag: 'intoxi',
          onPressed: () {
            ct.changedSite(SitesEnum.intoxi);
          },
        ),
        _buildImageFabButton(
          image: 'assets/animes_new.png',
          heroTag: 'animes_new',
          onPressed: () {
            ct.changedSite(SitesEnum.animesNew);
          },
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
  }) {
    return FloatingActionButton(
      onPressed: onPressed,
      heroTag: heroTag,
      tooltip: 'Pressione',
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
