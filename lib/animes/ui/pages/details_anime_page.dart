import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailsAnimePage extends StatefulWidget {
  const DetailsAnimePage({super.key});

  @override
  State<DetailsAnimePage> createState() => _DetailsAnimePageState();
}

class _DetailsAnimePageState extends State<DetailsAnimePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => GoRouter.of(context).go('/'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Center(child: Text('Details')),
      ),
      body: const Center(
        child: Text(''),
      ),
    );
  }
}
