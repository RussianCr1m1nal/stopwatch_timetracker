import 'package:flutter_stopwatch_timetracking/data/shared_preferences_datasource.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Singleton(as: SharedPreferencesDataSource)
class SharedPreferencesDataSourceImpl extends SharedPreferencesDataSource {
  @override
  Future<int> getTimer(String key) async {
    final instance = await SharedPreferences.getInstance();

    return (instance.getInt(key)) ?? 0;
  }

  @override
  Future<void> saveTimer(String key, int timestamp) async {
    final instance = await SharedPreferences.getInstance();

    await instance.setInt(key, timestamp);
  }

  @override
  Future<void> saveTimerState(String key, bool isPaused) async {
    final instance = await SharedPreferences.getInstance();

    await instance.setBool(key, isPaused);
  }

  @override
  Future<bool> getTimerState(String key) async {
    final instance = await SharedPreferences.getInstance();

    return (instance.getBool(key)) ?? false;
  }
}
