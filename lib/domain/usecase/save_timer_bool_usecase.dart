
import 'package:dartz/dartz.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/failure.dart';
import 'package:flutter_stopwatch_timetracking/domain/repository/shared_preferences_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveTimerDataBoolUseCase {
  final SharedPreferencesRepository repository;

  SaveTimerDataBoolUseCase({required this.repository});

  Future<Either<Failure, void>> call(String key, bool isPaused) async {
    try {
      return Right(repository.saveTimerState(key, isPaused));
    } catch (exception) {
      return Left(Failure(message: exception.toString()));
    }
  }
}