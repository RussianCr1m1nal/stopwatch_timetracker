
import 'package:flutter_stopwatch_timetracking/data/database/table/table.dart';

abstract class DBDtaSource {
  Future<void> saveTimerState(TimerState state);
  Future<TimerState> getTimerState();
  Stream<List<PauseReason>>? watchPauseReaons();
  Future<void> updatePauseReasons(List<Map<String, dynamic>> reasonsList);

  Future<void> saveTimerLog(TimerLog log);
  Stream<List<TimerLog>>? watchTimerLogs();
}