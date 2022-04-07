import 'dart:async';

import 'package:flutter_stopwatch_timetracking/data/datasource/api_datasource.dart';
import 'package:flutter_stopwatch_timetracking/data/datasource/db_datasource.dart';
import 'package:flutter_stopwatch_timetracking/domain/entity/pause_reason.dart';
import 'package:flutter_stopwatch_timetracking/domain/mapper.dart';
import 'package:flutter_stopwatch_timetracking/domain/repository/pause_reason_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@Singleton(as: PauseReasonRepository)
class PauseReasonRepositoryImpl extends PauseReasonRepository with Mapper {
  final DBDtaSource localDataSource;
  final ApiDataSource remoteDataSource;

  PauseReasonRepositoryImpl({required this.localDataSource, required this.remoteDataSource});

  final BehaviorSubject<List<PauseReason>> _reasonsSubject = BehaviorSubject<List<PauseReason>>.seeded([]);
  StreamSubscription? reasonsSubscription;

  @override
  Stream<List<PauseReason>> watchPauseReasons() {
    reasonsSubscription?.cancel();
    reasonsSubscription = localDataSource
        .watchPauseReaons()
        ?.map((reasons) => reasons.map((pauseReason) => mapDbPauseReasonToEntity(pauseReason)).toList())
        .listen((reasons) {
      List<PauseReason> reasonsNoNull = [];
      for (PauseReason? element in reasons) {
        if (element != null) {
          reasonsNoNull.add(element);
        }
      }
      _reasonsSubject.add(reasonsNoNull);
    });

    return _reasonsSubject.stream;
  }

  void dispose() {
    reasonsSubscription?.cancel();
    _reasonsSubject.close();
  }

  @override
  Future<void> updatePauseReasons() async {
    localDataSource.updatePauseReasons(await remoteDataSource.getPauseReasons());
  }
}
