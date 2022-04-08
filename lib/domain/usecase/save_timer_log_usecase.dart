import 'package:dartz/dartz.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/entity.dart';
import 'package:flutter_stopwatch_timetracking/domain/repository/timer_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveTimerLogUseCase {
  final TimerRepository repository;

  SaveTimerLogUseCase({required this.repository});

  Future<Either<Failure, void>> call(TimerLog log) async {
    try {
      return Right(await repository.saveTimerLog(log));
    } catch (exception) {
      return Left(Failure(message: exception.toString()));
    }
  }
}
