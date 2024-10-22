import 'package:flutter/material.dart';

class DialogLogout extends StatelessWidget {
  const DialogLogout({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Salir'),
        content: const Text('¿Estas seguro de que desea cerrar sesion?'),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.pop(context, 'Cancelar');
              },
              child: const Text('Cancelar')),
          TextButton(
              onPressed: () {
                Navigator.pop(context, 'Aceptar');
              },
              child: const Text('Aceptar'))
        ]);
  }
}
