abstract class TimerRepository {
  Future<int> getTimerTimestamp();
  Future<int> getPauseReasonIndex();
  Future<int> getTimeOnPause();
  Future<int> getWorkTime();
  Future<bool> getPaused();

  Future<void> saveTimerTimestamp(int timestamp);
  Future<void> savePauseReasonIndex(int index);
  Future<void> saveTimeOnPause(int timeOnPause);
  Future<void> saveWorkTime(int workTime);
  Future<void> savePaused(bool isPaused);
}
