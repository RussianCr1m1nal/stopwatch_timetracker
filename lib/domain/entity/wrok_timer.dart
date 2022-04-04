class WorkTimer {
  final int currentTime;
  final int pauseTime;
  final int workTime;

  WorkTimer({this.currentTime = 0, this.pauseTime = 0, this.workTime = 0});

  WorkTimer copyWith({int? currentTime, int? pauseTime, int? workTime}) {
    return WorkTimer(
        currentTime: currentTime ?? this.currentTime,
        pauseTime: pauseTime ?? this.pauseTime,
        workTime: workTime ?? this.workTime);
  }
}
