import 'package:expiry/item/form/bar_code_field.dart';
import 'package:expiry/item/form/description_field.dart';
import 'package:expiry/item/form/expiry_date_field.dart';
import 'package:expiry/item/form/form_data.dart';
import 'package:expiry/item/form/image_field.dart';
import 'package:expiry/item/form/name_field.dart';
import 'package:flutter/material.dart';

import 'form/submit_button.dart';
import 'form/submit_handler.dart';

class ItemForm extends StatefulWidget {
  final FormData formData;
  final void Function() onChange;
  ItemForm({Key? key, FormData? formData, Function()? onChange})
      : formData = formData ?? FormData(),
        onChange = onChange ?? (() => {}),
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
                ImageFormField(initialValue: widget.formData.image, onChanged: _setImage),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    children: [
                      BarCodeFormField(initialValue: widget.formData.barCode, onChanged: _setBarCode),
                      const SizedBox(height: 20),
                      ExpiryDateFormField(initialDate: widget.formData.expiryDate, onChanged: _setExpiryDate),
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
                      NameFormField(initialValue: widget.formData.name, onChanged: _setName),
                      const SizedBox(height: 20),
                      DescriptionFormField(initialValue: widget.formData.description, onChanged: _setDescription),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                child: SubmitButton(
                  formKey: _formKey,
                  onSubmit: () {
                    if (widget.formData.id != null) {
                      _formSubmitHandler.editItem(widget.formData.id!, widget.formData, context);
                    } else {
                      _formSubmitHandler.addItem(widget.formData, context);
                    }
                  },
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  _setImage(String? image) {
    widget.formData.setImage(image);
    widget.onChange.call();
  }

  _setBarCode(String? barCode) {
    widget.formData.setBarCode(barCode);
    widget.onChange.call();
  }

  _setExpiryDate(DateTime? expiryDate) {
    widget.formData.setExpiryDate(expiryDate);
    widget.onChange.call();
  }

  _setName(String? name) {
    widget.formData.setName(name);
    widget.onChange.call();
  }

  _setDescription(String? description) {
    widget.formData.setDescription(description);
    widget.onChange.call();
  }
}
