import 'package:flutter/material.dart';

/*
Aqui iniciamos una nueva clse llamada RobotsGenerator 
que extiende a StatefulWidget esto significa que esta 
clase puede mantener un estado que puede cambiar la 
vida de widget.

El constructor usa super.key, que permite a Flutter 
identificar el widget de manera única cuando se 
construyen múltiples widgets.
*/
class RobotsGenerator extends StatefulWidget {
  const RobotsGenerator({super.key});

  @override
  State<RobotsGenerator> createState() => _RobotsGeneratorState();
}

/* 
Aqui definimos la clase que maneja  el estado RobotsGenerator
*/
class _RobotsGeneratorState extends State<RobotsGenerator> {
  //Siempre se introduce -Dicho por Pepe-
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Creamos dos variables para guardar el nombre introducido y la url
  String? _robotName;
  String _imageUrl = '';

  @override
  //Este método se llama cada vez que se necesita reconstruir la interfaz del widget.
  Widget build(BuildContext context) {
    /* 
    Aquí se crea un widget Form que usará _formKey para manejar 
    el estado y la validación.
    */
    return Form(
      key: _formKey,
      //Padding: Añade un relleno de 8 píxeles alrededor del formulario.
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        //con column organizamos los widgets verticalmente
        child: Column(
          //definimos como organizaremos los hijos dentro del eje, es decir a la izquierda.
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /* 
            Introducimos una row para agrupar unos widgets en concreto
            en una fila, con esto podemos introducir el text(label) 
            en la misma fila que el textFormField.
            */
            Row(
              children: [
                const Text('Nombre:', style: TextStyle(fontSize: 18)),
                //añadimos un espacio entre el label y el input.
                const SizedBox(width: 10),
                //con expanded permitimos que el input oucpe el resto disponible en la fila
                Expanded(
                  //TextFormField, input, campo de entrada.
                  child: TextFormField(
                    /* 
                    validator: Es una función que se llama al validar el formulario. 
                    Devuelve un mensaje de error si el campo está vacío. Si no hay 
                    error, devuelve null.
                    */
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
            //align, alineamos el boton a la derecha de la pantalla
            Align(
              alignment: Alignment.centerRight,
              //tipo de boton que se puede presionar
              child: ElevatedButton(
                //definimos su comportamiento con la funcion onPressed
                onPressed: () {
                  //validamos que el formulario sea valido
                  if (_formKey.currentState!.validate()) {
                    //llamamos a la url para actualizar la UI
                    setState(() {
                      _imageUrl = 'https://robohash.org/$_robotName';
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Debe introducir un nombre para generar el robot')),
                    );
                  }
                },
                child: const Text('Generar Robot'),
              ),
            ),
            //añadimos un espacio de 20 pixeles
            const SizedBox(height: 20),
            //comprobamos que la imagen no este vacia
            if (_imageUrl.isNotEmpty)
            //centramos la imgaen en la pantalla
              Center(
                //con image.network, cargamos y mostramos la imagen desde la url
                child: Image.network(
                  //la imagen, y especificamos el tamaño de la misma
                  _imageUrl,
                  height: 200,
                  width: 200,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
