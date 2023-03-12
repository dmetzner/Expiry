import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubmitButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final void Function() onSubmit;

  const SubmitButton({Key? key, required this.formKey, required this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            onSubmit();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(AppLocalizations.of(context)!.saveItemButton),
        ));
  }
}
