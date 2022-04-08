enum TimerEvent { start, pause, stop }

extension ParseToString on TimerEvent {
  String convertToString() {
    return toString().split('.').last;   
  }
}
