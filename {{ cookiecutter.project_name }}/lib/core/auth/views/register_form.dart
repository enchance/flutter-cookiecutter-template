import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../core.dart';
import '../../../components/components.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final formKey = GlobalKey<FormBuilderState>();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    final authpending = ref.watch(authPendingProvider);
    final settings = ref.watch(settingsProvider);

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
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
                        'retype': devpass,
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
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      name: 'password',
                      obscureText: isObscure,
                      validator: settings.validators.passwordRequired,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: () => setState(() => isObscure = !isObscure),
                          icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
                        ),
                      ),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      name: 'retype',
                      obscureText: isObscure,
                      validator: settings.validators.passwordRequired,
                      decoration: InputDecoration(
                        labelText: 'Retype',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: () => setState(() => isObscure = !isObscure),
                          icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
                        ),
                      ),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => onSubmit(context),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedLoadingButton(
                        text: 'Create account',
                        onPressed: () => onSubmit(context),
                        loading: authpending == 'register',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                        onPressed: () => context.goNamed('resetpass'),
                        child: Wrap(
                          children: [
                            const SizedBox(width: 18),
                            Icon(Bootstrap.key,
                                color: theme.colorScheme.onSurface.withOpacity(opacity1)),
                            const SizedBox(width: 10),
                            Text('Lost password',
                                style: TextStyle(
                                    color: theme.colorScheme.onSurface.withOpacity(opacity1))),
                          ],
                        )
                        // child: Text(
                        //   'Lost password',
                        //   style: TextStyle(color: theme.colorScheme.onPrimary.withOpacity(opacity1)),
                        // ),
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

    ref.read(authPendingProvider.notifier).update((_) => 'register');
    try {
      await Future.delayed(const Duration(seconds: 2));
      if (!form.saveAndValidate()) return;
      Map<String, dynamic> data = form.value;
      // logger.d(data);

      // Start here
      if (data['password'] != data['retype']) {
        form.fields['retype']!.invalidate('Passwords do not match');
        return;
      }
      await AuthService.registerWithEmail(data['email'], data['password']);
    } on FirebaseAuthException catch (err) {
      logger.e(err.code);
      ref.read(authPendingProvider.notifier).update((_) => '');
      if (err.code == 'email-already-in-use') {
        if (context.mounted) {
          showErrorDialog(context, title: 'Account', message: '''
That account may already be in use. If you're not sure try clicking on the 
**Lost password** link to reset the password.
''');
        }
      }
    } catch (err, _) {
      logger.e(err);
      ref.read(authPendingProvider.notifier).update((_) => '');
      if (context.mounted) {
        showErrorDialog(
          context,
          title: 'Send failed',
          message: 'Try again in a few seconds.',
        );
      }
    }
  }
}
