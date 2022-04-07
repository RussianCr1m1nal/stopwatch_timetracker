import 'package:dartz/dartz.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/entity.dart';
import 'package:flutter_stopwatch_timetracking/domain/repository/timer_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveTimerStateUseCase {
  final TimerRepository repository;

  SaveTimerStateUseCase({required this.repository});

  Future<Either<Failure, void>> call(TimerState state) async {
    try {
      return Right(await repository.saveTimerState(state));
    } catch (exception) {
      return Left(Failure(message: exception.toString()));
    }
  }
}
