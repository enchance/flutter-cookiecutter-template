import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';

import '../../core.dart';
import '../providers.dart';
import '../../../components/components.dart';

class AccountView extends ConsumerStatefulWidget {
  const AccountView({super.key});

  @override
  ConsumerState createState() => _AccountViewState();
}

class _AccountViewState extends ConsumerState<AccountView> with SingleTickerProviderStateMixin {
  late AnimationController animcon;
  late Animation<double> curve;
  late Animation<double> sizeAnim;

  @override
  void initState() {
    super.initState();
    animcon = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    curve = CurvedAnimation(parent: animcon, curve: Curves.easeInOutBack);
    sizeAnim = Tween<double>(begin: 200, end: 600).animate(curve);
  }

  @override
  void dispose() {
    animcon.dispose();
    super.dispose();
  }

  void animateCoverImage() {
    if (animcon.value == 1) {
      animcon.reverse();
    } else if (animcon.value == 0) {
      animcon.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final config = ref.watch(appConfigProvider);
    final account = ref.watch(accountProvider);

    final theme = Theme.of(context);
    final textStyle = appTextStyle(context, config.textSize);
    final size = MediaQuery.of(context).size;
    double minHeight = size.height - sizeAnim.value < 200 ? 200 : size.height - sizeAnim.value;

    return Scaffold(
        appBar: AppBar(
          title: Text(kDebugMode ? account.uid : settings.appName),
          actions: const [
            AppbarMenuPopupMenu(),
          ],
        ),
        body: SingleChildScrollView(
          child: AnimatedBuilder(
            animation: animcon,
            builder: (context, _) {
              return Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: animateCoverImage,
                        child: Container(
                          height: sizeAnim.value,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: account.coverProfile.isNotEmpty
                                  ? CachedNetworkImageProvider(account.coverProfile)
                                  : const AssetImage('assets/images/landscape.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: settings.padx),
                        width: double.infinity,
                        constraints: BoxConstraints(minHeight: minHeight),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 70),
                          child: Column(
                            children: [
                              TextButton(
                                onPressed: () => editProfile(context),
                                child: const Text('Edit Profile'),
                              ),
                              const SizedBox(height: 20),
                              Text(account.display.isNotEmpty ? account.display : 'Guest',
                                  style: theme.textTheme.titleMedium),
                              const SizedBox(height: 10),
                              if (account.fullname.isNotEmpty) Text(account.fullname),
                              account.email.isNotEmpty
                                  ? Text(account.email, style: textStyle)
                                  : const GoogleLinkAccountButton(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(top: sizeAnim.value - 75, child: buildAvatar()),
                  Positioned(right: 10, top: 10, child: buildCoverPreloader()),
                ],
              );
            },
          ),
        ));
  }

  Future<void> editProfile(BuildContext context) async {
    ActionStatus? data = await context.pushNamed<ActionStatus>('editprofile');
    logger.d(data);
  }

  Widget buildCoverPreloader() {
    final uploadcoverprov = ref.watch(uploadCoverProvider);
    final theme = Theme.of(context);

    return uploadcoverprov.maybeWhen(
      loading: () {
        return SizedBox(
          width: 36,
          height: 36,
          child: CircularProgressIndicator(
            color: theme.colorScheme.secondary,
          ),
        );
      },
      orElse: () {
        return IconButton(
          onPressed: pickCoverImage,
          icon: const Icon(Bootstrap.image_alt, size: 20),
          color: theme.colorScheme.onSurface,
          style: IconButton.styleFrom(backgroundColor: Colors.white30),
        );
      },
    );
  }

  Widget buildAvatar() {
    final account = ref.watch(accountProvider);
    final uploadprov = ref.watch(uploadAvatarProvider);
    final theme = Theme.of(context);

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: theme.colorScheme.surface, width: 4),
            color: theme.colorScheme.surface,
          ),
          child: uploadprov.maybeWhen(
            loading: () {
              return Stack(
                alignment: Alignment.center,
                children: [
                  account.avatar.isNotEmpty
                      ? Opacity(
                          opacity: 0.4,
                          child: CircleAvatar(
                            radius: 75,
                            backgroundImage: CachedNetworkImageProvider(account.avatar),
                            onBackgroundImageError: (err, _) {
                              logger.e(err);
                            },
                          ),
                        )
                      : buildPlaceholderAvatar(),
                  // Icon(Bootstrap.person_circle, color: Colors.grey.shade600, size: 50)
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: CircularProgressIndicator(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ],
              );
            },
            orElse: () {
              return account.avatar.isNotEmpty
                  ? CircleAvatar(
                      radius: 75,
                      backgroundImage: CachedNetworkImageProvider(account.avatar),
                    )
                  : buildPlaceholderAvatar();
            },
          ),
        ),
        Positioned(
          right: 15,
          bottom: 7,
          child: SizedBox(
            width: 30,
            height: 30,
            child: IconButton(
              onPressed: pickAvatarImage,
              icon: const Icon(Bootstrap.pencil_fill, size: 16),
              color: theme.colorScheme.onPrimary,
              style: IconButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPlaceholderAvatar() {
    return Container(
      width: 150,
      height: 150,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
      ),
      child: Icon(Bootstrap.person, size: 80, color: Colors.grey.shade600),
    );
  }

  void pickAvatarImage() async {
    try {
      final picker = ImagePicker();
      final XFile? selectedImage = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
        maxHeight: 300,
      );
      if (selectedImage == null) return;
      final file = File(selectedImage.path);
      await ref.read(uploadAvatarProvider.notifier).upload(file);
    } on PlatformException catch (err) {
      // User declined permissions
      logger.d(err);
      if (mounted) showErrorDialog(context, title: 'Upload error', message: err.toString());
    } on UploadFailedException catch (err, _) {
      if (mounted) showErrorDialog(context, title: 'Upload error', message: err.toString());
    } catch (err, _) {
      logger.e(err);
      return;
    }
  }

  void pickCoverImage() async {
    final settings = ref.watch(settingsProvider);

    try {
      final picker = ImagePicker();
      final XFile? selectedImage = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
        maxHeight: settings.imageMaxHeight,
      );
      if (selectedImage == null) return;
      final file = File(selectedImage.path);
      await ref.read(uploadCoverProvider.notifier).upload(file);
    } on PlatformException catch (err) {
      // User declined permissions
      logger.e(err);
      if (mounted) showErrorDialog(context, title: 'Upload error', message: err.toString());
    } on UploadFailedException catch (err, _) {
      if (mounted) showErrorDialog(context, title: 'Upload error', message: err.toString());
    } catch (err, _) {
      logger.e(err);
      return;
    }
  }
}
