abstract class SharedPreferencesDataSource {
  Future<int> getIntValue(String key);
  Future<bool> getBoolValue(String key);
  Future<void> saveIntValue(String key, int value);
  Future<void> saveBoolValue(String key, bool value);
}
