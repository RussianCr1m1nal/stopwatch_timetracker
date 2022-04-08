import 'package:dartz/dartz.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/entity.dart';
import 'package:flutter_stopwatch_timetracking/domain/repository/timer_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class WatchTimerLogUseCase {
  final TimerRepository repository;

  WatchTimerLogUseCase({required this.repository});

  Future<Either<Failure, Stream<List<TimerLog>>>> call() async {
    try {
      return Right(repository.watchTimerLogs());
    } catch (exception) {
      return Left(Failure(message: exception.toString()));
    }
  }
}
