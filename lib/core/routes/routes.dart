import 'package:flutter/material.dart';
import 'package:geekcontrol/animes/articles/pages/articles_page.dart';
import 'package:geekcontrol/animes/spoilers/pages/spoilers_page.dart';
import 'package:go_router/go_router.dart';
import 'package:geekcontrol/animes/ui/pages/details_anime_page.dart';
import 'package:geekcontrol/home/atoms/search_page.dart';
import 'package:geekcontrol/home/pages/home_page.dart';
import 'package:geekcontrol/animes/ui/pages/releases_animes_page.dart';
import 'package:geekcontrol/settings_page/pages/settings_page.dart';

class AppRoutes {
  static toHome(BuildContext context) {
    GoRouter.of(context).go('/');
  }

  static toRoute(BuildContext context, String route) {
    GoRouter.of(context).go(route);
  }

  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/articles',
        builder: (context, state) => const ArticlesPage(),
      ),
      GoRoute(
        path: '/releases',
        builder: (context, state) => const ReleasesAnimesPage(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => const SearchPage(),
      ),
      GoRoute(
        path: '/details',
        builder: (context, state) => const DetailsAnimePage(),
      ),
      GoRoute(
        path: '/spoilers',
        builder: (context, state) => const SpoilersPage(),
      ),
    ],
  );
}
