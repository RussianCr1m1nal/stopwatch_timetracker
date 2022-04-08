import 'package:flutter_stopwatch_timetracking/data/database/table/table.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class TimerLog {
  int id = 0;
  DateTime date;
  int eventIndex;
  ToOne<PauseReason> pauseReason = ToOne<PauseReason>();

  TimerLog({
    this.id = 0,
    required this.date,
    required this.eventIndex,
  });
}
