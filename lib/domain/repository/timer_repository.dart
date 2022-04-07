import 'package:flutter_stopwatch_timetracking/domain/entity/timer_state.dart';

abstract class TimerRepository {
  Future<void> saveTimerState(TimerState state);
  Future<TimerState> getTimerState();
}
