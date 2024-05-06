import 'package:flutter/material.dart';
import 'package:geekcontrol/home/atoms/animes_carousel.dart';
import 'package:geekcontrol/home/atoms/search_page.dart';
import 'package:geekcontrol/home/pages/home_page.dart';
import 'package:geekcontrol/articles/pages/articles_page.dart';
import 'package:geekcontrol/settings_page/pages/settings_page.dart';

enum RoutesName {
  home,
  noticies,
  search,
  settings,
  profile,
  animesCarousel,
}

extension RoutesNameExtension on RoutesName {
  String get route {
    switch (this) {
      case RoutesName.home:
        return '/';
      case RoutesName.noticies:
        return 'noticies';
      case RoutesName.search:
        return 'search';
      case RoutesName.settings:
        return 'settings';
      case RoutesName.profile:
        return 'profile';
      case RoutesName.animesCarousel:
        return 'animesCarousel';
      default:
        throw Exception('Rota não encontrada $this');
    }
  }

  int get index {
    switch (this) {
      case RoutesName.home:
        return 0;
      case RoutesName.noticies:
        return 1;
      case RoutesName.search:
        return 2;
      case RoutesName.settings:
        return 3;
      case RoutesName.profile:
        return 4;
      case RoutesName.animesCarousel:
        return 5;
      default:
        throw Exception('Rota não encontrada $this');
    }
  }
}

class AppRoutes {
  static List<WidgetBuilder> routes = [
    (_) => const HomePage(),
    (_) => const ArticlesPage(),
    (_) => const SearchPage(),
    (_) => const SettingsPage(),
    (_) => const AnimesCarouselWidget(),
  ];

  static bool _isCurrentRoute(BuildContext context, int routeIndex) {
    return ModalRoute.of(context)?.settings.name ==
        RoutesName.values[routeIndex].route;
  }

  static void navigateTo(BuildContext context, RoutesName routeName) {
    if (!_isCurrentRoute(context, routeName.index)) {
      Navigator.pushNamed(context, routeName.route);
    }
  }

  static void navigateToIndex(BuildContext context, int index) {
    if (index >= 0 && index < routes.length) {
      Navigator.push(context, MaterialPageRoute(builder: routes[index]));
    }
  }

  Map<String, WidgetBuilder> buildRoutesMap(List<WidgetBuilder> routes) {
    final Map<String, WidgetBuilder> mappedRoutes = {};

    for (int i = 0; i < routes.length; i++) {
      final RoutesName routeName = RoutesName.values[i];
      final String routePath = routeName.route;
      final WidgetBuilder builder = routes[i];
      mappedRoutes[routePath] = builder;
    }

    return mappedRoutes;
  }
}
