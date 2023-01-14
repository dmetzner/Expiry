import 'package:expiry/Item/AddItemForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddItemPage extends StatelessWidget {
  const AddItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addItemAppBarTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const <Widget>[AddItemForm()],
      ),
    );
  }
}
