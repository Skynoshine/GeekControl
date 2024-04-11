import 'package:flutter/material.dart';
import 'package:myapp/home/pages/home_page.dart';
import 'package:myapp/profile/pages/profile_page.dart';
import 'package:myapp/reviews/pages/reviews_page_two.dart';
import 'package:myapp/home/atoms/search_page.dart';
import 'package:myapp/settings_page/pages/settings_page.dart';

enum RoutesName {
  home,
  search,
  settings,
  profile,
  reviews,
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
      case RoutesName.reviews:
        return 'reviews';
      default:
        throw Exception('Rota não encontrada para o enum $this');
    }
  }
}

class AppRoutes {
  static Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    RoutesName.home.route: (_) => const HomePage(),
    RoutesName.search.route: (context) => const SearchPage(),
    RoutesName.settings.route: (context) => const SettingsPage(),
    RoutesName.profile.route: (context) => const ProfilePage(),
    RoutesName.reviews.route: (context) => const ReviewsPage(),
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
