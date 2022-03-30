abstract class SharedPreferencesDataSource {
  Future<int> getTimer(String key);
  Future<bool> getTimerState(String key);
  Future<void> saveTimer(String key, int timestamp);
  Future<void> saveTimerState(String key, bool isPaused);
}
