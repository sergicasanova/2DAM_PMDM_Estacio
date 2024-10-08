class Usuario {
  final String nombre;
  final String apellidos;
  final int edad;
  final String correo;
  final String sexo;
  final List<String> aficiones;

  Usuario({
    required this.nombre,
    required this.apellidos,
    required this.edad,
    required this.correo,
    required this.sexo,
    required this.aficiones,
  });

  @override
  String toString() {
    return 'Usuario(nombre: $nombre, apellidos: $apellidos, edad: $edad, correo: $correo, sexo: $sexo, aficiones: $aficiones)';
  }
}
