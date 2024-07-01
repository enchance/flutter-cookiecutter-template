import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as path;

import '../core.dart';

part 'providers.g.dart';

final accountProvider = StateProvider<Account>((ref) => Account.empty());

@riverpod
class Upload extends _$Upload {
  @override
  FutureOr<String?> build() async => null;

  Future<String> upload({
    required String bucketName,
    required File file,
    required String folderPath,
    String prefix = '',
    String? name,
  }) async {
    final supabase = Supabase.instance.client;
    final settings = ref.watch(settingsProvider);

    name = name ?? const Uuid().v4();
    final ext = path.extension(file.path).toLowerCase();
    final fullpath = '$folderPath/$prefix$name$ext';
    final bucket = supabase.storage.from(bucketName);

    // await Future.delayed(const Duration(seconds: 2));
    await bucket.upload(fullpath, file);
    final signedUrl = await bucket.createSignedUrl(fullpath, settings.storageTtl);
    return signedUrl;
  }
}

@riverpod
class AvatarUpload extends _$AvatarUpload {
  @override
  FutureOr<bool?> build() async => null;

  Future<void> upload(File file) async {
    Account account = ref.watch(accountProvider);
    bool success = false;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      // await Future.delayed(const Duration(seconds: 2));
      final folderPath = 'accounts/${account.id}/';
      final signedUrl = await ref
          .read(uploadProvider.notifier)
          .upload(bucketName: 'sandbox', file: file, folderPath: folderPath, prefix: 'avatar-');

      success = await AccountService.save(account.id!, {'avatar': signedUrl});
      if (success) {
        account = account.copyWith(avatar: signedUrl);
        ref.read(accountProvider.notifier).update((_) => account);
      }

      return success;
    });
  }

  Future<void> clear() async {
    Account account = ref.watch(accountProvider);

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final success = await AccountService.save(account.id!, {
        'avatar': '',
      });
      if (success) {
        account = account.copyWith(avatar: '');
        ref.read(accountProvider.notifier).update((_) => account);
      }
      return success;
    });
  }
}

@riverpod
class CoverUpload extends _$CoverUpload {
  @override
  FutureOr<bool?> build() async => null;

  Future<void> upload(File file) async {
    Account account = ref.watch(accountProvider);
    bool success = false;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      // await Future.delayed(const Duration(seconds: 2));
      final folderPath = 'accounts/${account.id}/';
      final signedUrl = await ref
          .read(uploadProvider.notifier)
          .upload(bucketName: 'sandbox', file: file, folderPath: folderPath, prefix: 'cover-');

      success = await AccountService.save(account.id!, {
        'cover_profile': signedUrl,
      });
      if (success) {
        account = account.copyWith(coverProfile: signedUrl);
        ref.read(accountProvider.notifier).update((_) => account);
      }

      return success;
    });
  }

  // Future<void> clear() async {
  //   Account account = ref.watch(accountProvider);
  //
  //   state = const AsyncLoading();
  //   state = await AsyncValue.guard(() async {
  //     final success = await AccountService.save(account.id!, {
  //       'cover_profile': '',
  //     });
  //     if (success) {
  //       account = account.copyWith(avatar: '');
  //       ref.read(accountProvider.notifier).update((_) => account);
  //     }
  //     return success;
  //   });
  // }
}
