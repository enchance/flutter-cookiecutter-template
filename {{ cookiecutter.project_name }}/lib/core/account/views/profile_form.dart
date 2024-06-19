import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../core.dart';
import '../../../components/components.dart';

class EditProfileForm extends ConsumerStatefulWidget {
  const EditProfileForm({super.key});

  @override
  ConsumerState createState() => _EditProfileFormState();
}

class _EditProfileFormState extends ConsumerState<EditProfileForm> {
  final scrollcon = ScrollController();
  final formKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;
  bool? genericError;
  bool? wrongPassword;
  bool? saveSuccess;

  @override
  void dispose() {
    scrollcon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final account = ref.watch(accountProvider);

    final theme = Theme.of(context);

    final json = account.toJson();
    final initialValue = {
      ...json,
      'fullname': '${json['firstname'].trim()} ${json['lastname'].trim()}',
    };
    initialValue.remove('firstname');
    initialValue.remove('lastname');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: theme.colorScheme.surface,
      ),
      body: SingleChildScrollView(
        controller: scrollcon,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: settings.padx),
          child: FormBuilder(
              key: formKey,
              onChanged: () => setState(() => isLoading = false),
              initialValue: initialValue,
              child: Column(
                children: [
                  SizedBox(height: settings.topGap),
                  buildNotices(),
                  const SizedBox(width: double.infinity, child: Text('Name shown in the app')),
                  const SizedBox(height: 5),
                  FormBuilderTextField(
                    name: 'display',
                    valueTransformer: (val) => val?.trim(),
                    validator: settings.validators.textRequired,
                    decoration: const InputDecoration(
                      labelText: 'Display',
                    ),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                  ),
                  if ((formKey.currentState?.fields['display']?.hasError ?? false) == false)
                    const FieldRequiredText(),
                  const SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'fullname',
                    valueTransformer: (val) => val?.trim(),
                    validator: settings.validators.text,
                    decoration: const InputDecoration(
                      labelText: 'Fullname',
                    ),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     formKey.currentState!.save();
                  //     final x = formKey.currentState!.value['fullname'];
                  //     // final (firstname, _) = splitName(x);
                  //     logger.d(splitName(x));
                  //   },
                  //   child: const Text('Split'),
                  // ),
                  const SizedBox(height: 10),
                  if (!account.isAnonymous)
                    FormBuilderTextField(
                      name: 'email',
                      valueTransformer: (val) => val?.trim(),
                      validator: settings.validators.emailRequired,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      // enabled: account.canEditEmail,
                      // enabled: account.authTypes.contains(AuthType.email),
                      enabled: false,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                  const SizedBox(height: 10),
                  FormBuilderTextField(
                    name: 'mobile',
                    valueTransformer: (val) => val?.trim(),
                    validator: settings.validators.mobile,
                    decoration: const InputDecoration(
                      labelText: 'Mobile',
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => onSubmit(context),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 300),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedLoadingButton(
                      text: 'Save Profile',
                      onPressed: () => onSubmit(context),
                      loading: isLoading,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () => context.pop(ActionStatus.cancelled),
                    child: Text('Cancel',
                        style: TextStyle(
                          color: theme.colorScheme.onSurface.withOpacity(opacity1),
                        )),
                  ),
                  SizedBox(height: settings.bottomGap),
                ],
              )),
        ),
      ),
    );
  }

  Widget buildNotices() {
    return Column(
      children: [
        if (saveSuccess ?? false) GestureDetector(
          onTap: () => context.pop(ActionStatus.success),
          child: const SuccessNoticeBox(message: '''
**Profile saved!** Tap this message to go back.
'''),
        ),
        if (genericError ?? false) const ErrorNoticeBox(message: '''
Unable to save your profile. Try again in a few seconds.
'''),
        if (wrongPassword ?? false) const ErrorNoticeBox(message: '''
Wrong password. Try typing slower.
'''),
        if ((saveSuccess ?? false) || (genericError ?? false) || (wrongPassword ?? false)) const
        SizedBox(height: 30),
      ],
    );
  }

  Future<void> onSubmit(BuildContext context) async {
    final form = formKey.currentState!;

    setState(() => isLoading = true);
    try {
      await Future.delayed(const Duration(seconds: 2));
      if (!form.saveAndValidate()) return;
      // Map<String, dynamic> data = form.value;
      // logger.d(data);

      // Start here
      Map<String, dynamic> toSave = {};
      for (var i in form.fields.entries) {
        if (i.value.isDirty) toSave[i.key] = i.value.value;
      }
      // logger.d(toSave);

      if (toSave.isEmpty && context.mounted) {
        setState(() {
          saveSuccess = true;
          genericError = false;
          wrongPassword = false;
        });
        scrollToTop(scrollcon);
        return;
      }

      final status = await saveForm(toSave);
      logger.d(status);

      if (!context.mounted) throw Exception();
      if (status == 'success') {
        setState(() {
          saveSuccess = true;
          genericError = false;
          wrongPassword = false;
        });
        scrollToTop(scrollcon);
        return;
      } else if (status == 'wrong-password') {
        setState(() {
          saveSuccess = false;
          genericError = false;
          wrongPassword = true;
        });
        scrollToTop(scrollcon);
        return;
      }
      throw Exception();
      // }
    } catch (err, _) {
      setState(() {
        saveSuccess = false;
        genericError = true;
        wrongPassword = false;
      });
      scrollToTop(scrollcon);
    } finally {
      if (context.mounted) setState(() => isLoading = false);
    }
  }

  Future<String> saveForm(Map<String, dynamic> json) async {
    Account account = ref.watch(accountProvider);
    final settings = ref.watch(settingsProvider);

    try {
      // throw Exception();
      // throw FirebaseAuthException(code: 'wrong-password');

      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) throw UserNullException();

      // if (json.containsKey('email')) {
      //   final String password = await showDialog(
      //     context: context,
      //     builder: (context) => const ReAuthenticateDialog(),
      //   );
      //   logger.d(password);
      //
      //   final auth = EmailAuthProvider.credential(email: account.email, password: password);
      //   final UserCredential creds = await user.reauthenticateWithCredential(auth);
      //   user = creds.user;
      //   if (user == null) return '';
      //
      //   // await AccountService.changeEmail(user, json['email']!);
      //   await user.verifyBeforeUpdateEmail(
      //     json['email'],
      //     ActionCodeSettings(
      //       url: "https://www.example.com/verify?email=${user.email}",
      //       handleCodeInApp: true,
      //       androidInstallApp: true,
      //       androidPackageName: settings.androidPackageName,
      //       // iOSBundleId: settings.iOSBundleId,
      //     ),
      //   );
      //   // _verificationSent = true;
      // }
      if (json.containsKey('display')) {
        await user.updateDisplayName(json['display']);
        account = account.copyWith(display: json['display']);
      }
      if (json.containsKey('mobile')) account = account.copyWith(mobile: json['mobile']);
      if (json.containsKey('fullname')) {
        final (firstname, lastname) = splitName(json['fullname']);
        account = account.copyWith(firstname: firstname, lastname: lastname);
        json['firstname'] = firstname;
        json['lastname'] = lastname;
        json.remove('fullname');
      }
      // TODO: If email is changend only save after verification
      bool success = await AccountService.save(user.uid, json);
      if (success) {
        ref.read(accountProvider.notifier).update((_) => account);
        return 'success';
      }
      throw Exception();
    } on FirebaseAuthException catch (err) {
      // logger.e(err.code);
      if (err.code == 'wrong-password') return 'wrong-password';
      return '';
    } catch (err, _) {
      logger.e(err);
      return '';
    }
  }
}

