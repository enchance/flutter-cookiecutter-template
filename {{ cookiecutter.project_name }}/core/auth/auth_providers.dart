import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_service.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
AuthService authService(AuthServiceRef ref) => AuthService();

@riverpod
Stream<User?> authStream(AuthStreamRef ref) => FirebaseAuth.instance.authStateChanges();
