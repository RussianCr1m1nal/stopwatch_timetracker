import 'package:flutter_stopwatch_timetracking/data/shared_preferences_datasource.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Singleton(as: SharedPreferencesDataSource)
class SharedPreferencesDataSourceImpl extends SharedPreferencesDataSource {
  @override
  Future<int> getIntValue(String key) async {
    final instance = await SharedPreferences.getInstance();

    return (instance.getInt(key)) ?? 0;
  }

  @override
  Future<void> saveIntValue(String key, int value) async {
    final instance = await SharedPreferences.getInstance();

    await instance.setInt(key, value);
  }

  @override
  Future<void> saveBoolValue(String key, bool value) async {
    final instance = await SharedPreferences.getInstance();

    await instance.setBool(key, value);
  }

  @override
  Future<bool> getBoolValue(String key) async {
    final instance = await SharedPreferences.getInstance();

    return (instance.getBool(key)) ?? false;
  }
}
