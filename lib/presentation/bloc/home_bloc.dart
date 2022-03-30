import 'package:flutter/cupertino.dart';
import 'package:flutter_stopwatch_timetracking/application/enum/pause_reason.dart';
import 'package:flutter_stopwatch_timetracking/domain/usecase/get_timer_bool_usecase.dart';
import 'package:flutter_stopwatch_timetracking/domain/usecase/get_timer_int_usecase.dart';
import 'package:flutter_stopwatch_timetracking/domain/usecase/save_timer_bool_usecase.dart';
import 'package:flutter_stopwatch_timetracking/domain/usecase/save_timer_int_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

@injectable
class HomeBloc {
  final SaveTimerDataInt saveTimerDataIntUseCase;
  final GetTimerDataIntUseCase getTimerDataIntUseCase;
  final SaveTimerDataBoolUseCase saveTimerDataBoolUseCase;
  final GetTimerDataBoolUseCase getTimerDataBoolUseCase;

  final scrollController = ScrollController();

  final StopWatchTimer currentTimer = StopWatchTimer();
  final StopWatchTimer workTimer = StopWatchTimer();
  final StopWatchTimer pauseTimer = StopWatchTimer();

  Stream<int> get currentTimerStream => currentTimer.rawTime;
  Stream<int> get workTimerStream => workTimer.rawTime;
  Stream<int> get pauseTimerStream => pauseTimer.rawTime;

  final BehaviorSubject<PauseReason?> pauseSubject = BehaviorSubject<PauseReason?>.seeded(null);
  Stream<PauseReason?> get pauseReasonStream => pauseSubject.stream;

  HomeBloc(
      {required this.getTimerDataIntUseCase,
      required this.saveTimerDataIntUseCase,
      required this.getTimerDataBoolUseCase,
      required this.saveTimerDataBoolUseCase}) {
    setTimers();
  }

  void setTimers() async {
    (await getTimerDataIntUseCase('closeDateTimestamp')).fold((failure) {
      print(failure.message);
    }, (timestamp) async {
      if (timestamp > 0) {
        DateTime before = DateTime.fromMillisecondsSinceEpoch(timestamp);
        DateTime now = DateTime.now();
        Duration timeDifference = now.difference(before);

        currentTimer.setPresetSecondTime(timeDifference.inSeconds);
        currentTimer.onExecute.add(StopWatchExecute.start);

        (await getTimerDataBoolUseCase('isPaused')).fold((failure) {
          print(failure.message);
        }, (isPaused) async {
          (await getTimerDataIntUseCase('timeOnPause')).fold((failure) {
            print(failure.message);
          }, (timeOnPause) {
            pauseTimer.setPresetSecondTime(timeOnPause + (isPaused ? timeDifference.inSeconds : 0));
          });

          (await getTimerDataIntUseCase('workTime')).fold((failure) {
            print(failure.message);
          }, (workTime) {
            workTimer.setPresetSecondTime(workTime + (isPaused ? 0 : timeDifference.inSeconds));
          });

          if (isPaused) {
            pauseTimer.onExecute.add(StopWatchExecute.start);

            (await getTimerDataIntUseCase('pauseReasonIndex')).fold((failure) {
              print(failure.message);
            }, (pauseReasonIndex) {
              if (pauseReasonIndex != -1) {
                pauseSubject.add(PauseReason.values[pauseReasonIndex]);
              }
            });
          } else {
            workTimer.onExecute.add(StopWatchExecute.start);
          }
        });
      }
    });
  }

  Future<void> saveTimers() async {
    await saveTimerDataIntUseCase('closeDateTimestamp', DateTime.now().millisecondsSinceEpoch);
    await saveTimerDataIntUseCase('pauseReasonIndex', pauseSubject.value == null ? -1 : pauseSubject.value!.index);
    await saveTimerDataBoolUseCase('isPaused', pauseTimer.isRunning);
    await saveTimerDataIntUseCase('timeOnPause', pauseTimer.rawTime.value ~/ 1000);
    await saveTimerDataIntUseCase('workTime', workTimer.rawTime.value ~/ 1000);
  }

  void start() async {
    currentTimer.clearPresetTime();
    currentTimer.onExecute.add(StopWatchExecute.reset);
    currentTimer.onExecute.add(StopWatchExecute.start);

    workTimer.onExecute.add(StopWatchExecute.start);
    pauseTimer.onExecute.add(StopWatchExecute.stop);

    pauseSubject.add(null);

    saveTimers();
  }

  void pause(PauseReason pauseReason) async {
    currentTimer.clearPresetTime();
    currentTimer.onExecute.add(StopWatchExecute.reset);
    currentTimer.onExecute.add(StopWatchExecute.start);

    pauseTimer.onExecute.add(StopWatchExecute.start);
    workTimer.onExecute.add(StopWatchExecute.stop);

    pauseSubject.add(pauseReason);

    saveTimers();
  }

  void stop() async {
    currentTimer.onExecute.add(StopWatchExecute.reset);
    workTimer.onExecute.add(StopWatchExecute.reset);
    pauseTimer.onExecute.add(StopWatchExecute.reset);

    pauseTimer.clearPresetTime();
    workTimer.clearPresetTime();

    await saveTimerDataIntUseCase('closeDateTimestamp', 0);
    await saveTimerDataBoolUseCase('isPaused', false);
    await saveTimerDataIntUseCase('timeOnPause', 0);
    await saveTimerDataIntUseCase('workTime', 0);
    await saveTimerDataIntUseCase('pauseReasonIndex', -1);
  }

  void dispose() async {
    await saveTimers();

    scrollController.dispose();
    currentTimer.dispose();
    workTimer.dispose();
    pauseTimer.dispose();
  }
}
