import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../core.dart';

part 'providers.g.dart';

final accountProvider = StateProvider<Account>((ref) => Account.empty());

@riverpod
class UploadAvatar extends _$UploadAvatar {
  @override
  FutureOr<bool?> build() async => null;

  Future<void> upload(File file) async {
    Account account = ref.watch(accountProvider);
    bool success = false;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(seconds: 5));

      // Upload
      final imageId = const Uuid().v4();
      final task = await AuthService.putFile(
        file: file,
        path: 'accounts/${account.uid}/avatar-$imageId',
        metadata: {
          'uid': account.uid,
          'location': 'profile',
          'type': 'avatar',
        },
      );

      // TODO: Upload preloader
      task.snapshotEvents.listen((event) async {
        switch (event.state) {
          case TaskState.success:
            final imageUrl = await task.snapshot.ref.getDownloadURL();
            success = await AccountService.save(account.uid, {
              'avatar': imageUrl,
            });
            if (success) {
              account = account.copyWith(avatar: imageUrl);
              ref.read(accountProvider.notifier).update((_) => account);
              break;
            }
            throw Exception('AVATAR_UPLOAD_1_DB_0');
          case TaskState.error:
            logger.e('[AVATAR_UPLOAD_FAILED]');
            throw UploadFailedException('AVATAR_UPLOAD_FAILED');
          default:
          // Do nothing
        }
      });

      return success;
    });
  }

  // Future<void> clear() async {
  //   Account account = ref.watch(accountProvider);
  //
  //   state = const AsyncLoading();
  //   state = await AsyncValue.guard(() async {
  //     bool success = await AccountService.save(account.uid, {
  //       'avatar': '',
  //     });
  //     if (success) {
  //       account = account.copyWith(avatar: '');
  //       ref.read(accountProvider.notifier).update((_) => account);
  //     }
  //     return success;
  //   });
  // }
}

@riverpod
class UploadCover extends _$UploadCover {
  @override
  FutureOr<bool?> build() async => null;

  Future<void> upload(File file) async {
    Account account = ref.watch(accountProvider);
    bool success = false;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(seconds: 10));

      // Upload
      final imageId = const Uuid().v4();
      final task = await AuthService.putFile(
        file: file,
        path: 'accounts/${account.uid}/cover-profile-$imageId',
        metadata: {
          'uid': account.uid,
          'location': 'profile',
          'type': 'cover',
        },
      );

      // TODO: Upload preloader
      task.snapshotEvents.listen((event) async {
        switch (event.state) {
          case TaskState.success:
            final imageUrl = await task.snapshot.ref.getDownloadURL();
            success = await AccountService.save(account.uid, {
              'coverProfile': imageUrl,
            });
            if (success) {
              account = account.copyWith(coverProfile: imageUrl);
              ref.read(accountProvider.notifier).update((_) => account);
              break;
            }
            throw Exception('COVER_UPLOAD_1_DB_0');
          case TaskState.error:
            logger.e('[COVER_UPLOAD_FAILED]');
            throw UploadFailedException('COVER_UPLOAD_FAILED');
          default:
          // Do nothing
        }
      });

      return success;
    });
  }

  // Future<void> clear() async {
  //   Account account = ref.watch(accountProvider);
  //
  //   state = const AsyncLoading();
  //   state = await AsyncValue.guard(() async {
  //     bool success = await AccountService.save(account.uid, {
  //       'coverProfile': '',
  //     });
  //     if (success) {
  //       account = account.copyWith(coverProfile: '');
  //       // TODO: Update secstor?
  //       ref.read(accountProvider.notifier).update((_) => account);
  //     }
  //     return success;
  //   });
  // }
}