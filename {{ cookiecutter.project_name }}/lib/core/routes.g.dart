// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$routesHash() => r'6fdaac7f37b5931879468cc51ba644ecdc48060c';

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

/// See also [routes].
@ProviderFor(routes)
const routesProvider = RoutesFamily();

/// See also [routes].
class RoutesFamily extends Family<AsyncValue<GoRouter>> {
  /// See also [routes].
  const RoutesFamily();

  /// See also [routes].
  RoutesProvider call(
    Role role,
    SharedPreferences prefs,
  ) {
    return RoutesProvider(
      role,
      prefs,
    );
  }

  @override
  RoutesProvider getProviderOverride(
    covariant RoutesProvider provider,
  ) {
    return call(
      provider.role,
      provider.prefs,
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
  String? get name => r'routesProvider';
}

/// See also [routes].
class RoutesProvider extends AutoDisposeFutureProvider<GoRouter> {
  /// See also [routes].
  RoutesProvider(
    Role role,
    SharedPreferences prefs,
  ) : this._internal(
          (ref) => routes(
            ref as RoutesRef,
            role,
            prefs,
          ),
          from: routesProvider,
          name: r'routesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$routesHash,
          dependencies: RoutesFamily._dependencies,
          allTransitiveDependencies: RoutesFamily._allTransitiveDependencies,
          role: role,
          prefs: prefs,
        );

  RoutesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.role,
    required this.prefs,
  }) : super.internal();

  final Role role;
  final SharedPreferences prefs;

  @override
  Override overrideWith(
    FutureOr<GoRouter> Function(RoutesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RoutesProvider._internal(
        (ref) => create(ref as RoutesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        role: role,
        prefs: prefs,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<GoRouter> createElement() {
    return _RoutesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RoutesProvider &&
        other.role == role &&
        other.prefs == prefs;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, role.hashCode);
    hash = _SystemHash.combine(hash, prefs.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RoutesRef on AutoDisposeFutureProviderRef<GoRouter> {
  /// The parameter `role` of this provider.
  Role get role;

  /// The parameter `prefs` of this provider.
  SharedPreferences get prefs;
}

class _RoutesProviderElement extends AutoDisposeFutureProviderElement<GoRouter>
    with RoutesRef {
  _RoutesProviderElement(super.provider);

  @override
  Role get role => (origin as RoutesProvider).role;
  @override
  SharedPreferences get prefs => (origin as RoutesProvider).prefs;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
