import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordFieldValidator {
  final BuildContext _context;
  const PasswordFieldValidator({required BuildContext context}) : _context = context;

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(_context)!.signInForm_PasswordField_ValidationError_PasswordRequired;
    }
    return null;
  }
}
