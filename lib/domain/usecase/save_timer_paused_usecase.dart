import 'package:dartz/dartz.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/failure.dart';
import 'package:flutter_stopwatch_timetracking/domain/repository/timer_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveTimerPausedUseCase {
  final TimerRepository repository;

  SaveTimerPausedUseCase({required this.repository});

  Future<Either<Failure, void>> call(bool isPaused) async {
    try {
      return Right(repository.savePaused(isPaused));
    } catch (exception) {
      return Left(Failure(message: exception.toString()));
    }
  }
}
