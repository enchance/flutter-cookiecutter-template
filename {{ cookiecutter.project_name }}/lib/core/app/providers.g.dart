// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dioHash() => r'41b696b35e5b56ccb124ee5abab8b893747d2153';

/// See also [dio].
@ProviderFor(dio)
final dioProvider = Provider<Dio>.internal(
  dio,
  name: r'dioProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dioHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DioRef = ProviderRef<Dio>;
String _$prefsHash() => r'39ad2d8b128e06b8732f8c8b287424f06ef8c4e5';

/// See also [prefs].
@ProviderFor(prefs)
final prefsProvider = Provider<SharedPreferences>.internal(
  prefs,
  name: r'prefsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$prefsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PrefsRef = ProviderRef<SharedPreferences>;
String _$packageInfoHash() => r'517f01fbab81b5ebd10a5d03633b9ffaee13310a';

/// See also [packageInfo].
@ProviderFor(packageInfo)
final packageInfoProvider = Provider<PackageInfo>.internal(
  packageInfo,
  name: r'packageInfoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$packageInfoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PackageInfoRef = ProviderRef<PackageInfo>;
String _$secureStorageHash() => r'1af6260f08df73414fb43b01bc43d87bc240e5a0';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [secureStorage].
@ProviderFor(secureStorage)
const secureStorageProvider = SecureStorageFamily();

/// See also [secureStorage].
class SecureStorageFamily extends Family<FlutterSecureStorage> {
  /// See also [secureStorage].
  const SecureStorageFamily();

  /// See also [secureStorage].
  SecureStorageProvider call({
    required String prefix,
  }) {
    return SecureStorageProvider(
      prefix: prefix,
    );
  }

  @override
  SecureStorageProvider getProviderOverride(
    covariant SecureStorageProvider provider,
  ) {
    return call(
      prefix: provider.prefix,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'secureStorageProvider';
}

/// See also [secureStorage].
class SecureStorageProvider extends Provider<FlutterSecureStorage> {
  /// See also [secureStorage].
  SecureStorageProvider({
    required String prefix,
  }) : this._internal(
          (ref) => secureStorage(
            ref as SecureStorageRef,
            prefix: prefix,
          ),
          from: secureStorageProvider,
          name: r'secureStorageProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$secureStorageHash,
          dependencies: SecureStorageFamily._dependencies,
          allTransitiveDependencies:
              SecureStorageFamily._allTransitiveDependencies,
          prefix: prefix,
        );

  SecureStorageProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.prefix,
  }) : super.internal();

  final String prefix;

  @override
  Override overrideWith(
    FlutterSecureStorage Function(SecureStorageRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SecureStorageProvider._internal(
        (ref) => create(ref as SecureStorageRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        prefix: prefix,
      ),
    );
  }

  @override
  ProviderElement<FlutterSecureStorage> createElement() {
    return _SecureStorageProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SecureStorageProvider && other.prefix == prefix;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, prefix.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SecureStorageRef on ProviderRef<FlutterSecureStorage> {
  /// The parameter `prefix` of this provider.
  String get prefix;
}

class _SecureStorageProviderElement
    extends ProviderElement<FlutterSecureStorage> with SecureStorageRef {
  _SecureStorageProviderElement(super.provider);

  @override
  String get prefix => (origin as SecureStorageProvider).prefix;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
