import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harry_potter/presentation/blocs/characters/characters_bloc.dart';
import 'package:flutter_harry_potter/presentation/screens/characters_screen.dart';
import 'package:flutter_harry_potter/config/theme/app_theme.dart';
import 'package:flutter_harry_potter/presentation/blocs/tema/tema_bloc.dart';
import 'package:flutter_harry_potter/presentation/blocs/tema/tema_state.dart';
import 'injection_container.dart' as injection_container;

void main() async {
  // Inicialización de repositorios
  await injection_container.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MultiBlocProvider para manejar tanto el TemaBloc como el CharacterBloc
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => injection_container.sl<CharacterBloc>(),
        ),
        BlocProvider(
          create: (context) => TemaBloc(),
        ),
      ],
      child: BlocBuilder<TemaBloc, TemaState>(
        builder: (context, temaState) {
          // Aplicar el tema basado en el estado del TemaBloc
          final appTheme = AppTheme(
            selectedColor: temaState.selectedColor,
            isDarkmode: temaState.isDarkMode,
          );

          return MaterialApp(
            title: 'Harry Potter Characters',
            debugShowCheckedModeBanner: false,
            theme: appTheme.getTheme(), // Obtener el tema
            home: const CharactersScreen(),
          );
        },
      ),
    );
  }
}
