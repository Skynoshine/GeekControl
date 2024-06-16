import 'package:geekcontrol/animes/articles/pages/articles_page.dart';
import 'package:geekcontrol/animes/spoilers/pages/spoilers_page.dart';
import 'package:geekcontrol/animes/ui/pages/details_anime_page.dart';
import 'package:geekcontrol/animes/ui/pages/releases_animes_page.dart';
import 'package:geekcontrol/home/pages/home_page.dart';
import 'package:geekcontrol/screen_test.dart';
import 'package:geekcontrol/services/sites/otakupt/profile.dart';
import 'package:geekcontrol/services/sites/wallpapers/pages/wallpapers_page.dart';
import 'package:geekcontrol/settings_page/pages/settings_page.dart';
import 'package:go_router/go_router.dart';

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
        path: '/test',
        builder: (context, state) => const TestScreen(),
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
      GoRoute(
        path: '/wallpapers',
        builder: (context, state) => const WallpaperListScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
    ],
  );
}
