import 'dart:async';

import 'package:rxdart/rxdart.dart';

class Stopwatch {
  Duration? _timeDuration;
  Timer? _timer;
  int _presetTime = 0;
  bool isRunning = false;

  final BehaviorSubject<int> _timerSubject = BehaviorSubject<int>.seeded(0);
  ValueStream<int> get time => _timerSubject.stream;

  void start() {
    isRunning = true;
    _timeDuration = Duration(seconds: _presetTime);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _timeDuration = Duration(seconds: _timeDuration!.inSeconds + 1);
      _timerSubject.add(_timeDuration!.inSeconds);
    });
  }

  void stop() {
    _presetTime = _timeDuration == null ? 0 : _timeDuration!.inSeconds;
    isRunning = false;
    _timer?.cancel();
  }

  void reset() {
    isRunning = false;
    _timeDuration = Duration(seconds: _presetTime);
    _timer?.cancel();
    _timerSubject.add(0);
  }

  void setPresetTimeInSeconds(int seconds) {
    _presetTime = seconds;
    _timerSubject.add(_presetTime);
  }

  void clearPresetTime() {
    _presetTime = 0;
  }

  void dispose() {
    _timerSubject.close();
  }

  static String displayTime(int seconds) {
    String twoDigits(int number) => number.toString().padLeft(2, '0');

    return '${twoDigits(seconds ~/ 60 ~/ 60)}:${twoDigits(seconds ~/ 60 % 60)}:${twoDigits(seconds % 60)}';
  }
}
