import 'package:expiry/item/form/bar_code_field.dart';
import 'package:expiry/item/form/description_field.dart';
import 'package:expiry/item/form/expiry_date_field.dart';
import 'package:expiry/item/form/form_data.dart';
import 'package:expiry/item/form/image_field.dart';
import 'package:expiry/item/form/name_field.dart';
import 'package:expiry/item/form/submit_button.dart';
import 'package:flutter/material.dart';

import 'form/submit_handler.dart';

class ItemForm extends StatefulWidget {
  final FormData formData;
  ItemForm({Key? key, FormData? formData})
      : formData = formData ?? FormData(),
        super(key: key);

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final _formKey = GlobalKey<FormState>();
  final SubmitHandler _formSubmitHandler = SubmitHandler();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
        child: Column(
          children: [
            Row(
              children: [
                ImageFormField(initialValue: widget.formData.image, onChanged: widget.formData.setImage),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    children: [
                      BarCodeFormField(initialValue: widget.formData.barCode, onChanged: widget.formData.setBarCode),
                      const SizedBox(height: 20),
                      NameFormField(initialValue: widget.formData.name, onChanged: widget.formData.setName),
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
                      ExpiryDateFormField(initialDate: widget.formData.expiryDate, onChanged: widget.formData.setExpiryDate),
                      const SizedBox(height: 20),
                      DescriptionFormField(initialValue: widget.formData.description, onChanged: widget.formData.setDescription),
                      const SizedBox(height: 40),
                      SubmitButton(
                        formKey: _formKey,
                        onSubmit: () {
                          if (widget.formData.id != null) {
                            _formSubmitHandler.editItem(widget.formData.id!, widget.formData, context);
                          } else {
                            _formSubmitHandler.addItem(widget.formData, context);
                          }
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
