import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/presentation/blocs/tema/tema_bloc.dart'; // Importa el TemaBloc
import 'package:flutter_counter_bloc/config/theme/app_theme.dart';
import 'package:flutter_counter_bloc/presentation/blocs/tema/tema_event.dart'; // Asegúrate de que la ruta sea correcta

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtener el estado actual del TemaBloc
    final temaState = context.watch<TemaBloc>().state;

    return Dialog(
      child: SizedBox(
        width: 300,
        height: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Elija el tema",
                style: TextStyle(fontSize: 20),
              ),
            ),
            SwitchListTile(
              title: const Text('Modo oscuro'),
              value: temaState.isDarkMode,
              onChanged: (bool value) {
                context.read<TemaBloc>().add(ChangeThemeEvent(
                      selectedColor: temaState.selectedColor,
                      isDarkMode: value,
                    ));
              },
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("Seleccionar color:"),
            ),
            //contenedor para organizar los hijos en multiple lineas
            Wrap(
              spacing: 16.0,
              children: List<Widget>.generate(colorList.length, (index) {
                return ElevatedButton(
                  onPressed: () {
                    context.read<TemaBloc>().add(ChangeThemeEvent(
                          selectedColor:
                              index, // El índice del color seleccionado
                          isDarkMode: temaState.isDarkMode,
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorList[index],
                  ),
                  child: const Text(""),
                );
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Guardar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
