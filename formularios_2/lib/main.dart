import 'package:flutter/material.dart';
import 'package:formularios_2/widgets/form_register.dart';
//importamos el formulario desde widgets.dart
/* 
La función main() es el punto de entrada de tu 
aplicación Flutter. Es donde comienza la ejecución 
del programa.
*/
void main() {
  //Esta linea lanza la aplicacion
  runApp(const MyApp());
} 

//Aquí se configura el tema y la estructura de la app.
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  //Esta anotación indica que estás sobrescribiendo el método build de la clase base.
  @override
  /*
    En el método build(), se construye la interfaz de usuario, 
    definiendo un MaterialApp que establece temas y configura 
    una página principal (MyHomePage).
  */
  Widget build(BuildContext context) {
    return MaterialApp(
      /* 
      Estableces el widget Scaffold como la pantalla principal de tu aplicación. 
      Scaffold proporciona una estructura básica de diseño para tu aplicación, 
      incluyendo el AppBar, el cuerpo, y más.
      */
      home: Scaffold(
        //barra de aplicacion
        appBar: AppBar(
          //ponemos el titulo en el centro y definimos lo que hay escrito
          title: const Center(child: Text('Register'))
        ),
        //establecemos el orden de los children en columnas, es decir de manera horizontal
        body: const Column(
          children: <Widget>[
            //agregamos el form creado, el widget.
            FormRegister()
          ],
        ),
      ),
    );
    // Clase que define la página principal
  }
}

