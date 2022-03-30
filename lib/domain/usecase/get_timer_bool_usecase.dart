import 'package:dartz/dartz.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/failure.dart';
import 'package:flutter_stopwatch_timetracking/domain/repository/shared_preferences_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTimerDataBoolUseCase {
  final SharedPreferencesRepository repository;

  GetTimerDataBoolUseCase({required this.repository});

  Future<Either<Failure, bool>> call(String key) async {
    try {
      return Right(await repository.getTimerState(key));
    } catch (exception) {
      return Left(Failure(message: exception.toString()));
    }
  }
}
