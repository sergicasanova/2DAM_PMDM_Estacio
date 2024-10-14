import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/infraestructure/models/usuario.dart';
import 'package:flutter_application_1/widgets/dialog_alert_widget.dart';

class FormRegister extends StatefulWidget {
  const FormRegister({super.key});

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();

  String? _sexoSeleccionado;

  final List<String> _aficiones = [
    'Deportes',
    'Lectura',
    'Cocinar',
    'Videojuegos',
    'Viajar'
  ];
  final List<bool> _aficionesSeleccionadas = List.generate(5, (_) => false);

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidosController.dispose();
    _edadController.dispose();
    _correoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextFormField(
              controller: _nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'El nombre es obligatorio';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _apellidosController,
              decoration: const InputDecoration(
                labelText: 'Apellidos',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'El apellido es obligatorio';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _edadController,
              decoration: const InputDecoration(
                  labelText: 'Edad', prefixIcon: Icon(Icons.person)),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'La edad es obligatoria';
                }
                final edad = int.tryParse(value);
                if (edad == null) {
                  return 'Por favor, introduce un número válido';
                }
                if (edad < 18) {
                  return 'Debes ser mayor de 18 años';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _correoController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'El email es obligatorio';
                }
                // Validar el formato del email si es necesario
                return null;
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Masculino'),
                    value: 'Masculino',
                    groupValue: _sexoSeleccionado,
                    onChanged: (String? value) {
                      setState(() {
                        _sexoSeleccionado = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: const Text('Femenino'),
                    value: 'Femenino',
                    groupValue: _sexoSeleccionado,
                    onChanged: (String? value) {
                      setState(() {
                        _sexoSeleccionado = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Aficiones:",
                  style: TextStyle(fontSize: 18),
                ),
                ..._aficiones.asMap().entries.map<Widget>((dynamic entry) {
                  final index = entry.key;
                  final aficion = entry.value;
                  return CheckboxListTile(
                    title: Text(aficion),
                    value: _aficionesSeleccionadas[index],
                    onChanged: (bool? value) {
                      setState(() {
                        _aficionesSeleccionadas[index] = value ?? false;
                      });
                    },
                  );
                }),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (!_aficionesSeleccionadas.contains(true)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text("Debes seleccionar al menos una afición")),
                    );
                    _mostrarAlerta(false);
                  } else if (_sexoSeleccionado == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Debes seleccionar el sexo")),
                    );
                    _mostrarAlerta(false);
                  } else {
                    final usuario = Usuario(
                      nombre: _nombreController.text,
                      apellidos: _apellidosController.text,
                      edad: int.parse(_edadController.text),
                      correo: _correoController.text,
                      sexo: _sexoSeleccionado!,
                      aficiones: _aficiones
                          .asMap()
                          .entries
                          .where((entry) => _aficionesSeleccionadas[entry.key])
                          .map((entry) => entry.value)
                          .toList(),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Usuario registrado")),
                    );

                    _mostrarAlerta(true, usuario);

                    // Limpiar los campos después de enviar
                    // _nombreController.clear();
                    // _apellidosController.clear();
                    // _edadController.clear();
                    // _correoController.clear();
                    // _sexoSeleccionado = null;
                    // _aficionesSeleccionadas.fillRange(
                    //     0, _aficionesSeleccionadas.length, false);

                    // Forzar la actualización de la interfaz
                    setState(() {});
                  }
                } else {
                  _mostrarAlerta(false);
                }
              },
              child: const Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _mostrarAlerta(bool resultado, [Usuario? usuario]) async {
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return DialogAlertWidget(
          resultado: resultado,
          usuario: usuario,
        );
      },
    );
  }
}
