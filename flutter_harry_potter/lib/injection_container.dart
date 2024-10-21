import 'package:flutter_harry_potter/data/datasources/character_remote_datasource.dart';
import 'package:flutter_harry_potter/data/repositories/character_repository_impl.dart';
import 'package:flutter_harry_potter/domain/repositories/character_repository.dart';
import 'package:flutter_harry_potter/domain/usecases/get_all_characters_usecase.dart';
import 'package:flutter_harry_potter/presentation/blocs/characters/characters_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

//se utiliza para registrar y obtener las dependecias necesarias a lo largo de la aplicacion.
final sl = GetIt.instance;

Future<void> init() async {
  // BloC
  sl.registerFactory(() => CharacterBloc(sl()));

  // Casos de uso, un Singleton, es un patron que asegura que solo tiengas una instancia de ese objeto en la aplicacion.
  sl.registerLazySingleton(() => GetAllCharacters(sl()));

  // Repositorios
  sl.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<CharacterRemoteDataSource>(
    () => CharacterRemoteDataSourceImpl(sl()),
  );

  // Cliente HTTP
  sl.registerLazySingleton(() => http.Client());
}
