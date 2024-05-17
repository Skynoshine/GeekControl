import 'package:geekcontrol/services/sites/otakupt/profile.dart';

import '../../animes/articles/pages/articles_page.dart';
import '../../animes/spoilers/pages/spoilers_page.dart';
import 'package:go_router/go_router.dart';
import '../../animes/ui/pages/details_anime_page.dart';
import '../../home/atoms/search_page.dart';
import '../../home/pages/home_page.dart';
import '../../animes/ui/pages/releases_animes_page.dart';
import '../../settings_page/pages/settings_page.dart';

class AppRoutes {
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
        path: '/profile',
        builder: (context, state) => const Profile(),
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
