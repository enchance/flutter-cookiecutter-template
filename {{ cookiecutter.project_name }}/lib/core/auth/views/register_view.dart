import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../core.dart';
import '../../../components/components.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final formKey = GlobalKey<FormBuilderState>();
  bool obscure = true;
  bool onFailed = false;
  String? passwd = 'pass123';

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final authprov = ref.watch(authProvider);
    
    ref.listen(authProvider, (_, next) {
      if(next.isLoading) return;
      if(next.hasError) setState(() => onFailed = true);
    });

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
        ),
        SliverToBoxAdapter(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: settings.padx),
              child: FormBuilder(
                key: formKey,
                initialValue: const {
                  'email': 'devteam123@proton.me',
                  // 'email': 'foo@bar.com',
                  'password': 'pass123',
                  'password2': 'pass123',
                },
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // const MastheadPlaceholderImage(),
                    const Icon(Bootstrap.person_circle, size: 70),
                    if (onFailed) ...[
                      const SizedBox(height: 20),
                      NoticeBox.error(errorMessages['ACCOUNT_EXISTS']!),
                    ],
                    const SizedBox(height: 20),
                    Text('Register Account', style: Theme.of(context).textTheme.titleMedium,),
                    const SizedBox(height: 20),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: settings.maxWidth),
                      child: FormBuilderTextField(
                        name: 'email',
                        valueTransformer: (val) => val?.trim() ?? '',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.email(),
                        ]),
                        decoration: const InputDecoration(labelText: 'Email'),
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: settings.maxWidth),
                      child: FormBuilderTextField(
                        name: 'password',
                        obscureText: obscure,
                        obscuringCharacter: '*',
                        onChanged: (val) => setState(() => passwd = val),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: GestureDetector(
                            onTap: () => setState(() => obscure = !obscure),
                            child: Icon(
                              obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            ),
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.minLength(6,
                              errorText: 'Length must be greater than 5'),
                          FormBuilderValidators.maxLength(100),
                        ]),
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: settings.maxWidth),
                      child: FormBuilderTextField(
                        name: 'password2',
                        obscureText: obscure,
                        obscuringCharacter: '*',
                        decoration: const InputDecoration(labelText: 'Retype'),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.equal(
                            passwd ?? '',
                            errorText: 'Passwords are not the same',
                          ),
                        ]),
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      constraints: BoxConstraints(maxWidth: settings.maxWidth),
                      child: ElevatedButton(
                        onPressed: authprov.maybeWhen(
                          loading: () => null,
                          orElse: () => onSubmit,
                        ),
                        child: authprov.maybeWhen(
                          loading: () => const ButtonLoading(),
                          orElse: () => const Text('Register'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    buildSignIn(),
                    SizedBox(height: settings.bottomGap),
                  ],
                ),
              )),
        )
      ],
    ));
  }

  void onSubmit() async {
    final form = formKey.currentState!;

    try {
      if (!form.saveAndValidate()) return;

      final data = form.value;
      await ref.read(authProvider.notifier).createUserWithEmail(data['email'], data['password']);
    } catch (err, _) {
      logger.e(err);
      rethrow;
    }
  }

  Widget buildSignIn() {
    return TextButton(
      onPressed: () => context.goNamed('signin'),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 7),
      ),
      child: const Text('Back to Sign-in',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          )),
    );
  }
}
