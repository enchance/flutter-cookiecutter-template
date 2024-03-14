import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

import '../../core.dart';
import '../../../components/components.dart';
import '../auth_components.dart';

class ResetPasswordView extends ConsumerStatefulWidget {
  const ResetPasswordView({super.key});

  @override
  ConsumerState createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends ConsumerState<ResetPasswordView> {
  final formKey = GlobalKey<FormBuilderState>();
  bool onFailed = false;
  bool onSuccess = false;

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final resetprov = ref.watch(resetPasswordProvider);

    ref.listen(resetPasswordProvider, (_, next) {
      if (next.isLoading) return;
      if (next.hasError) {
        setState(() {
          onFailed = true;
          onSuccess = false;
        });
      }
      else if(next.valueOrNull == true) {
        setState(() {
          onFailed = false;
          onSuccess = true;
        });
        formKey.currentState!.reset();
      }
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
              },
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const MastheadPlaceholderImage(),
                  if (onFailed) ...[
                    const SizedBox(height: 20),
                    NoticeBox.error(errorMessages['FAILED_RESET_PASSWORD']!),
                  ],
                  if (onSuccess) ...[
                    const SizedBox(height: 20),
                    NoticeBox.success(successMessages['RESET_LINK_SENT']!),
                  ],
                  const SizedBox(height: 20),
                  Text(
                    'Reset Password',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
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
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    constraints: BoxConstraints(maxWidth: settings.maxWidth),
                    child: ElevatedButton(
                      onPressed: resetprov.maybeWhen(
                        loading: () => null,
                        orElse: () => onSubmit,
                      ),
                      child: resetprov.maybeWhen(
                        loading: () => const ButtonLoading(),
                        orElse: () => const Text('Reset'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildSignIn(),
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
      await ref.read(resetPasswordProvider.notifier).resetPassword(data['email']);
    } catch (err, _) {
      logger.e(err);
      setState(() => onFailed = true);
    }
  }

  Widget buildSignIn() {
    return TextButton(
      onPressed: () => context.goNamed('index'),
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
