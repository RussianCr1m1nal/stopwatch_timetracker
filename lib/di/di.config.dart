// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/database/object_box.dart' as _i5;
import '../data/datasource/api_datasource.dart' as _i3;
import '../data/datasource/api_datasource_impl.dart' as _i4;
import '../data/datasource/db_datasource.dart' as _i6;
import '../data/datasource/db_datasource_impl.dart' as _i7;
import '../domain/repository/pause_reason_repository.dart' as _i8;
import '../domain/repository/pause_reason_repository_impl.dart' as _i9;
import '../domain/repository/timer_repository.dart' as _i10;
import '../domain/repository/timer_repository_impl.dart' as _i11;
import '../domain/usecase/get_timer_state_usecase.dart' as _i15;
import '../domain/usecase/save_timer_log_usecase.dart' as _i17;
import '../domain/usecase/save_timer_state_usecase.dart' as _i18;
import '../domain/usecase/update_pause_reasons_usecase.dart' as _i12;
import '../domain/usecase/watch_pause_reasons_usecase.dart' as _i13;
import '../domain/usecase/watch_timer_log_usecase.dart' as _i14;
import '../presentation/bloc/home_bloc.dart' as _i19;
import '../presentation/bloc/log_bloc.dart'
    as _i16; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.ApiDataSource>(_i4.ApiDataSourceImpl());
  gh.singleton<_i5.ObjectBoxDb>(_i5.ObjectBoxDb());
  gh.singleton<_i6.DBDtaSource>(
      _i7.DBDataSourceImpl(dataBase: get<_i5.ObjectBoxDb>()));
  gh.singleton<_i8.PauseReasonRepository>(_i9.PauseReasonRepositoryImpl(
      localDataSource: get<_i6.DBDtaSource>(),
      remoteDataSource: get<_i3.ApiDataSource>()));
  gh.singleton<_i10.TimerRepository>(
      _i11.TimerRepositoryImpl(dataSource: get<_i6.DBDtaSource>()));
  gh.factory<_i12.UpdatePauseReasonsUseCase>(() =>
      _i12.UpdatePauseReasonsUseCase(
          repository: get<_i8.PauseReasonRepository>()));
  gh.factory<_i13.WatchPauseReasonsUseCase>(() => _i13.WatchPauseReasonsUseCase(
      repository: get<_i8.PauseReasonRepository>()));
  gh.factory<_i14.WatchTimerLogUseCase>(
      () => _i14.WatchTimerLogUseCase(repository: get<_i10.TimerRepository>()));
  gh.factory<_i15.GetTimerStateUseCase>(
      () => _i15.GetTimerStateUseCase(repository: get<_i10.TimerRepository>()));
  gh.factory<_i16.LogBloc>(() =>
      _i16.LogBloc(watchTimerLogUseCase: get<_i14.WatchTimerLogUseCase>()));
  gh.factory<_i17.SaveTimerLogUseCase>(
      () => _i17.SaveTimerLogUseCase(repository: get<_i10.TimerRepository>()));
  gh.factory<_i18.SaveTimerStateUseCase>(() =>
      _i18.SaveTimerStateUseCase(repository: get<_i10.TimerRepository>()));
  gh.factory<_i19.HomeBloc>(() => _i19.HomeBloc(
      saveTimerStateUseCase: get<_i18.SaveTimerStateUseCase>(),
      getTimerStateUseCase: get<_i15.GetTimerStateUseCase>(),
      watchPauseReasonsUseCase: get<_i13.WatchPauseReasonsUseCase>(),
      updatePauseReasonsUseCase: get<_i12.UpdatePauseReasonsUseCase>(),
      saveTimerLogUseCase: get<_i17.SaveTimerLogUseCase>()));
  return get;
}
