import 'package:flutter/material.dart';

class DialogAlertWidget extends StatelessWidget {
  final bool resultado;
  final String textoAMostrar;
  const DialogAlertWidget(
      {super.key, required this.resultado, required this.textoAMostrar});

  @override
  Widget build(BuildContext context) {
    String textoCentral = resultado
        ? "Generación satisfactoria del robot: $textoAMostrar"
        : "Generación errónea. Debe escribir un nombre.";
    IconData icono =
        resultado ? Icons.check_circle_outline : Icons.error_outline;
    Color colorIcono = resultado ? Colors.green : Colors.red;

    return AlertDialog(
      title: Row(
        children: [
          Icon(icono, color: colorIcono, size: 30),
          const SizedBox(width: 10),
          const Text("Resultado de la generación"),
        ],
      ),
      content: Text(textoCentral),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Continuar');
          },
          child: const Text('Continuar'),
        ),
      ],
    );
  }
}
