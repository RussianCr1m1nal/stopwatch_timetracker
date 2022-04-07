import 'package:flutter_stopwatch_timetracking/data/datasource/db_datasource.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/timer_state.dart';
import 'package:flutter_stopwatch_timetracking/domain/mapper.dart';
import 'package:flutter_stopwatch_timetracking/domain/repository/timer_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: TimerRepository)
class TimerRepositoryImpl extends TimerRepository with Mapper {
  final DBDtaSource dataSource;

  TimerRepositoryImpl({required this.dataSource});

  @override
  Future<TimerState> getTimerState() async {
    return mapDbTimerStateToEntity(await dataSource.getTimerState());
  }

  @override
  Future<void> saveTimerState(TimerState state) async {
    dataSource.saveTimerState(mapEntityTimerStateToDb(state));
  }

}
