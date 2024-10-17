import 'package:equatable/equatable.dart';

/* 
Equatable, permite comparar instancias de temaState para verificar sj su estado ha cambiado
*/
class TemaState extends Equatable {
  final int selectedColor;
  final bool isDarkMode;

  const TemaState({
    required this.selectedColor,
    required this.isDarkMode,
  });

  @override
  //get pops, se utiliza para comparar instancias, si alguna cambia se considera que el estado ha cambiado
  List<Object> get props => [selectedColor, isDarkMode];
}
