import 'package:dartz/dartz.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/failure.dart';
import 'package:flutter_stopwatch_timetracking/domain/repository/shared_preferences_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTimerDataIntUseCase {
  final SharedPreferencesRepository repository;

  GetTimerDataIntUseCase({required this.repository});

  Future<Either<Failure, int>> call(String key) async {
    try {
      return Right(await repository.getTimer(key));
    } catch (exception) {
      return Left(Failure(message: exception.toString()));
    }
  }
}
