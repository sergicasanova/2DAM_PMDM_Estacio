import 'package:dartz/dartz.dart';
import 'package:flutter_harry_potter/data/datasources/character_remote_datasource.dart';
import 'package:flutter_harry_potter/domain/entities/character.dart';
import 'package:flutter_harry_potter/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;

  CharacterRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Exception, List<Character>>> getAllCharacters() async {
    try {
      //llamamos al metodo getAllCharacters, recogemos la respuesta
      final characterModels = await remoteDataSource.getAllCharacters();
      // cuando va bien retornamos la parte derecha del either
      return Right(characterModels
          .map((model) => Character(
              name: model.name,
              house: model.house,
              image: model.image,
              yearOfBirth: model.yearOfBirth,
              species: model.species))
          .toList());
    } catch (e) {
      // si va mal devolvemos la excepcion de la izquierda
      return Left(Exception('Error al cargar personajes'));
    }
  }
}
