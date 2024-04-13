import 'package:flutter/material.dart';
import 'package:geekcontrol/core/library/hitagi_cup/features/dialogs/default_dialogs.dart';
import 'package:geekcontrol/core/library/hitagi_cup/features/dialogs/hitagi_dialog.dart';
import 'package:geekcontrol/core/library/hitagi_cup/features/dialogs/hitagi_search_dialog.dart';
import 'package:geekcontrol/core/library/hitagi_cup/features/text/hitagi_text.dart';
import 'package:geekcontrol/home/atoms/bottom_bar.dart';
import 'package:geekcontrol/repositories/tenor_images/tenor_repository.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _searchController = TextEditingController();
  Future<String>? _gifUrlFuture;

  @override
  void initState() {
    super.initState();
    final String searchTerm = _searchController.text.isNotEmpty
        ? _searchController.text
        : 'cat dancing';
    _gifUrlFuture = TenorRepository().getGifUrl(searchTerm);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          title: const HitagiText(
            text: 'Seu perfil',
          ),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Pesquisar'),
                      content: HitagiSearchDialog(
                        controller: _searchController,
                        hintText: 'Pesquisar ícone',
                        onSubmitted: (value) {
                          setState(() {
                            _gifUrlFuture = TenorRepository().getGifUrl(value);
                            Navigator.pop(context);
                          });
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Fechar'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () => HitagiDialog(
                title: FastText.unavailable.title,
                description: FastDescription.inProgress.message,
              ).show(context),
              icon: const Icon(Icons.exit_to_app),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<String>(
          future: _gifUrlFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://media1.tenor.com/m/lLT_5gUiMegAAAAC/trickshot.gif'),
                                ),
                              ),
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 120),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(snapshot.data!),
                              ),
                            ),
                          ],
                        ),
                        const HitagiText(
                          text: 'Skynoshine',
                          typography: HitagiTypography.button,
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        Container(
                          height: 400,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
      bottomNavigationBar: const BottomBarWidget(),
    );
  }
}
