// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/database/TranslateDatabaseService.dart' as _i7;
import '../data/TextToSpeechService.dart' as _i6;
import '../data/translate/JniApi.dart' as _i4;
import '../data/translate/RandomTranslateService.dart' as _i5;
import '../data/translate/TranslateRepository.dart' as _i8;
import '../screen/main/MainScreenViewModel.dart' as _i9;
import 'DioModule.dart' as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final dioModule = _$DioModule();
  final jniTranslateModule = _$JniTranslateModule();
  gh.lazySingleton<_i3.Dio>(() => dioModule.dio());
  gh.lazySingleton<_i4.JniApi>(() => jniTranslateModule.jniApi(get<_i3.Dio>()));
  gh.factory<_i5.RandomTranslateService>(
      () => _i5.RandomTranslateService(get<_i4.JniApi>()));
  gh.factory<_i6.TextToSpeechService>(() => _i6.TextToSpeechService());
  gh.factory<_i7.TranslateDatabaseService>(
      () => _i7.TranslateDatabaseService());
  gh.factory<_i8.TranslateRepository>(
      () => _i8.TranslateRepository(get<_i5.RandomTranslateService>()));
  gh.factory<_i9.MainScreenViewModel>(() => _i9.MainScreenViewModel(
      get<_i7.TranslateDatabaseService>(),
      get<_i6.TextToSpeechService>(),
      get<_i8.TranslateRepository>()));
  return get;
}

class _$DioModule extends _i10.DioModule {}

class _$JniTranslateModule extends _i4.JniTranslateModule {}
