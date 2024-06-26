import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../atoms/search_page.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text("GeekControl"),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchPage()),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => GoRouter.of(context).push('/settings'),
        ),
      ],
    );
  }
}
