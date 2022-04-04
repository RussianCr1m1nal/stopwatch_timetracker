import 'package:dartz/dartz.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/failure.dart';
import 'package:flutter_stopwatch_timetracking/domain/repository/timer_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SavePauseReasonUseCase {
  final TimerRepository repository;

  SavePauseReasonUseCase({required this.repository});

  Future<Either<Failure, void>> call(int index) async {
    try {
      return Right(repository.savePauseReasonIndex(index));
    } catch (exception) {
      return Left(Failure(message: exception.toString()));
    }
  }
}
