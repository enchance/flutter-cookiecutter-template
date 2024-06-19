import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

import '../../core.dart';
import '../../../components/components.dart';

class ResetPasswordForm extends ConsumerStatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  ConsumerState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends ConsumerState<ResetPasswordForm> {
  final formKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;
  String recipient = '';
  bool emailSent = false;

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset password'),
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
                onChanged: () => setState(() => isLoading = false),
                initialValue: kDebugMode ? const {
                  'email': devemail
                } : <String, String>{},
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
                    if(recipient.isNotEmpty && emailSent) ...[
                      SuccessNoticeBox(
                          message: 'A reset email has been sent to **$recipient**.'
                      ),
                      const SizedBox(height: 30),
                    ],
                    FormBuilderTextField(
                      name: 'email',
                      valueTransformer: (val) => val?.trim(),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                        FormBuilderValidators.maxLength(100)
                      ]),
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => onSubmit(context),
                    ),
                    // if ((formKey.currentState?.fields['email']?.hasError ?? false) == false)
                    //   FieldRequiredText(),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedLoadingButton(
                        text: 'Reset your password',
                        onPressed: () => onSubmit(context),
                        loading: isLoading,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        if(settings.separateSigninView) return context.goNamed('signin');
                        context.goNamed('authwall');
                      },
                      child: Wrap(
                        children: [
                          Icon(Icons.arrow_left,
                              color: theme.colorScheme.onSurface.withOpacity(opacity1)),
                          Text('Back to Sign-in',
                              style: TextStyle(
                                  color: theme.colorScheme.onSurface.withOpacity(opacity1))),
                          const SizedBox(width: 20),
                        ],
                      ),
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
      isLoading = true;
      emailSent = false;
      recipient = '';
    });
    try {
      await Future.delayed(const Duration(seconds: 2));
      if (!form.saveAndValidate()) return;
      Map<String, dynamic> data = form.value;
      // logger.d(data);

      // Start here
      bool success = await AuthService.resetPassword(data['email']);
      setState(() {
        emailSent = success;
        recipient = success ? data['email'] : '';
      });
      if(success) form.fields['email']!.reset();

    } catch (err, _) {
      logger.e(err);
      if (context.mounted) {
        showErrorDialog(
          context,
          title: 'Reset error',
          message: 'Unable to reset your password. Try again in a few seconds.',
        );
      }
    } finally {
      if (context.mounted) setState(() => isLoading = false);
    }
  }

  // void onSubmit() async {
  //   final form = formKey.currentState!;
  //
  //   try {
  //     if (!form.saveAndValidate()) return;
  //
  //     final data = form.value;
  //     await ref.read(resetPasswordProvider.notifier).resetPassword(data['email']);
  //   } catch (err, _) {
  //     logger.e(err);
  //     setState(() => onFailed = true);
  //   }
  // }
  //
  // Widget buildSignIn() {
  //   return TextButton(
  //     onPressed: () => context.goNamed('index'),
  //     style: TextButton.styleFrom(
  //       padding: const EdgeInsets.symmetric(horizontal: 7),
  //     ),
  //     child: const Text('Back to Sign-in',
  //         style: TextStyle(
  //           fontWeight: FontWeight.bold,
  //           color: Colors.grey,
  //         )),
  //   );
  // }
}
