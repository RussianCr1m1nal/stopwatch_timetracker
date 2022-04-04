import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_stopwatch_timetracking/application/enum/pause_reason.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/stopwatch.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/wrok_timer.dart';
import 'package:flutter_stopwatch_timetracking/domain/usecase/get_pause_reason_usecase.dart';
import 'package:flutter_stopwatch_timetracking/domain/usecase/get_time_on_pause_usecase.dart';
import 'package:flutter_stopwatch_timetracking/domain/usecase/get_timer_paused_usecase.dart';
import 'package:flutter_stopwatch_timetracking/domain/usecase/get_timer_timestamp_usecase.dart';
import 'package:flutter_stopwatch_timetracking/domain/usecase/get_work_time_usecase.dart';
import 'package:flutter_stopwatch_timetracking/domain/usecase/save_pause_reason_usecase.dart';
import 'package:flutter_stopwatch_timetracking/domain/usecase/save_time_on_pause_usecase.dart';
import 'package:flutter_stopwatch_timetracking/domain/usecase/save_timer_paused_usecase.dart';
import 'package:flutter_stopwatch_timetracking/domain/usecase/save_timer_timestamp_usecase.dart';
import 'package:flutter_stopwatch_timetracking/domain/usecase/save_work_time_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class HomeBloc {
  final GetTimerTimestampUseCase getTimerTimestampUseCase;
  final GetPauseReasonUseCase getPauseReasonUseCase;
  final GetTimeOnPauseUseCase getTimeOnPauseUseCase;
  final GetWorkTimeUseCase getWorkTimeUseCase;
  final GetTimerPausedUseCase getTimerPausedUseCase;

  final SaveTimerTimestampUseCase saveTimerTimestampUseCase;
  final SavePauseReasonUseCase savePauseReasonUseCase;
  final SaveTimeOnPauseUseCase saveTimeOnPauseUseCase;
  final SaveWorkTimeUseCase saveWorkTimeUseCase;
  final SaveTimerPausedUseCase saveTimerPausedUseCase;

  final scrollController = ScrollController();

  final currentTimer = Stopwatch();
  final workTimer = Stopwatch();
  final pauseTimer = Stopwatch();

  StreamSubscription? _currentTimerSubscription;
  StreamSubscription? _workTimerSubscription;
  StreamSubscription? _pauseTimerSubscription;

  final BehaviorSubject<WorkTimer> timerSubject =
      BehaviorSubject<WorkTimer>.seeded(WorkTimer(currentTime: 0, workTime: 0, pauseTime: 0));
  Stream<WorkTimer> get timerStream => timerSubject.stream;

  final BehaviorSubject<PauseReason?> pauseSubject = BehaviorSubject<PauseReason?>.seeded(null);
  Stream<PauseReason?> get pauseReasonStream => pauseSubject.stream;

  HomeBloc(
      {required this.getTimerTimestampUseCase,
      required this.getPauseReasonUseCase,
      required this.getTimeOnPauseUseCase,
      required this.getWorkTimeUseCase,
      required this.getTimerPausedUseCase,
      required this.saveTimerTimestampUseCase,
      required this.savePauseReasonUseCase,
      required this.saveTimeOnPauseUseCase,
      required this.saveWorkTimeUseCase,
      required this.saveTimerPausedUseCase}) {
    setTimers();
  }

  void setTimers() async {
    (await getTimerTimestampUseCase()).fold((failure) {
      print(failure.message);
    }, (timestamp) async {
      if (timestamp > 0) {
        DateTime before = DateTime.fromMillisecondsSinceEpoch(timestamp);
        DateTime now = DateTime.now();
        Duration timeDifference = now.difference(before);

        currentTimer.setPresetTimeInSeconds(timeDifference.inSeconds);
        currentTimer.start();

        timerSubject.add(timerSubject.value.copyWith(currentTime: currentTimer.time.value));

        (await getTimerPausedUseCase()).fold((failure) {
          print(failure.message);
        }, (isPaused) async {
          (await getTimeOnPauseUseCase()).fold((failure) {
            print(failure.message);
          }, (timeOnPause) {
            pauseTimer.setPresetTimeInSeconds(timeOnPause + (isPaused ? timeDifference.inSeconds : 0));
            timerSubject.add(timerSubject.value.copyWith(pauseTime: pauseTimer.time.value));
          });

          (await getWorkTimeUseCase()).fold((failure) {
            print(failure.message);
          }, (workTime) {
            workTimer.setPresetTimeInSeconds(workTime + (isPaused ? 0 : timeDifference.inSeconds));
            timerSubject.add(timerSubject.value.copyWith(workTime: workTimer.time.value));
          });

          if (isPaused) {
            pauseTimer.start();

            (await getPauseReasonUseCase()).fold((failure) {
              print(failure.message);
            }, (pauseReasonIndex) {
              if (pauseReasonIndex != -1) {
                pauseSubject.add(PauseReason.values[pauseReasonIndex]);
              }
            });
          } else {
            workTimer.start();
          }
        });
      }
    });

    _currentTimerSubscription?.cancel();
    _currentTimerSubscription = currentTimer.time.listen((currentTime) {
      timerSubject.add(timerSubject.value.copyWith(currentTime: currentTime));
    });

    _workTimerSubscription?.cancel();
    _workTimerSubscription = workTimer.time.listen((workTime) {
      timerSubject.add(timerSubject.value.copyWith(workTime: workTime));
    });

    _pauseTimerSubscription?.cancel();
    _pauseTimerSubscription = pauseTimer.time.listen((pauseTime) {
      timerSubject.add(timerSubject.value.copyWith(pauseTime: pauseTime));
    });
  }

  Future<void> saveTimers() async {
    await saveTimerTimestampUseCase(DateTime.now().millisecondsSinceEpoch);
    await savePauseReasonUseCase(pauseSubject.value == null ? -1 : pauseSubject.value!.index);
    await saveTimerPausedUseCase(pauseTimer.isRunning);
    await saveTimeOnPauseUseCase(pauseTimer.time.value);
    await saveWorkTimeUseCase(workTimer.time.value);
  }

  void start() async {
    currentTimer.clearPresetTime();
    currentTimer.reset();
    currentTimer.start();

    workTimer.start();
    pauseTimer.stop();

    pauseSubject.add(null);

    saveTimers();
  }

  void pause(PauseReason pauseReason) async {
    currentTimer.clearPresetTime();
    currentTimer.reset();
    currentTimer.start();

    workTimer.stop();
    pauseTimer.start();

    pauseSubject.add(pauseReason);

    saveTimers();
  }

  void stop() async {
    currentTimer.reset();

    workTimer.reset();
    pauseTimer.reset();

    workTimer.clearPresetTime();
    pauseTimer.clearPresetTime();

    await saveTimerTimestampUseCase(0);
    await savePauseReasonUseCase(-1);
    await saveTimerPausedUseCase(false);
    await saveTimeOnPauseUseCase(0);
    await saveWorkTimeUseCase(0);
  }

  void dispose() async {
    await saveTimers();

    _currentTimerSubscription?.cancel();
    _workTimerSubscription?.cancel();
    _pauseTimerSubscription?.cancel();

    currentTimer.dispose();
    workTimer.dispose();
    pauseTimer.dispose();
    scrollController.dispose();
  }
}
