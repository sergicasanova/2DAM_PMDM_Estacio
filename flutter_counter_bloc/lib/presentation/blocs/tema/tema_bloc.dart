import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/presentation/blocs/tema/tema_state.dart';
import 'package:flutter_counter_bloc/presentation/blocs/tema/tema_event.dart';

class TemaBloc extends Bloc<TemaEvent, TemaState> {
  // Inicializa con valores predeterminados.
  TemaBloc() : super(const TemaState(selectedColor: 0, isDarkMode: false)) {
    on<ChangeThemeEvent>(_onChangeThemeEvent);
  }

  /* 
  Cuando bloc recibe un evento se ejecuta este metodo.
  Este metodo recibe el evento y emite un nuevo estado(TemaState) con valores
  actualizados. 
  Esto es lo que provoca que el blocbuilder escuche y actualice el tema en la aplicacion.
  */
  void _onChangeThemeEvent(ChangeThemeEvent event, Emitter<TemaState> emit) {
    emit(TemaState(
      selectedColor: event.selectedColor,
      isDarkMode: event.isDarkMode,
    ));
  }
}
