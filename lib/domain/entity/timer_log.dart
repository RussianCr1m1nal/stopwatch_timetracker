import 'package:flutter_stopwatch_timetracking/application/enum/timer_event.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/entity.dart';

class TimerLog {
  int id;
  DateTime date;
  TimerEvent event;
  PauseReason? pauseReason;

  TimerLog({
    this.id = 0,
    required this.date,
    required this.event,
    this.pauseReason,
  });
}
