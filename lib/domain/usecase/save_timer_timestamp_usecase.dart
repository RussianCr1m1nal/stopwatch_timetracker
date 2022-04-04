import 'package:dartz/dartz.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/failure.dart';
import 'package:flutter_stopwatch_timetracking/domain/repository/timer_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveTimerTimestampUseCase {
  final TimerRepository repository;

  SaveTimerTimestampUseCase({required this.repository});

  Future<Either<Failure, void>> call(int timestamp) async {
    try {
      return Right(repository.saveTimerTimestamp(timestamp));
    } catch (exception) {
      return Left(Failure(message: exception.toString()));
    }
  }
}
