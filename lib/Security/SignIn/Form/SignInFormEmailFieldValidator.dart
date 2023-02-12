import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInFormEmailFieldValidator {
  final BuildContext _context;
  const SignInFormEmailFieldValidator({required BuildContext context}) : _context = context;

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(_context)!.signInForm_EmailField_ValidationError_EmailRequired;
    }
    if (!isEmailFormatValid(value)) {
      return AppLocalizations.of(_context)!.signInForm_EmailField_ValidationError_EmailInvalid;
    }
    return null;
  }

  bool isEmailFormatValid(String? email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email!);
  }
}
