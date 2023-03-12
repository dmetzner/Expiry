import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expiry/item/delete_item_icon_button.dart';
import 'package:expiry/item/form/discard_change_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../layout/page_loading_animation.dart';
import 'form/form_data.dart';
import 'item_form.dart';

class EditItemPage extends StatefulWidget {
  final String itemId;
  const EditItemPage({Key? key, required this.itemId}) : super(key: key);

  @override
  State<EditItemPage> createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
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
          title: Text(AppLocalizations.of(context)!.editItemAppBarTitle),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DeleteItemIconButton(itemId: widget.itemId),
            )
          ],
        ),
        body: Center(
          child: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection('products').doc(widget.itemId).get(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError || snapshot.hasData && !snapshot.data!.exists) {
                _onInitializationError(snapshot.hasError);
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return ItemForm(formData: _mapSnapShotToFormData(snapshot.data!), onChange: _onChange);
              }
              return const PageLoadingAnimation();
            },
          ),
        ),
      ),
    );
  }

  void _onInitializationError(bool hasError) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(hasError ? AppLocalizations.of(context)!.generalErrorMessage : AppLocalizations.of(context)!.itemNotFoundErrorMessage),
        ),
      );
    });
  }

  void _onChange() {
    hasChanges = true;
  }

  FormData _mapSnapShotToFormData(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    FormData formData = FormData();
    formData.setID(widget.itemId);
    formData.setBarCode(data['code']);
    formData.setName(data['name']);
    formData.setDescription(data['description']);
    if (data['expiryDate'] is Timestamp) {
      formData.setExpiryDate((data['expiryDate'] as Timestamp).toDate());
    }
    formData.setImage(data['image']);
    return formData;
  }
}
