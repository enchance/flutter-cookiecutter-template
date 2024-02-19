// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authServiceHash() => r'ddbb3131f68b0645caa172d17997abcd8fdfbac5';

/// See also [authService].
@ProviderFor(authService)
final authServiceProvider = Provider<AuthService>.internal(
  authService,
  name: r'authServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthServiceRef = ProviderRef<AuthService>;
String _$authStreamHash() => r'c5011bb870b8467155c306f61142db48b2b00e44';

/// See also [authStream].
@ProviderFor(authStream)
final authStreamProvider = AutoDisposeStreamProvider<User?>.internal(
  authStream,
  name: r'authStreamProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthStreamRef = AutoDisposeStreamProviderRef<User?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
