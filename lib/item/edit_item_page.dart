import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../layout/page_loading_animation.dart';
import 'form/form_data.dart';
import 'item_form.dart';

class EditItemPage extends StatelessWidget {
  final String id;
  const EditItemPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(id),
      ),
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
              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
              FormData formData = FormData();
              formData.id = id;
              formData.barCode = data['code'];
              formData.name = data['name'];
              formData.description = data['description'];
              // formData.expiryDate = data['expiryDate'];
              formData.image = data['image'];
              return ItemForm(formData: formData);
            }
            return const PageLoadingAnimation();
          },
        ),
      ),
    );
  }
}
