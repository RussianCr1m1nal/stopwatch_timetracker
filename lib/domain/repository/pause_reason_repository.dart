
import 'package:flutter_stopwatch_timetracking/domain/entity/entity.dart';

abstract class PauseReasonRepository {
  Stream<List<PauseReason>> watchPauseReasons();
  Future<void> updatePauseReasons();
}