import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'SignInFormEmailFieldValidator.dart';

class SignInFormEmailField extends StatelessWidget {
  final Function(String) onChanged;
  final String? errorText;
  const SignInFormEmailField({Key? key, required this.onChanged, this.errorText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email),
          labelText: AppLocalizations.of(context)!.signInForm_EmailField_LabelText,
          errorText: errorText),
      validator: SignInFormEmailFieldValidator(context: context).validate,
      onChanged: (value) {
        onChanged(value);
      },
    );
  }
}
