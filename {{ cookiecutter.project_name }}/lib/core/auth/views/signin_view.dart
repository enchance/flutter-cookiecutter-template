import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

import '../../core.dart';
import '../../../components/components.dart';
import '../auth_components.dart';

class EmailSignInView extends ConsumerStatefulWidget {
  const EmailSignInView({super.key});

  @override
  ConsumerState createState() => _SigninViewState();
}

class _SigninViewState extends ConsumerState<EmailSignInView> {
  final formKey = GlobalKey<FormBuilderState>();
  bool obscure = true;
  bool failed = false;

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final authprov = ref.watch(authProvider);

    ref.listen(authProvider, (_, next) {
      if(next.isLoading) return;
      if(next.hasError) setState(() => failed = true);
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
                'password': 'pass123',
              },
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const MastheadPlaceholderImage(),
                  if (failed) ...[
                    const SizedBox(height: 20),
                    NoticeBox.error(errorMessages['INCORRECT_PASSWORD']!),
                  ],
                  const SizedBox(height: 20),
                  Text('Sign-in', style: Theme.of(context).textTheme.titleMedium,),
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
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
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
                        FormBuilderValidators.minLength(6),
                        FormBuilderValidators.maxLength(100),
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
                        orElse: () => const Text('Sign-in'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildResetPassword(),
                  const RegisterHereText(),
                  SizedBox(height: settings.bottomGap),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }

  void onSubmit() async {
    final form = formKey.currentState!;

    try {
      if (!form.saveAndValidate()) return;

      final data = form.value;
      await ref.read(authProvider.notifier).signInWithEmail(data['email'], data['password']);
    } catch (err, _) {
      logger.e(err);
      rethrow;
    }
  }

  Widget buildResetPassword() {
    return TextButton(
      onPressed: () => context.goNamed('reset'),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 7),
      ),
      child: const Text('Reset my password',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          )),
    );
  }
}
