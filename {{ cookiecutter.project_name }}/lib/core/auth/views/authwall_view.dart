import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core.dart';
import '../../../components/components.dart';

class AuthWallView extends ConsumerStatefulWidget {
  const AuthWallView({super.key});

  @override
  ConsumerState createState() => _AuthWallViewState();
}

class _AuthWallViewState extends ConsumerState<AuthWallView> {
  final formKey = GlobalKey<FormBuilderState>();
  bool isObscured = true;
  bool showPasswordError = false;
  bool showTryAgainError = false;

  @override
  Widget build(BuildContext context) {
    final prefs = ref.watch(prefsProvider);
    final settings = ref.watch(settingsProvider);
    final authpending = ref.watch(authPendingProvider);
    final signOutText = ref.watch(signOutTextProvider);

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: kDebugMode
            ? TextButton(
                onPressed: () {
                  prefs.clear();
                  signOut(context, ref);
                },
                child: Text('Reset prefs',
                    style: TextStyle(
                        color: theme.colorScheme.onSurface,
                        fontSize: 24,
                        fontWeight: FontWeight.normal)),
              )
            : Text(settings.appName),
        centerTitle: true,
        backgroundColor: theme.colorScheme.surface,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: settings.padx),
            child: Column(
              children: [
                SizedBox(height: settings.topGap),
                // TextButton(
                //   onPressed: () {
                //     context.goNamed('settings');
                //   },
                //   child: const Text('Go to test route'),
                // ),
                if (signOutText != null) InfoNoticeBox(message: signOutText),
                const SizedBox(height: 10),
                Container(
                  width: 300,
                  height: settings.separateSigninView ? 300 : 200,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.image_rounded, size: 100, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                if (showPasswordError) ...[
                  const SizedBox(height: 10),
                  const ErrorNoticeBox(
                      message: 'Please check if you typed your password correctly.'),
                ],
                if (showTryAgainError) ...[
                  const SizedBox(height: 10),
                  const ErrorNoticeBox(
                      message: 'Unable to verify your account. Try again in a few seconds.'),
                ],
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedLoadingButton(
                    text: 'Google Sign-in',
                    onPressed: ref.read(authProvider.notifier).googleSignIn,
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    loading: authpending == 'google',
                    icon: const Icon(Bootstrap.google),
                    enabled: authpending != 'email' && authpending != 'anonymous',
                  ),
                ),
                const SizedBox(height: 10),
                settings.separateSigninView ? buildSignInButton() : buildSignInForm(),
                buildTextLinks(),
                SizedBox(height: settings.bottomGap),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSignInForm() {
    final authpending = ref.watch(authPendingProvider);
    final theme = Theme.of(context);

    return Column(
      children: [
        // const SizedBox(height: 10),
        const Text('or', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        FormBuilder(
            key: formKey,
            initialValue: kDebugMode
                ? const {
                    'email': devemail,
                    'password': devpass,
                  }
                : <String, String>{},
            child: Column(
              children: [
                kDebugMode
                    ? FormBuilderDropdown(
                        name: 'email',
                        initialValue: 'enchance@gmail.com',
                        items: const [
                          DropdownMenuItem(
                            value: 'enchance@gmail.com',
                            child: Text(
                              'enchance@gmail.com',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'devteam123@proton.me',
                            child: Text(
                              'devteam123@proton.me',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'codezmj7nw6qbrrerjlh93uugpon8j@gmail.com',
                            child: Text(
                              'codezmj7nw6qbrrerjlh93uugpon8j@gmail.com',
                              style: TextStyle(fontSize: 18),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      )
                    : FormBuilderTextField(
                        name: 'email',
                        valueTransformer: (val) => val?.trim(),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.email(),
                          FormBuilderValidators.maxLength(100)
                        ]),
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                      ),
                // if ((formKey.currentState?.fields['email']?.hasError ?? false) == false)
                //   FieldRequiredText(),
                const SizedBox(height: 10),
                FormBuilderTextField(
                  name: 'password',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.maxLength(100),
                  ]),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: () => setState(() => isObscured = !isObscured),
                      icon: Icon(isObscured ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  obscureText: isObscured,
                  onSubmitted: (_) => onSubmit(context),
                ),
                // if ((formKey.currentState?.fields['password']?.hasError ?? false) == false)
                //   FieldRequiredText(),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedLoadingButton(
                    text: 'Sign-in',
                    onPressed: () => onSubmit(context),
                    loading: authpending == 'email',
                    enabled: authpending != 'google' && authpending != 'anonymous',
                  ),
                ),
              ],
            )),
      ],
    );
  }

  Widget buildSignInButton() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => context.goNamed('signin'),
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark ? Colors.black : Colors.white,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.email),
            SizedBox(width: 10),
            Text('Email Sign-in'),
          ],
        ),
      ),
    );
  }

  Widget buildTextLinks() {
    final settings = ref.watch(settingsProvider);
    final authpending = ref.watch(authPendingProvider);

    final theme = Theme.of(context);

    return Column(
      children: [
        if (settings.separateSigninView) ...[
          const SizedBox(height: 20),
          TextButton(
            onPressed: () => context.goNamed('register'),
            style:
                TextButton.styleFrom(foregroundColor: theme.colorScheme.onSurface.withOpacity(0.5)),
            child: Wrap(
              children: [
                const SizedBox(width: 24),
                Text('Register',
                    style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(opacity1))),
                Icon(Icons.arrow_right, color: theme.colorScheme.onSurface.withOpacity(opacity1)),
              ],
            ),
          ),
        ],
        if (!settings.separateSigninView) ...[
          const SizedBox(height: 20),
          TextButton(
            onPressed: () => context.goNamed('register'),
            child: Wrap(
              children: [
                const SizedBox(width: 20),
                const Text('Register'),
                Icon(Icons.arrow_right, color: theme.colorScheme.onSurface.withOpacity(opacity1)),
              ],
            ),
          ),
        ],
        // const SizedBox(height: 5),
        // TextButton(
        //   onPressed: authpending != 'google' && authpending != 'email'
        //       ? () async {
        //           final prefs = ref.watch(prefsProvider);
        //
        //           await Future.wait([
        //             prefs.setBool('showOnboarding', false),
        //             prefs.setBool('showAuthWall', false),
        //             ref.read(authProvider.notifier).anonymousSignIn(),
        //           ]);
        //         }
        //       : null,
        //   child: authpending == 'anonymous'
        //       ? const SizedBox(
        //           width: 24,
        //           height: 24,
        //           child: CircularProgressIndicator(),
        //         )
        //       : const Text('Try without account'),
        // ),
        TextButton(
          onPressed: () => signOut(context, ref),
          child: const Text('Sign-out'),
        ),
      ],
    );
  }

  void onSubmit(BuildContext context) async {
    final form = formKey.currentState!;

    setState(() {
      showPasswordError = false;
      showTryAgainError = false;
    });
    ref.read(authPendingProvider.notifier).update((_) => 'email');
    try {
      // await Future.delayed(const Duration(seconds: 2));
      if (!form.saveAndValidate()) return;
      Map<String, dynamic> data = form.value;
      // logger.d(data);

      // Start here
      await AuthService.emailSignin(data['email'], data['password']);
    } on AuthException catch (err) {
      logger.d(err.message);
      ref.read(authPendingProvider.notifier).update((_) => '');
      if (err.message == 'Invalid login credentials') {
        return setState(() => showPasswordError = true);
      }
      setState(() => showTryAgainError = true);
    } catch (err, _) {
      logger.e(err);
      ref.read(authPendingProvider.notifier).update((_) => '');
      setState(() => showTryAgainError = true);
      // ref.read(authProvider.notifier).signOut();
    }
  }
}
