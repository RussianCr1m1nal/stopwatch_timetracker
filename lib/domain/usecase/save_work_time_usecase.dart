import 'package:dartz/dartz.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/failure.dart';
import 'package:flutter_stopwatch_timetracking/domain/repository/timer_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveWorkTimeUseCase {
  final TimerRepository repository;

  SaveWorkTimeUseCase({required this.repository});

  Future<Either<Failure, void>> call(int workTime) async {
    try {
      return Right(repository.saveWorkTime(workTime));
    } catch (exception) {
      return Left(Failure(message: exception.toString()));
    }
  }
}
