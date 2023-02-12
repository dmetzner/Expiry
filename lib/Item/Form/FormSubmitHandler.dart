import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expiry/Item/Form/FormData.dart';

class FormSubmitHandler {
  FirebaseFirestore db = FirebaseFirestore.instance;

  void submit(FormData formData) async {
    final product = <String, dynamic>{
      "code": formData.barCode,
      "name": formData.name,
      "description": formData.description,
      "expiryDate": formData.expiryDate,
    };
    db
        .collection("products")
        .add(product)
        .then((DocumentReference doc) => print('DocumentSnapshot added with ID: ${doc.id}'));
  }
}