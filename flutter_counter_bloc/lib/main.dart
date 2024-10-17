import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/presentation/blocs/counter/counter_bloc.dart';
import 'package:flutter_counter_bloc/presentation/blocs/tema/tema_bloc.dart';
import 'package:flutter_counter_bloc/presentation/screens/counter_home_page_screen.dart';
import 'package:flutter_counter_bloc/config/theme/app_theme.dart';
import 'package:flutter_counter_bloc/presentation/blocs/tema/tema_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //multiBlocProvider, para proporcionar tanto el counterBloc como el temabloc
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CounterBloc(),
        ),
        BlocProvider(
          create: (context) => TemaBloc(),
        ),
      ],
      //rodeamos materialapp con un blocbuilder para reconstruirlo cada vez que se cambie el estado de temabloc
      // cada vez que el estado del temabloc cambia, el blocbuilder reconstruira su contenido
      child: BlocBuilder<TemaBloc, TemaState>(
        builder: (context, temaState) {
          // Aplicar el tema basado en el estado del TemaBloc
          final appTheme = AppTheme(
            selectedColor: temaState.selectedColor,
            isDarkmode: temaState.isDarkMode,
          );

          return MaterialApp(
            title: 'Counter utilizando Bloc',
            debugShowCheckedModeBanner: false,
            theme: appTheme.getTheme(), // Obtener el tema
            home: const CounterHomePageScreen(),
          );
        },
      ),
    );
  }
}
