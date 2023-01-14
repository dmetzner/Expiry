import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'SignInEmailValidator.dart';

class SignInEmailField extends StatelessWidget {
  final Function(String) onChanged;
  final String? errorText;
  const SignInEmailField({Key? key, required this.onChanged, this.errorText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email),
          labelText: AppLocalizations.of(context)!.signInEmailFieldLabelText,
          errorText: errorText),
      validator: SignInEmailValidator(context: context).validate,
      onChanged: (value) {
        onChanged(value);
      },
    );
  }
}
