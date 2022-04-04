import 'package:dartz/dartz.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/failure.dart';
import 'package:flutter_stopwatch_timetracking/domain/repository/timer_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveTimeOnPauseUseCase {
  final TimerRepository repository;

  SaveTimeOnPauseUseCase({required this.repository});

  Future<Either<Failure, void>> call(int timeOnPause) async {
    try {
      return Right(repository.saveTimeOnPause(timeOnPause));
    } catch (exception) {
      return Left(Failure(message: exception.toString()));
    }
  }
}
