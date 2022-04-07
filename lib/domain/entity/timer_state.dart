import 'package:flutter_stopwatch_timetracking/domain/entity/pause_reason.dart';

class TimerState {
  int timestamp;
  int timeOnPause;
  int wrokTime;
  bool isPaused;
  PauseReason? pauseReason;

  TimerState(
      {required this.timestamp,
      required this.timeOnPause,
      required this.wrokTime,
      required this.isPaused,
      this.pauseReason,});
}
