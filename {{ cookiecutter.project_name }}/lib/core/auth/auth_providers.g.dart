// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authServiceHash() => r'20e24c1859a34be3e2036cbd5c173074d665eb0e';

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
String _$userAccountHash() => r'69811a1b884fdd9b3034f1c98d0b676382722897';

/// See also [UserAccount].
@ProviderFor(UserAccount)
final userAccountProvider = NotifierProvider<UserAccount, Account?>.internal(
  UserAccount.new,
  name: r'userAccountProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userAccountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserAccount = Notifier<Account?>;
String _$authHash() => r'1f46ca9e0ec92466fe41e2af439111be1844e9f0';

/// See also [Auth].
@ProviderFor(Auth)
final authProvider = AutoDisposeAsyncNotifierProvider<Auth, Account?>.internal(
  Auth.new,
  name: r'authProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Auth = AutoDisposeAsyncNotifier<Account?>;
String _$emailSignInHash() => r'ccaff9db6fcbfecd231bc82953a5ba560580ef49';

/// See also [EmailSignIn].
@ProviderFor(EmailSignIn)
final emailSignInProvider =
    AutoDisposeAsyncNotifierProvider<EmailSignIn, Account?>.internal(
  EmailSignIn.new,
  name: r'emailSignInProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$emailSignInHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EmailSignIn = AutoDisposeAsyncNotifier<Account?>;
String _$anonymousSignInHash() => r'd0b3a40de04671df1286e927afbbaa549dc5c87e';

/// See also [AnonymousSignIn].
@ProviderFor(AnonymousSignIn)
final anonymousSignInProvider =
    AutoDisposeAsyncNotifierProvider<AnonymousSignIn, Account?>.internal(
  AnonymousSignIn.new,
  name: r'anonymousSignInProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$anonymousSignInHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AnonymousSignIn = AutoDisposeAsyncNotifier<Account?>;
String _$xSignInHash() => r'007ac523861e7ba8599bcec51363f410d74d84d0';

/// See also [xSignIn].
@ProviderFor(xSignIn)
final xSignInProvider =
    AutoDisposeAsyncNotifierProvider<xSignIn, Account?>.internal(
  xSignIn.new,
  name: r'xSignInProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$xSignInHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$xSignIn = AutoDisposeAsyncNotifier<Account?>;
String _$resetPasswordHash() => r'6181a0fde0510345ff314a6ee21215a5db3f3a86';

/// See also [ResetPassword].
@ProviderFor(ResetPassword)
final resetPasswordProvider =
    AutoDisposeAsyncNotifierProvider<ResetPassword, bool?>.internal(
  ResetPassword.new,
  name: r'resetPasswordProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$resetPasswordHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ResetPassword = AutoDisposeAsyncNotifier<bool?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
