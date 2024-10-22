import 'package:dartz/dartz.dart';
import 'package:flutter_harry_potter/domain/entities/character.dart';

abstract class CharacterRepository {
  //class either, como es una peticion que puede devolver informacion de forma lenta,
  //le decimos que puede devolver una clase de forma future, se podria devolver un fallo
  // o la informacion de la base de datos
  Future<Either<Exception, List<Character>>> getAllCharacters();
}
