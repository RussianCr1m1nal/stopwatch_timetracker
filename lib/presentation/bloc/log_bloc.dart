import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/entity.dart';
import 'package:flutter_stopwatch_timetracking/domain/usecase/watch_timer_log_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class LogBloc {
  final WatchTimerLogUseCase watchTimerLogUseCase;

  final ScrollController scrollController = ScrollController();

  final BehaviorSubject<List<TimerLog>> logSubject = BehaviorSubject<List<TimerLog>>.seeded([]);
  Stream<List<TimerLog>> get logStream => logSubject.stream;
  StreamSubscription? _logsSubscription;

  LogBloc({required this.watchTimerLogUseCase}) {
    _watchLogs();
  }

  _watchLogs() async {
    (await watchTimerLogUseCase()).fold((failure) {
      print(failure.message);
    }, (stream) {
      _logsSubscription?.cancel();
      _logsSubscription = stream.listen((logsList) {
        logSubject.add(logsList);
      });
    });
  }

  void dispose() {
    _logsSubscription?.cancel();
    scrollController.dispose();
    logSubject.close();
  }
}
