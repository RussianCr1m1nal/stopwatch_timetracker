// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/shared_preferences_datasource.dart' as _i3;
import '../data/shared_rpeferences_datasource_impl.dart' as _i4;
import '../domain/repository/shared_preferences_repository.dart' as _i5;
import '../domain/repository/shared_preferences_repository_impl.dart' as _i6;
import '../domain/usecase/get_timer_bool_usecase.dart' as _i7;
import '../domain/usecase/get_timer_int_usecase.dart' as _i8;
import '../domain/usecase/save_timer_bool_usecase.dart' as _i9;
import '../domain/usecase/save_timer_int_usecase.dart' as _i10;
import '../presentation/bloc/home_bloc.dart'
    as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.SharedPreferencesDataSource>(
      _i4.SharedPreferencesDataSourceImpl());
  gh.singleton<_i5.SharedPreferencesRepository>(
      _i6.SharedPreferencesRepositoryImpl(
          dataSource: get<_i3.SharedPreferencesDataSource>()));
  gh.factory<_i7.GetTimerDataBoolUseCase>(() => _i7.GetTimerDataBoolUseCase(
      repository: get<_i5.SharedPreferencesRepository>()));
  gh.factory<_i8.GetTimerDataIntUseCase>(() =>
      _i8.GetTimerDataIntUseCase(repository: get<_i5.SharedPreferencesRepository>()));
  gh.factory<_i9.SaveTimerDataBoolUseCase>(() => _i9.SaveTimerDataBoolUseCase(
      repository: get<_i5.SharedPreferencesRepository>()));
  gh.factory<_i10.SaveTimerDataInt>(() => _i10.SaveTimerDataInt(
      repository: get<_i5.SharedPreferencesRepository>()));
  gh.factory<_i11.HomeBloc>(() => _i11.HomeBloc(
      getTimerDataIntUseCase: get<_i8.GetTimerDataIntUseCase>(),
      saveTimerDataIntUseCase: get<_i10.SaveTimerDataInt>(),
      getTimerDataBoolUseCase: get<_i7.GetTimerDataBoolUseCase>(),
      saveTimerDataBoolUseCase: get<_i9.SaveTimerDataBoolUseCase>()));
  return get;
}
