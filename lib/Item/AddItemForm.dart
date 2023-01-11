import 'package:flutter/material.dart';
import 'package:householder/Item/Form/FormData.dart';
import 'package:householder/Item/Form/FormSubmitHandler.dart';
import 'package:householder/Item/Form/Field/BarCodeFormField.dart';
import 'package:householder/Item/Form/Field/DescriptionFormField.dart';
import 'package:householder/Item/Form/Field/ExpiryDateFormField.dart';
import 'package:householder/Item/Form/Field/ImageFormField.dart';
import 'package:householder/Item/Form/Field/NameFormField.dart';
import 'package:householder/Item/Form/FormSubmitButton.dart';

class AddItemForm extends StatefulWidget {
  const AddItemForm({super.key});

  @override
  State<AddItemForm> createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final _formKey = GlobalKey<FormState>();
  final FormData _formData = FormData();
  final FormSubmitHandler _formSubmitHandler = FormSubmitHandler();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Row(
              children: [
                ImageFormField(onChanged: _formData.setImage),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    children: [
                      BarCodeFormField(onChanged: _formData.setBarCode),
                      const SizedBox(height: 20),
                      NameFormField(onChanged: _formData.setName),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      ExpiryDateFormField(
                          initialDate: _formData.expiryDate,
                          onChanged: _formData.setExpiryDate
                      ),
                      const SizedBox(height: 20),
                      DescriptionFormField(
                          onChanged: _formData.setDescription
                      ),
                      const SizedBox(height: 40),
                      FormSubmitButton(
                        formKey: _formKey,
                        onSubmit: () {
                          _formSubmitHandler.submit(_formData);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}