import 'package:flutter_stopwatch_timetracking/data/database/table/pause_reason.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class TimerState {
  @Id(assignable: true)
  int id;
  int timestamp;
  int timeOnPause;
  int wrokTime;
  bool isPaused;
  ToOne<PauseReason> pauseReason = ToOne<PauseReason>();

  TimerState(
      {this.id = 0,
      required this.timeOnPause,
      required this.timestamp,
      required this.wrokTime,
      required this.isPaused});
}
