import 'package:flutter_stopwatch_timetracking/data/shared_preferences_datasource.dart';
import 'package:flutter_stopwatch_timetracking/domain/repository/timer_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: TimerRepository)
class TimerRepositoryImpl extends TimerRepository {
  final SharedPreferencesDataSource dataSource;

  final _timestampKey = 'closeDateTimestamp';
  final _pauseReasonKey = 'pauseReasonIndex';
  final _isPausedKey = 'isPaused';
  final _timeOnPauseKey = 'timeOnPause';
  final _workTimeKey = 'workTime';

  TimerRepositoryImpl({required this.dataSource});

  @override
  Future<int> getPauseReasonIndex() async {
    return await dataSource.getIntValue(_pauseReasonKey);
  }

  @override
  Future<bool> getPaused() async {
    return await dataSource.getBoolValue(_isPausedKey);
  }

  @override
  Future<int> getTimeOnPause() async {
    return await dataSource.getIntValue(_timeOnPauseKey);
  }

  @override
  Future<int> getTimerTimestamp() async {
    return await dataSource.getIntValue(_timestampKey);
  }

  @override
  Future<int> getWorkTime() async {
    return await dataSource.getIntValue(_workTimeKey);
  }

  @override
  Future<void> savePauseReasonIndex(int index) async {
    await dataSource.saveIntValue(_pauseReasonKey, index);
  }

  @override
  Future<void> savePaused(bool isPaused) async {
    await dataSource.saveBoolValue(_isPausedKey, isPaused);
  }

  @override
  Future<void> saveTimeOnPause(int timeOnPause) async {
    await dataSource.saveIntValue(_timeOnPauseKey, timeOnPause);
  }

  @override
  Future<void> saveTimerTimestamp(int timestamp) async {
    await dataSource.saveIntValue(_timestampKey, timestamp);
  }

  @override
  Future<void> saveWorkTime(int workTime) async {
    await dataSource.saveIntValue(_workTimeKey, workTime);
  }
}
