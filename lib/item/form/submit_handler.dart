import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expiry/item/form/form_data.dart';
import 'package:flutter/material.dart';

class SubmitHandler {
  CollectionReference products = FirebaseFirestore.instance.collection('products');

  void addItem(FormData formData, BuildContext context) async {
    final product = _buildProduct(formData);
    products.add(product).then((docRef) => Navigator.pop(context));
  }

  void editItem(String id, FormData formData, BuildContext context) async {
    final product = _buildProduct(formData);
    products.doc(id).update(product).then((docRef) => Navigator.pop(context));
  }

  void deleteItem(String id, BuildContext context) async {
    products.doc(id).delete().then((docRef) => Navigator.pop(context));
  }

  _buildProduct(FormData formData) {
    return <String, dynamic>{
      "code": formData.barCode,
      "name": formData.name,
      "description": formData.description,
      "expiryDate": formData.expiryDate,
      "image": formData.image,
    };
  }
}
