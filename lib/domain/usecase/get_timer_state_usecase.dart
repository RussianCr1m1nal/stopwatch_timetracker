import 'package:dartz/dartz.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/entity.dart';
import 'package:flutter_stopwatch_timetracking/domain/repository/timer_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTimerStateUseCase {
  final TimerRepository repository;

  GetTimerStateUseCase({required this.repository});

  Future<Either<Failure, TimerState>> call() async {
    try {
      return Right(await repository.getTimerState());
    } catch (exception) {
      return Left(Failure(message: exception.toString()));
    }
  }
}
