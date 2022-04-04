// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/shared_preferences_datasource.dart' as _i3;
import '../data/shared_rpeferences_datasource_impl.dart' as _i4;
import '../domain/repository/timer_repository.dart' as _i5;
import '../domain/repository/timer_repository_impl.dart' as _i6;
import '../domain/usecase/get_pause_reason_usecase.dart' as _i7;
import '../domain/usecase/get_time_on_pause_usecase.dart' as _i8;
import '../domain/usecase/get_timer_paused_usecase.dart' as _i9;
import '../domain/usecase/get_timer_timestamp_usecase.dart' as _i10;
import '../domain/usecase/get_work_time_usecase.dart' as _i11;
import '../domain/usecase/save_pause_reason_usecase.dart' as _i12;
import '../domain/usecase/save_time_on_pause_usecase.dart' as _i13;
import '../domain/usecase/save_timer_paused_usecase.dart' as _i14;
import '../domain/usecase/save_timer_timestamp_usecase.dart' as _i15;
import '../domain/usecase/save_work_time_usecase.dart' as _i16;
import '../presentation/bloc/home_bloc.dart'
    as _i17; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.SharedPreferencesDataSource>(
      _i4.SharedPreferencesDataSourceImpl());
  gh.singleton<_i5.TimerRepository>(_i6.TimerRepositoryImpl(
      dataSource: get<_i3.SharedPreferencesDataSource>()));
  gh.factory<_i7.GetPauseReasonUseCase>(
      () => _i7.GetPauseReasonUseCase(repository: get<_i5.TimerRepository>()));
  gh.factory<_i8.GetTimeOnPauseUseCase>(
      () => _i8.GetTimeOnPauseUseCase(repository: get<_i5.TimerRepository>()));
  gh.factory<_i9.GetTimerPausedUseCase>(
      () => _i9.GetTimerPausedUseCase(repository: get<_i5.TimerRepository>()));
  gh.factory<_i10.GetTimerTimestampUseCase>(() =>
      _i10.GetTimerTimestampUseCase(repository: get<_i5.TimerRepository>()));
  gh.factory<_i11.GetWorkTimeUseCase>(
      () => _i11.GetWorkTimeUseCase(repository: get<_i5.TimerRepository>()));
  gh.factory<_i12.SavePauseReasonUseCase>(() =>
      _i12.SavePauseReasonUseCase(repository: get<_i5.TimerRepository>()));
  gh.factory<_i13.SaveTimeOnPauseUseCase>(() =>
      _i13.SaveTimeOnPauseUseCase(repository: get<_i5.TimerRepository>()));
  gh.factory<_i14.SaveTimerPausedUseCase>(() =>
      _i14.SaveTimerPausedUseCase(repository: get<_i5.TimerRepository>()));
  gh.factory<_i15.SaveTimerTimestampUseCase>(() =>
      _i15.SaveTimerTimestampUseCase(repository: get<_i5.TimerRepository>()));
  gh.factory<_i16.SaveWorkTimeUseCase>(
      () => _i16.SaveWorkTimeUseCase(repository: get<_i5.TimerRepository>()));
  gh.factory<_i17.HomeBloc>(() => _i17.HomeBloc(
      getTimerTimestampUseCase: get<_i10.GetTimerTimestampUseCase>(),
      getPauseReasonUseCase: get<_i7.GetPauseReasonUseCase>(),
      getTimeOnPauseUseCase: get<_i8.GetTimeOnPauseUseCase>(),
      getWorkTimeUseCase: get<_i11.GetWorkTimeUseCase>(),
      getTimerPausedUseCase: get<_i9.GetTimerPausedUseCase>(),
      saveTimerTimestampUseCase: get<_i15.SaveTimerTimestampUseCase>(),
      savePauseReasonUseCase: get<_i12.SavePauseReasonUseCase>(),
      saveTimeOnPauseUseCase: get<_i13.SaveTimeOnPauseUseCase>(),
      saveWorkTimeUseCase: get<_i16.SaveWorkTimeUseCase>(),
      saveTimerPausedUseCase: get<_i14.SaveTimerPausedUseCase>()));
  return get;
}
