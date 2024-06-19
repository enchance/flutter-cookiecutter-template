import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

import '../../core.dart';
import '../../../components/components.dart';

class EmailSignInForm extends ConsumerStatefulWidget {
  const EmailSignInForm({super.key});

  @override
  ConsumerState createState() => _EmailSigninFormState();
}

class _EmailSigninFormState extends ConsumerState<EmailSignInForm> {
  final formKey = GlobalKey<FormBuilderState>();
  bool isObscured = true;
  bool showPasswordError = false;
  bool showTryAgainError = false;

  // bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authpending = ref.watch(authPendingProvider);
    final settings = ref.watch(settingsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign-in'),
        centerTitle: true,
        backgroundColor: theme.colorScheme.surface,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: settings.padx),
            child: FormBuilder(
                key: formKey,
                initialValue: kDebugMode
                    ? const {
                        'email': devemail,
                        'password': devpass,
                      }
                    : <String, String>{},
                child: Column(
                  children: [
                    SizedBox(height: settings.topGap),
                    Container(
                      width: 300,
                      height: 200,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.image_rounded, size: 100, color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
                    if (showPasswordError) ...[
                      const ErrorNoticeBox(
                          message: 'Please check if you typed your password '
                              'correctly.'),
                      const SizedBox(height: 30),
                    ],
                    if (showTryAgainError) ...[
                      const ErrorNoticeBox(
                          message: 'Unable to verify your account. Try again in a few seconds.'),
                      const SizedBox(height: 30),
                    ],
                    FormBuilderTextField(
                      name: 'email',
                      valueTransformer: (val) => val?.trim(),
                      validator: settings.validators.emailRequired,
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
                      validator: settings.validators.passwordRequired,
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
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () => context.goNamed('register'),
                      child: Wrap(
                        children: [
                          const SizedBox(width: 20),
                          const Text('Register account'),
                          Icon(Icons.arrow_right,
                              color: theme.colorScheme.onSurface.withOpacity(opacity1)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () => context.goNamed('resetpass'),
                      child: const Text('Lost password'),
                    ),
                    SizedBox(height: settings.bottomGap),
                  ],
                )),
          ),
        ),
      ),
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
    } on FirebaseAuthException catch (err) {
      logger.d(err.code);
      ref.read(authPendingProvider.notifier).update((_) => '');
      if (err.code == 'wrong-password') return setState(() => showPasswordError = true);
      setState(() => showTryAgainError = true);
    } catch (err, _) {
      logger.e(err);
      ref.read(authPendingProvider.notifier).update((_) => '');
      setState(() => showTryAgainError = true);
      // ref.read(authProvider.notifier).signOut();
    }
  }
}
