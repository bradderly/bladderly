// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:bradderly/core/recorder/recorder_module.dart' as _i5;
import 'package:bradderly/data/api/api_module.dart' as _i6;
import 'package:bradderly/data/api/client/api_client.dart' as _i3;
import 'package:bradderly/data/isar/isar_module.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:isar/isar.dart' as _i4;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final apiModule = _$ApiModule();
    final isarModule = _$IsarModule();
    final recorderModule = _$RecorderModule();
    gh.lazySingleton<_i3.ApiClient>(() => apiModule.apiClient);
    await gh.factoryAsync<_i4.Isar>(
      () => isarModule.isar,
      preResolve: true,
    );
    gh.factory<_i5.Recorder>(() => recorderModule.recorder);
    return this;
  }
}

class _$ApiModule extends _i6.ApiModule {}

class _$IsarModule extends _i7.IsarModule {}

class _$RecorderModule extends _i5.RecorderModule {}
