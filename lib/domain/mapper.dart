import 'package:flutter_stopwatch_timetracking/application/enum/timer_event.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/entity.dart' as entity;
import 'package:flutter_stopwatch_timetracking/data/database/table/table.dart' as db;

mixin Mapper {
  entity.TimerState mapDbTimerStateToEntity(db.TimerState timerState) {
    return entity.TimerState(
      isPaused: timerState.isPaused,
      timeOnPause: timerState.timeOnPause,
      wrokTime: timerState.timeOnPause,
      timestamp: timerState.timestamp,
      pauseReason: mapDbPauseReasonToEntity(timerState.pauseReason.target),
    );
  }

  entity.PauseReason? mapDbPauseReasonToEntity(db.PauseReason? pauseReason) {
    if (pauseReason == null) {
      return null;
    }

    return entity.PauseReason(name: pauseReason.name, discription: pauseReason.discription, id: pauseReason.id);
  }

  entity.TimerLog mapDbTimerLogToEntity(db.TimerLog timerLog) {
    return entity.TimerLog(
      date: timerLog.date,
      event: TimerEvent.values[timerLog.eventIndex],
      id: timerLog.id,
      pauseReason: mapDbPauseReasonToEntity(timerLog.pauseReason.target),
    );
  }

  db.TimerState mapEntityTimerStateToDb(entity.TimerState timerState) {
    db.TimerState dbTimerState = db.TimerState(
      isPaused: timerState.isPaused,
      timeOnPause: timerState.timeOnPause,
      timestamp: timerState.timestamp,
      wrokTime: timerState.wrokTime,
    );

    dbTimerState.pauseReason.target = mapEntityPauseReasonToDb(timerState.pauseReason);

    return dbTimerState;
  }

  db.PauseReason? mapEntityPauseReasonToDb(entity.PauseReason? pauseReason) {
    if (pauseReason == null) {
      return null;
    }

    return db.PauseReason(name: pauseReason.name, discription: pauseReason.discription, id: pauseReason.id);
  }

  db.TimerLog mapEntityTimerLogToDb(entity.TimerLog timerLog) {
    db.TimerLog dbTimerLog = db.TimerLog(
      date: timerLog.date,
      eventIndex: timerLog.event.index,
      id: timerLog.id,
    );

    dbTimerLog.pauseReason.target = mapEntityPauseReasonToDb(timerLog.pauseReason);

    return dbTimerLog;
  }
}
