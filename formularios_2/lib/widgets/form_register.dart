import 'package:flutter/material.dart';

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
  final Map<String, bool> _aficiones = {
    'Deportes': false,
    'Lectura': false,
    'Cocinar': false,
    'Videojuegos': false,
    'Viajar': false,
  };

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
              Column(
                children: _aficiones.keys.map((String key) {
                  return CheckboxListTile(
                    title: Text(key),
                    value: _aficiones[key],
                    onChanged: (bool? value) {
                      setState(() {
                        _aficiones[key] = value ?? false;
                      });
                    },
                  );
                }).toList(),
              ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Usuario registrado')),
                    );

                    // Limpiar los campos después del registro
                    _nombreController.clear();
                    _apellidosController.clear();
                    _edadController.clear();
                    _correoController.clear();
                  }
                },
                child: const Text('Registrar usuario'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
