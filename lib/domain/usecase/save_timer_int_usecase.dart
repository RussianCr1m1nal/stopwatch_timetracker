import 'package:dartz/dartz.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/failure.dart';
import 'package:flutter_stopwatch_timetracking/domain/repository/shared_preferences_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveTimerDataInt {
  final SharedPreferencesRepository repository;

  SaveTimerDataInt({required this.repository});

  Future<Either<Failure, void>> call(String key, int timestamp) async {
    try {
      return Right(repository.saveTimer(key, timestamp));
    } catch (exception) {
      return Left(Failure(message: exception.toString()));
    }
  }
}
