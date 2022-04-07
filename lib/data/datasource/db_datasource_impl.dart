import 'package:flutter_stopwatch_timetracking/data/database/object_box.dart';
import 'package:flutter_stopwatch_timetracking/data/database/table/pause_reason.dart';
import 'package:flutter_stopwatch_timetracking/data/database/table/timer_state.dart';
import 'package:flutter_stopwatch_timetracking/data/datasource/db_datasource.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: DBDtaSource)
class DBDataSourceImpl extends DBDtaSource {
  final ObjectBoxDb dataBase;

  DBDataSourceImpl({required this.dataBase});

  @override
  Future<TimerState> getTimerState() async {
    return dataBase.getTimerState();
  }

  @override
  Future<void> saveTimerState(TimerState state) async {
    dataBase.saveTimerState(state);
  }

  @override
  Stream<List<PauseReason>>? watchPauseReaons() {
    return dataBase.watchPauseReasons();
  }

  @override
  Future<void> updatePauseReasons(List<Map<String, dynamic>> reasonsList) async {

    for (Map<String, dynamic> element in reasonsList) {
      dataBase.updatePauseReasonFromMap(element);
    }
  }
}
