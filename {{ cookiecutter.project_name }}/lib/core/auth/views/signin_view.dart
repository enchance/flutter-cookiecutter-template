import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'package:popolscan/core/auth/auth_service.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:popolscan/startup/startup_providers.dart';

import '../../core.dart';
import '../auth.dart';
import '../../../components/components.dart';
import '../../../gen/assets.gen.dart';
import '../../../startup/startup.dart';

class SigninView extends ConsumerStatefulWidget {
  const SigninView({super.key});

  @override
  ConsumerState createState() => _AuthViewState();
}

class _AuthViewState extends ConsumerState<SigninView> {
  final form = GlobalKey<FormBuilderState>();
  bool _obscure = true;
  bool _loading = false;
  bool _error = false;
  bool _sendingResetEmail = false;

  @override
  Widget build(BuildContext context) {
    final settings = ref.read(settingsProvider);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
                hasScrollBody: false,
                child: FormBuilder(
                  key: form,
                  initialValue: const {
                    // 'email': 'devteam123@proton.me',
                    // 'email': 'enchance@gmail.com',
                    'password': 'pass123',
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: settings.padx),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 150,
                          child: Assets.icons.scanner.image(
                            fit: BoxFit.cover,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text('Sign-in',
                            style: GoogleFonts.bebasNeue(
                              fontSize: 50,
                            )),
                        if (_error) ...[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(settings.radius),
                                color: Theme.of(context).colorScheme.errorContainer,
                              ),
                              child: MarkdownBody(
                                data: '**Unable to sign in.** Your '
                                    'password may be incorrect.',
                                styleSheet: MarkdownStyleSheet(
                                  p: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 20),
                        kDebugMode
                            ? FormBuilderDropdown(
                                name: 'email',
                                initialValue: 'enchance@gmail.com',
                                items: [
                                  DropdownMenuItem(
                                    value: 'enchance@gmail.com',
                                    child: Text(
                                      'enchance@gmail.com',
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 'devteam123@proton.me',
                                    child: Text(
                                      'devteam123@proton.me',
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ),
                                ],
                              )
                            : FormBuilderTextField(
                                name: 'email',
                                valueTransformer: (val) => val?.toLowerCase(),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.email(),
                                  FormBuilderValidators.maxLength(100)
                                ]),
                                decoration: const InputDecoration(
                                  hintText: 'Email',
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(top: 7),
                                    child: Icon(Icons.email_outlined),
                                  ),
                                  prefixIconColor: Colors.grey,
                                ),
                                textAlignVertical: TextAlignVertical.center,
                              ),
                        const SizedBox(height: 10),
                        FormBuilderTextField(
                          name: 'password',
                          obscureText: _obscure,
                          valueTransformer: (val) => val?.toLowerCase(),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.minLength(6),
                          ]),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Icon(Icons.lock_outline),
                            ),
                            prefixIconColor: Colors.grey,
                            suffixIcon: GestureDetector(
                                onTap: _toggle,
                                child: Icon(
                                    _obscure ? Icons.visibility_off_outlined : Icons.visibility)),
                            suffixIconColor: Colors.grey,
                          ),
                          textAlignVertical: TextAlignVertical.center,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            // onPressed: null,
                            onPressed: _loading ? null : _onSubmit,
                            child: _loading
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                    child: SpinKitThreeBounce(
                                      color: Theme.of(context).colorScheme.onBackground,
                                      size: 15,
                                    ),
                                  )
                                : const Text('Sign-in'),
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          height: 20,
                          child: _sendingResetEmail
                              ? const SpinKitThreeBounce(color: Colors.grey, size: 15)
                              : Wrap(
                                  alignment: WrapAlignment.center,
                                  children: [
                                    const Text(
                                      'Lost your password?',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    GestureDetector(
                                      onTap: () => context.goNamed('reset-password'),
                                      child: const Text(
                                        'Reset it.',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  _toggle() {
    setState(() => _obscure = !_obscure);
  }

  _setLoading(bool val) {
    if (mounted && _loading != val) setState(() => _loading = val);
  }

  _setError(bool val) {
    if (mounted && _error != val) setState(() => _error = val);
  }

  _onSubmit() async {
    final authService = ref.read(authServiceProvider);
    _setLoading(true);

    try {
      if (kDebugMode) await Future.delayed(const Duration(seconds: 1));

      if (form.currentState?.saveAndValidate() ?? false) {
        // form.currentState!.save();
        final email = form.currentState!.value['email'];
        final password = form.currentState!.value['password'];
        try {
          await authService.emailSignIn(email: email, password: password);
          _setError(false);
        } catch (err, _) {
          rethrow;
        }
      }
    } catch (_) {
      _setError(true);
    }
    _setLoading(false);
  }
}
