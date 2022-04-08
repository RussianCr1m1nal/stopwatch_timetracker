import 'dart:io';

import 'package:flutter_stopwatch_timetracking/data/database/table/table.dart';
import 'package:flutter_stopwatch_timetracking/objectbox.g.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

Store? dbStore;

Future<void> initStoreForDataBase() async {
  final Directory directory = await getApplicationDocumentsDirectory();
  dbStore = await openStore(directory: path.join(directory.path, 'objectboxDB'));
}

@Singleton()
class ObjectBoxDb {
  Store? store;
  Box<TimerState>? timerStateBox;
  Box<PauseReason>? pauseReasonBox;
  Box<TimerLog>? timerLogBox;

  ObjectBoxDb() {
    store = dbStore;
    timerStateBox = store!.box<TimerState>();
    pauseReasonBox = store!.box<PauseReason>();
    timerLogBox = store!.box<TimerLog>();
  }

  void saveTimerState(TimerState state) async {
    List<TimerState>? timerStateList = timerStateBox?.getAll();
    TimerState? timerState = timerStateList!.isEmpty ? null : timerStateList.last;

    if (timerState == null) {
      timerStateBox?.put(state);
    } else {
      timerState.isPaused = state.isPaused;
      timerState.pauseReason = state.pauseReason;
      timerState.timeOnPause = state.timeOnPause;
      timerState.timestamp = state.timestamp;
      timerState.wrokTime = state.wrokTime;
      timerStateBox?.put(timerState);
    }
  }

  Future<TimerState> getTimerState() async {
    List<TimerState>? timerStateList = timerStateBox?.getAll();
    TimerState? timerState = timerStateList!.isEmpty ? null : timerStateList.last;

    return timerState ?? TimerState(wrokTime: 0, timestamp: 0, isPaused: false, timeOnPause: 0, id: 1);
  }

  Stream<List<PauseReason>>? watchPauseReasons() {
    return pauseReasonBox?.query().watch(triggerImmediately: true).map((query) {
      return query.find();
    });
  }

  void updatePauseReasonFromMap(Map<String, dynamic> map) {
    PauseReason? reason = pauseReasonBox?.get(map['id']);
    reason ??= PauseReason(name: map['name'], discription: map['discription'], id: map['id']);

    pauseReasonBox?.put(reason);
  }

  void saveTimerLog(TimerLog log) {
    timerLogBox?.put(log);
  }

  Stream<List<TimerLog>>? watchTimerLogs() {    
    final queryBuilder = timerLogBox?.query();
    queryBuilder?.order(TimerLog_.date, flags: Order.descending);

    return queryBuilder?.watch(triggerImmediately: true).map((query) {
      return query.find();
    });
  }
}
