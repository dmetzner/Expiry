import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInFormSubmitButton extends StatelessWidget {
  final void Function() onSubmit;

  const SignInFormSubmitButton({Key? key, required this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
              onPressed: onSubmit,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(AppLocalizations.of(context)!.signInForm_SubmitButton),
              )),
        )
      ],
    );
  }
}
