import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/dialog_usuario_registrado.dart';
import 'package:flutter_application_1/widgets/infraestructure/models/usuario.dart';

class DialogAlertWidget extends StatelessWidget {
  final bool resultado;
  final Usuario? usuario;
  const DialogAlertWidget(
      {super.key, required this.resultado, required this.usuario});

  @override
  Widget build(BuildContext context) {
    String textoCentral = resultado
        ? "Desea registrar el usuario?"
        : "Para registrarse, ha de reyenar todos los campos.";
    IconData icono =
        resultado ? Icons.check_circle_outline : Icons.error_outline;
    Color colorIcono = resultado ? Colors.green : Colors.red;

    return AlertDialog(
      title: Row(
        children: [
          Icon(icono, color: colorIcono, size: 30),
          const SizedBox(width: 10),
          const Text("Registro de usuario"),
        ],
      ),
      content: Text(textoCentral),
      actions: <Widget>[
        if (resultado) ...[
          TextButton(
            onPressed: () {
              // Acciones para continuar registrando
              Navigator.pop(context, 'Continuar');
              _mostrarDialogoUsuarioRegistrado(context, usuario);
            },
            child: const Text('Continuar'),
          ),
          TextButton(
            onPressed: () {
              // Acciones para volver a la pantalla anterior
              Navigator.pop(context, 'Volver');
            },
            child: const Text('Volver'),
          ),
        ] else ...[
          /* ...[ estás indicando que deseas expandir el contenido de la lista que sigue. 
        En lugar de agregar la lista como un solo elemento*/
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cerrar'),
          ),
        ],
      ],
    );
  }

  Future<void> _mostrarDialogoUsuarioRegistrado(
      BuildContext context, Usuario? usuario) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return DialogUsuarioRegistrado(usuario: usuario);
      },
    );
  }
}
