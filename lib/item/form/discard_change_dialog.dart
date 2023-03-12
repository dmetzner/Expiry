import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiscardChangeDialog extends StatelessWidget {
  const DiscardChangeDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.discardChangesDialogTitle),
      content: Text(AppLocalizations.of(context)!.discardChangesDialogContent),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(AppLocalizations.of(context)!.discardChangesDialogCancelButton),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(AppLocalizations.of(context)!.discardChangesDialogConfirmButton),
        ),
      ],
    );
  }
}
