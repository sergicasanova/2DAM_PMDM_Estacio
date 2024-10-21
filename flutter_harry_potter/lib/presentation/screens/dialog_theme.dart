import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harry_potter/presentation/blocs/tema/tema_bloc.dart'; // Importa el TemaBloc
import 'package:flutter_harry_potter/config/theme/app_theme.dart';
import 'package:flutter_harry_potter/presentation/blocs/tema/tema_event.dart'; // Asegúrate de que la ruta sea correcta

class ThemeSelector extends StatefulWidget {
  const ThemeSelector({super.key});

  @override
  _ThemeSelectorState createState() => _ThemeSelectorState();
}

class _ThemeSelectorState extends State<ThemeSelector> {
  late int _tempSelectedColor;
  late bool _tempDarkMode;

  @override
  void initState() {
    super.initState();
    // Inicializa los valores temporales con los valores actuales del tema
    final temaState = context.read<TemaBloc>().state;
    _tempSelectedColor = temaState.selectedColor;
    _tempDarkMode = temaState.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
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
              value: _tempDarkMode,
              onChanged: (bool value) {
                setState(() {
                  _tempDarkMode = value;
                });
              },
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("Seleccionar color:"),
            ),
            Wrap(
              spacing: 16.0,
              children: List<Widget>.generate(colorList.length, (index) {
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _tempSelectedColor = index;
                    });
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
                    // Aplica los cambios al Bloc solo al presionar "Guardar"
                    context.read<TemaBloc>().add(ChangeThemeEvent(
                          selectedColor: _tempSelectedColor,
                          isDarkMode: _tempDarkMode,
                        ));
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
