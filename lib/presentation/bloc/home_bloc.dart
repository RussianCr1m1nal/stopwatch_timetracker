import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/entity.dart';
import 'package:flutter_stopwatch_timetracking/domain/usecase/get_timer_state_usecase.dart';
import 'package:flutter_stopwatch_timetracking/domain/usecase/save_timer_state_usecase.dart';
import 'package:flutter_stopwatch_timetracking/domain/usecase/update_pause_reasons_usecase.dart';
import 'package:flutter_stopwatch_timetracking/domain/usecase/watch_pause_reasons_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class HomeBloc {
  final SaveTimerStateUseCase saveTimerStateUseCase;
  final GetTimerStateUseCase getTimerStateUseCase;
  final WatchPauseReasonsUseCase watchPauseReasonsUseCase;
  final UpdatePauseReasonsUseCase updatePauseReasonsUseCase;

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

  final BehaviorSubject<List<PauseReason>> pauseListSubject = BehaviorSubject<List<PauseReason>>.seeded([]);
  Stream<List<PauseReason>> get pauseListStream => pauseListSubject.stream;
  StreamSubscription? _reasonsSubscription;

  HomeBloc({
    required this.saveTimerStateUseCase,
    required this.getTimerStateUseCase,
    required this.watchPauseReasonsUseCase,
    required this.updatePauseReasonsUseCase,
  }) {
    _watchPauseReasons();
    _setTimers();
  }

  void _setTimers() async {
    (await getTimerStateUseCase()).fold((failure) {
      print(failure.message);
    }, (timerState) {
      if (timerState.timestamp > 0) {
        DateTime before = DateTime.fromMillisecondsSinceEpoch(timerState.timestamp);
        DateTime now = DateTime.now();
        Duration timeDifference = now.difference(before);

        currentTimer.setPresetTimeInSeconds(timeDifference.inSeconds);
        currentTimer.start();

        timerSubject.add(timerSubject.value.copyWith(currentTime: currentTimer.time.value));

        pauseTimer
            .setPresetTimeInSeconds(timerState.timeOnPause + (timerState.isPaused ? timeDifference.inSeconds : 0));
        timerSubject.add(timerSubject.value.copyWith(pauseTime: pauseTimer.time.value));

        workTimer.setPresetTimeInSeconds(timerState.wrokTime + (timerState.isPaused ? 0 : timeDifference.inSeconds));
        timerSubject.add(timerSubject.value.copyWith(workTime: workTimer.time.value));

        if (timerState.isPaused) {
          pauseTimer.start();
          pauseSubject.add(timerState.pauseReason);
        } else {
          workTimer.start();
        }
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

  Future<void> _saveTimers() async {
    await saveTimerStateUseCase(TimerState(
      isPaused: pauseTimer.isRunning,
      timeOnPause: pauseTimer.time.value,
      wrokTime: workTimer.time.value,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      pauseReason: pauseSubject.hasValue ? pauseSubject.value : null
    ));
  }

  _watchPauseReasons() async {
    await updatePauseReasonsUseCase();

    (await watchPauseReasonsUseCase()).fold((failure) {
      print(failure.message);
    }, (reasonsStream) {
      _reasonsSubscription?.cancel();
      _reasonsSubscription = reasonsStream.listen((reasonsList) {
        pauseListSubject.add(reasonsList);
      });
    });

  }

  void start() async {
    currentTimer.clearPresetTime();
    currentTimer.reset();
    currentTimer.start();

    workTimer.start();
    pauseTimer.stop();

    pauseSubject.add(null);

    _saveTimers();
  }

  void pause(PauseReason pauseReason) async {
    currentTimer.clearPresetTime();
    currentTimer.reset();
    currentTimer.start();

    workTimer.stop();
    pauseTimer.start();

    pauseSubject.add(pauseReason);

    _saveTimers();
  }

  void stop() async {
    currentTimer.reset();

    workTimer.reset();
    pauseTimer.reset();

    workTimer.clearPresetTime();
    pauseTimer.clearPresetTime();

    await saveTimerStateUseCase(TimerState(
      timestamp: 0,
      timeOnPause: 0,
      wrokTime: 0,
      isPaused: false,
      pauseReason: null,
    ));
  }

  void dispose() async {
    await _saveTimers();

    _currentTimerSubscription?.cancel();
    _workTimerSubscription?.cancel();
    _pauseTimerSubscription?.cancel();

    currentTimer.dispose();
    workTimer.dispose();
    pauseTimer.dispose();
    scrollController.dispose();
  }
}
