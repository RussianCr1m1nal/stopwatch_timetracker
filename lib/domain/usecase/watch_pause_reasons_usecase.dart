import 'package:dartz/dartz.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/entity.dart';
import 'package:flutter_stopwatch_timetracking/domain/repository/pause_reason_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class WatchPauseReasonsUseCase {
  final PauseReasonRepository repository;

  WatchPauseReasonsUseCase({required this.repository});

  Future<Either<Failure, Stream<List<PauseReason>>>> call() async {
    try {
      return Right(repository.watchPauseReasons());
    } catch (exception) {
      return Left(Failure(message: exception.toString()));
    }
  }
}
