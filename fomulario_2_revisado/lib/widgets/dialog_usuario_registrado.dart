import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/infraestructure/models/usuario.dart';

class DialogUsuarioRegistrado extends StatelessWidget {
  final Usuario? usuario;
  const DialogUsuarioRegistrado({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    IconData icono = Icons.check_circle_outline;
    Color colorIcono = Colors.green;

    return AlertDialog(
        title: Row(
          children: [
            Icon(icono, color: colorIcono, size: 30),
            const SizedBox(width: 10),
            const Text("Usuario Registrado"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Nombre: ${usuario?.nombre}"),
            Text("Apellidos: ${usuario?.apellidos}"),
            Text("Edad: ${usuario?.edad}"),
            Text("Email: ${usuario?.correo}"),
            Text("Sexo: ${usuario?.sexo}"),
            Text("Aficiones: ${usuario?.aficiones.join(', ')}"),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Continuar');
            },
            child: const Text('Continuar'),
          ),
        ]);
  }
}
