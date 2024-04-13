import 'package:flutter/material.dart';
import 'package:geekcontrol/home/atoms/bottom_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text('Tema'),
            onTap: () {
              Navigator.pushNamed(context, '/theme');
            },
          ),
          ListTile(
            title: const Text('Idioma'),
            onTap: () {
              Navigator.pushNamed(context, '/language');
            },
          ),
          ListTile(
            title: const Text('Notificações'),
            onTap: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
        ],
      ),
      bottomNavigationBar: const BottomBarWidget(),
    );
  }
}
