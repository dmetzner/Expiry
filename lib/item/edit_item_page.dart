import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../layout/page_loading_animation.dart';
import 'form/form_data.dart';
import 'item_form.dart';

class EditItemPage extends StatelessWidget {
  final String id;
  const EditItemPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.editItemAppBarTitle)),
      body: Center(
        child: FutureBuilder<DocumentSnapshot>(
          // Get the data from Firebase using the ID
          future: FirebaseFirestore.instance.collection('products').doc(id).get(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }
            if (snapshot.hasData && !snapshot.data!.exists) {
              return Text("This item does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return ItemForm(formData: _mapSnapShotToFormData(snapshot.data!));
            }
            return const PageLoadingAnimation();
          },
        ),
      ),
    );
  }

  FormData _mapSnapShotToFormData(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    FormData formData = FormData();
    formData.setID(id);
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
