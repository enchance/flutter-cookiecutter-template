import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

import '../auth.dart';
import '../../core.dart';
import '../../../components/components.dart';
import 'package:popolscan/core/config/routes.dart';

class ResetPasswordView extends ConsumerStatefulWidget {
  const ResetPasswordView({super.key});

  @override
  ConsumerState createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends ConsumerState<ResetPasswordView> {
  final _formKey = GlobalKey<FormBuilderState>();

  // bool _sendingResetEmail = false;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      body: FormBuilder(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: settings.padx),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Bootstrap.envelope_at, size: 150),
                const SizedBox(height: 20),
                Text('Reset password',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 50,
                    )),
                const SizedBox(height: 10),
                FormBuilderTextField(
                  name: 'email',
                  valueTransformer: (val) => val?.toLowerCase(),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                    FormBuilderValidators.maxLength(100),
                  ]),
                  decoration: const InputDecoration(labelText: 'Email'),
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    // onPressed: null,
                    onPressed: _loading ? null : _changePassword,
                    child: _loading
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: SpinKitThreeBounce(
                              color: Theme.of(context).colorScheme.onBackground,
                              size: 15,
                            ),
                          )
                        : const Text('Reset password'),
                  ),
                ),
                const SizedBox(height: 30),
                Wrap(
                  children: [
                    const Text('Have an account?', style: TextStyle(color: Colors.grey)),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () => context.goNamed(RouteName.signin.name),
                      child: const Text('Sign-in.',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _changePassword() async {
    final form = _formKey.currentState!;
    final authService = ref.read(authServiceProvider);

    setState(() => _loading = true);
    try {
      if (!form.saveAndValidate()) return;
      final data = form.value;

      final email = data['email'];
      authService.changePassword(email);
      await Future.delayed(const Duration(seconds: 1));
      form.reset();

      if (mounted) {
        const text = 'Reset email sent!';
        ScaffoldMessenger.of(context).showSnackBar(AppSnackbar(
          context,
          text,
          Icon(Icons.email_outlined, color: Theme.of(context).colorScheme.onSurface),
        ));
      }
    } catch (err, _) {
      if (mounted) {
        const text = 'Unable to send email. Try again later.';
        ScaffoldMessenger.of(context).showSnackBar(AppSnackbar(context, text));
      }
    } finally {
      setState(() => _loading = false);
    }
  }
}
