import 'package:dartz/dartz.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/failure.dart';
import 'package:flutter_stopwatch_timetracking/domain/repository/timer_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPauseReasonUseCase {
  final TimerRepository repository;

  GetPauseReasonUseCase({required this.repository});

  Future<Either<Failure, int>> call() async {
    try {
      return Right(await repository.getPauseReasonIndex());
    } catch (exception) {
      return Left(Failure(message: exception.toString()));
    }
  }
}
