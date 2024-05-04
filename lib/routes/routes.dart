import 'package:flutter/material.dart';
import 'package:geekcontrol/home/atoms/animes_carousel.dart';
import 'package:geekcontrol/home/atoms/search_page.dart';
import 'package:geekcontrol/home/pages/home_page.dart';
import 'package:geekcontrol/articles/pages/articles_page.dart';
import 'package:geekcontrol/settings_page/pages/settings_page.dart';

enum RoutesName {
  home,
  search,
  settings,
  profile,
  noticies,
  animesCarousel,
}

extension RoutesNameExtension on RoutesName {
  String get route {
    switch (this) {
      case RoutesName.home:
        return '/';
      case RoutesName.search:
        return 'search';
      case RoutesName.settings:
        return 'settings';
      case RoutesName.profile:
        return 'profile';
      case RoutesName.noticies:
        return 'notices';
      case RoutesName.animesCarousel:
        return 'animesCarousel';
      default:
        throw Exception('Rota não encontrada $this');
    }
  }
}

class AppRoutes {
  static Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    RoutesName.home.route: (_) => const HomePage(),
    RoutesName.search.route: (context) => const SearchPage(),
    RoutesName.settings.route: (context) => const SettingsPage(),
    RoutesName.noticies.route: (context) => const NoticiesPage(),
    RoutesName.animesCarousel.route: (context) => const AnimesCarouselWidget(),
  };

  static bool isCurrentRoute(BuildContext context, String routeName) {
    return ModalRoute.of(context)?.settings.name == routeName;
  }

  static void navigateTo(BuildContext context, String routeName) {
    if (!isCurrentRoute(context, routeName)) {
      Navigator.pushNamed(context, routeName);
    }
  }
}
