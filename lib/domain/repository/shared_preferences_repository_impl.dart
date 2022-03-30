import 'package:flutter_stopwatch_timetracking/data/shared_preferences_datasource.dart';
import 'package:flutter_stopwatch_timetracking/domain/repository/shared_preferences_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: SharedPreferencesRepository)
class SharedPreferencesRepositoryImpl extends SharedPreferencesRepository {

  final SharedPreferencesDataSource dataSource;

  SharedPreferencesRepositoryImpl({required this.dataSource});

  @override
  Future<int> getTimer(String key) async {
    return await dataSource.getTimer(key);
  }

  @override
  Future<void> saveTimer(String key, int timestamp) async {
    dataSource.saveTimer(key, timestamp);
  }

  @override
  Future<void> saveTimerState(String key, bool isPaused) async {
    dataSource.saveTimerState(key, isPaused);
  }

  @override
  Future<bool> getTimerState(String key) async {
    return await dataSource.getTimerState(key);
  }
}
