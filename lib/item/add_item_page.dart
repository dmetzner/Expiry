import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'form/discard_change_dialog.dart';
import 'item_form.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({Key? key}) : super(key: key);

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  bool hasChanges = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (hasChanges) {
          final result = await showDialog<bool>(context: context, builder: (context) => const DiscardChangeDialog());
          return result ?? false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.addItemAppBarTitle),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[ItemForm(onChange: _onChange)],
        ),
      ),
    );
  }

  void _onChange() {
    hasChanges = true;
  }
}
