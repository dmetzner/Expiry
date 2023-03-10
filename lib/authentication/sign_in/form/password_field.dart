import 'package:expiry/authentication/sign_in/form/password_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordField extends StatefulWidget {
  final Function(String) onChanged;
  final String? errorText;
  const PasswordField({Key? key, required this.onChanged, this.errorText}) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscureText,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        errorText: widget.errorText,
        prefixIcon: const Icon(Icons.lock),
        labelText: AppLocalizations.of(context)!.signInForm_PasswordField_LabelText,
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
      validator: PasswordFieldValidator(context: context).validate,
      onChanged: (value) {
        widget.onChanged(value);
      },
    );
  }
}
