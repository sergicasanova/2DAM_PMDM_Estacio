abstract class TemaEvent {
  const TemaEvent();
}

//la clase se utiliza para enviar información al TemaBloc indicando que debe actualizar el estado.
class ChangeThemeEvent extends TemaEvent {
  final int selectedColor;
  final bool isDarkMode;

  const ChangeThemeEvent(
      {required this.selectedColor, required this.isDarkMode});
}
