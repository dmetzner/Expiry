import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInEmailValidator {
  final BuildContext _context;
  const SignInEmailValidator({required BuildContext context}) : _context = context;

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(_context)!.signInEmailFieldValidationErrorEmailRequired;
    }
    if (!isEmailFormatValid(value)) {
      return AppLocalizations.of(_context)!.signInEmailFieldValidationErrorEmailInvalid;
    }
    return null;
  }

  bool isEmailFormatValid(String? email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email!);
  }
}
