import 'dart:async';

import 'package:flutter_stopwatch_timetracking/data/datasource/db_datasource.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/timer_log.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/timer_state.dart';
import 'package:flutter_stopwatch_timetracking/domain/mapper.dart';
import 'package:flutter_stopwatch_timetracking/domain/repository/timer_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@Singleton(as: TimerRepository)
class TimerRepositoryImpl extends TimerRepository with Mapper {
  final DBDtaSource dataSource;

  final BehaviorSubject<List<TimerLog>> _logSubject = BehaviorSubject<List<TimerLog>>.seeded([]);
  StreamSubscription? _logSubscription;

  TimerRepositoryImpl({required this.dataSource});

  @override
  Future<TimerState> getTimerState() async {
    return mapDbTimerStateToEntity(await dataSource.getTimerState());
  }

  @override
  Future<void> saveTimerState(TimerState state) async {
    dataSource.saveTimerState(mapEntityTimerStateToDb(state));
  }

  @override
  Future<void> saveTimerLog(TimerLog log) async {
    dataSource.saveTimerLog(mapEntityTimerLogToDb(log));
  }

  @override
  Stream<List<TimerLog>> watchTimerLogs() {
    _logSubscription?.cancel();
    _logSubscription = dataSource
        .watchTimerLogs()
        ?.map((logs) => logs.map((log) => mapDbTimerLogToEntity(log)).toList())
        .listen((logs) {
      _logSubject.add(logs);
    });

    return _logSubject.stream;
  }

  void dispose() {
    _logSubscription?.cancel();
    _logSubject.close();
  }
}
