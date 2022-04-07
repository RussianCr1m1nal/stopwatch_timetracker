import 'package:dartz/dartz.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/entity.dart';
import 'package:flutter_stopwatch_timetracking/domain/repository/pause_reason_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdatePauseReasonsUseCase {
  final PauseReasonRepository repository;

  UpdatePauseReasonsUseCase({required this.repository});

  Future<Either<Failure, void>> call() async {
    try {
      return Right(await repository.updatePauseReasons());
    } catch (exception) {
      return Left(Failure(message: exception.toString()));
    }
  }
}
