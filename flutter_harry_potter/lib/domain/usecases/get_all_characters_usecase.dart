import 'package:dartz/dartz.dart';
import 'package:flutter_harry_potter/domain/entities/character.dart';
import 'package:flutter_harry_potter/domain/repositories/character_repository.dart';

class GetAllCharacters {
  final CharacterRepository repository;

  GetAllCharacters(this.repository);

  //call, es una clase, permite que las instancias de la clase se invoquen como si fueran funciones.
  Future<Either<Exception, List<Character>>> call() async {
    return await repository.getAllCharacters();
  }
}
