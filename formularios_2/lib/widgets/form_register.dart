import 'package:flutter/material.dart';
import 'package:formularios_2/widgets/infraestructure/models/usuario.dart';

class FormRegister extends StatefulWidget {
  const FormRegister({super.key});

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Controladores para cada campo
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();

  String? _sexoSeleccionado;
  
  // Map para las aficiones con su estado inicial (false = no seleccionado)
  final List<String> _aficiones = ['Deportes', 'Lectura', 'Cocinar', 'Videojuegos', 'Viajar'];
  final List<bool> _aficionesSeleccionadas = List.generate(5, (_) => false);

  String? _validarSexo() {
    if (_sexoSeleccionado == null) {
      return 'Por favor, selecciona un sexo';
    }
    return null;
  }

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
            Row(
              children: [
                const Text('Nombre:', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _nombreController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'El nombre es obligatorio';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Apellidos:', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _apellidosController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'El apellido es obligatorio';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('Edad:', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _edadController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'La edad es obligatoria';
                      }
                      final edad = int.tryParse(value);
                      if (edad == null) {
                        return 'Por favor, introduce un número válido';
                      }
                      if (edad < 18){
                        return 'Debes ser mayor de 18 años';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('Email:', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _correoController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'El email es obligatorio';
                      }
                      // Validar el formato del email si es necesario
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('Sexo:', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 10),
                Expanded(
                  child: Row(
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
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
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
                  )
                )
              ],
            ),
            if (_validarSexo() != null)
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 5.0),
                  child: Text(
                    _validarSexo()!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),

              const SizedBox(height: 10),

            const Text("Aficiones:", style: TextStyle(fontSize: 18)),
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
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (!_aficionesSeleccionadas.contains(true)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Debes seleccionar al menos una afición")),
                    );
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

                    print(usuario); // Mostrar el usuario en consola
                  
                    // Limpiar los campos después de enviar
                    _nombreController.clear();
                    _apellidosController.clear();
                    _edadController.clear();
                    _correoController.clear();
                    _sexoSeleccionado = null;
                    _aficionesSeleccionadas.fillRange(0, _aficionesSeleccionadas.length, false);

                    // Forzar la actualización de la interfaz
                    setState(() {});
                  
                  }
                }
              },
              child: const Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