class ReAuthenticateDialog extends ConsumerStatefulWidget {
  const ReAuthenticateDialog({super.key});

  @override
  ConsumerState createState() => _ReAuthenticateDialogState();
}

class _ReAuthenticateDialogState extends ConsumerState<ReAuthenticateDialog> {
  final formKey = GlobalKey<FormBuilderState>();
  bool isObscured = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final account = ref.watch(accountProvider);
    final theme = Theme.of(context);

    return AlertDialog(
      title: Text('Account Verification', style: TextStyle(color: theme.colorScheme.onSurface)),
      // icon: const Icon(Bootstrap.key),
      backgroundColor: theme.colorScheme.surface,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FormBuilder(
            key: formKey,
            initialValue: {
              'password': 'pass123',
            },
            child: Column(
              children: [
                const Text('Type your password to continue'),
                const SizedBox(height: 5),
                FormBuilderTextField(
                  name: 'password',
                  validator: settings.validators.passwordRequired,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    // prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: () => setState(() => isObscured = !isObscured),
                      icon: Icon(isObscured ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  obscureText: isObscured,
                  onSubmitted: (_) => onSubmitPassword(context),
                ),
              ],
            ),
          )
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => context.pop(''),
              child: Text('Cancel',
                  style: TextStyle(
                    color: theme.colorScheme.onSurface.withOpacity(opacity1),
                  )),
            ),
            TextButton(
              onPressed: () => onSubmitPassword(context),
              child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(),
                    )
                  : const Text('Ok'),
            ),
          ],
        ),
      ],
    );
  }

  void onSubmitPassword(BuildContext context) async {
    final form = formKey.currentState!;

    setState(() => isLoading = true);
    try {
      await Future.delayed(const Duration(seconds: 2));
      if (!form.saveAndValidate()) return;
      Map<String, dynamic> data = form.value;
      // logger.d(data);

      // Start here
      if (context.mounted) context.pop(data['password']);
    } catch (err, _) {
      if (context.mounted) context.pop('');
    } finally {
      if (context.mounted) setState(() => isLoading = false);
    }
  }
}
