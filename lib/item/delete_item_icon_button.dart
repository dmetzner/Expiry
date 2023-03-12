import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteItemIconButton extends StatefulWidget {
  final String itemId;
  const DeleteItemIconButton({Key? key, required this.itemId}) : super(key: key);

  @override
  State<DeleteItemIconButton> createState() => _DeleteItemIconButtonState();
}

class _DeleteItemIconButtonState extends State<DeleteItemIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () async {
        showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.deleteItemDialogTitle),
            content: Text(AppLocalizations.of(context)!.deleteItemDialogContent),
            actions: [
              TextButton(
                onPressed: () => _onCancelAction,
                child: Text(AppLocalizations.of(context)!.deleteItemDialogCancelButton),
              ),
              TextButton(
                onPressed: _onConfirmDelete,
                child: Text(AppLocalizations.of(context)!.deleteItemDialogConfirmButton),
              ),
            ],
          ),
        );
      },
    );
  }

  _onCancelAction() {
    Navigator.pop(context, false);
  }

  _onConfirmDelete() {
    FirebaseFirestore.instance.collection('products').doc(widget.itemId).delete();
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }
}
