import 'package:dartz/dartz.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/failure.dart';
import 'package:flutter_stopwatch_timetracking/domain/repository/timer_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTimerPausedUseCase {
  final TimerRepository repository;

  GetTimerPausedUseCase({required this.repository});

  Future<Either<Failure, bool>> call() async {
    try {
      return Right(await repository.getPaused());
    } catch (exception) {
      return Left(Failure(message: exception.toString()));
    }
  }
}
