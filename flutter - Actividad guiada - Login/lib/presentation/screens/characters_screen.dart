import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harry_potter/presentation/blocs/characters/characters_bloc.dart';
import 'package:flutter_harry_potter/presentation/blocs/characters/characters_event.dart';
import 'package:flutter_harry_potter/presentation/blocs/characters/characters_state.dart';
import 'package:flutter_harry_potter/presentation/blocs/login/login_bloc.dart';
import 'package:flutter_harry_potter/presentation/blocs/login/login_event.dart';
import 'package:flutter_harry_potter/presentation/widgets/drawer_settings.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_harry_potter/presentation/screens/dialog_logout.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharactersScreen> {
  String _filter = '';

  @override
  void initState() {
    //con el add enviamos al bloc
    super.initState();
    context.read<CharacterBloc>().add(LoadCharactersEvent(_filter));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Personajes de Harry Potter'),
          actions: [
            IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () async {
                  final resultado = await _showLogoutDialog(context);
                  if (resultado == 'Aceptar') {
                    context.read<LoginBloc>().add(LogoutButtonPressed());
                    context.go('/login');
                  }
                }),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _filter = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Filtrar por nombre',
                        border: const OutlineInputBorder(),
                        labelStyle: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    onPressed: () {
                      context
                          .read<CharacterBloc>()
                          .add(LoadCharactersEvent(_filter));
                    },
                    child: const Icon(Icons.search),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<CharacterBloc, CharacterState>(
                builder: (context, state) {
                  // Mostrar el indicador de carga mientras isLoading sea true
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  // Mostrar mensaje de error si hay uno
                  else if (state.errorMessage.isNotEmpty) {
                    return Center(child: Text(state.errorMessage));
                  }
                  // Mostrar la lista de personajes
                  else if (state.characters.isNotEmpty) {
                    return ListView.builder(
                      itemCount: state.characters.length,
                      itemBuilder: (context, index) {
                        final character = state.characters[index];
                        return ListTile(
                          leading: Image.network(character.image),
                          title: Text(character.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Casa: ${character.house}'),
                              Text(
                                  'Año de nacimiento: ${character.yearOfBirth}'),
                              Text('Especie: ${character.species}')
                            ],
                          ),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Información de ${character.name}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                          'Año de nacimiento: ${character.yearOfBirth}'),
                                      Text('Especie: ${character.species}'),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  }

                  // Si no hay personajes, mostrar un mensaje vacío
                  else {
                    return const Center(
                        child: Text(
                            'No hay personajes que coincidan con el filtro.'));
                  }
                },
              ),
            ),
          ],
        ),
        drawer: const CounterDrawerWidget());
  }

  Future<String?> _showLogoutDialog(BuildContext context) async {
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return const DialogLogout();
      },
    );
  }
}
