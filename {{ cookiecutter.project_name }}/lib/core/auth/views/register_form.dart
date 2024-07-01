import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  bool showExistsError = false;

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
                    if (showExistsError) ...[
                      const SizedBox(height: 10),
                      const ErrorNoticeBox(message: '''
That account may already be in use. If you forgot your password tap the
**Lost password** link below.
'''),
                    ],
                    const SizedBox(height: 30),
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

    ref.read(authPendingProvider.notifier).update((_) => 'register');
    setState(() => showExistsError = false);
    try {
      await Future.delayed(const Duration(seconds: 2));
      if (!form.saveAndValidate()) {
        ref.read(authPendingProvider.notifier).update((_) => '');
        return;
      }
      Map<String, dynamic> data = form.value;
      // logger.d(data);

      // Start here
      if (data['password'] != data['retype']) {
        form.fields['retype']!.invalidate('Passwords do not match');
        ref.read(authPendingProvider.notifier).update((_) => '');
        return;
      }
      await AuthService.registerWithEmail(data['email'], data['password']);
    } on AuthException catch (err) {
      logger.e(err.message);
      ref.read(authPendingProvider.notifier).update((_) => '');
      if (err.message == 'User already registered') {
        return setState(() => showExistsError = true);
      }
    } catch (err, _) {
      logger.e(err);
      ref.read(authPendingProvider.notifier).update((_) => '');
      if (context.mounted) {
        showErrorDialog(
          context,
          title: 'Registration failed',
          message: 'Try again in a few seconds.',
        );
      }
    }
  }
}
