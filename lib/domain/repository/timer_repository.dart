import 'package:flutter_stopwatch_timetracking/domain/entity/entity.dart';

abstract class TimerRepository {
  Future<void> saveTimerState(TimerState state);
  Future<TimerState> getTimerState();

  Future<void> saveTimerLog(TimerLog log);
  Stream<List<TimerLog>> watchTimerLogs();
}
