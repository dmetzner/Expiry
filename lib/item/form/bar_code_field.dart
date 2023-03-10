import 'package:flutter/material.dart';

class BarCodeFormField extends StatelessWidget {
  final Function(String?) onChanged;
  final String initialValue;
  const BarCodeFormField({Key? key, required this.onChanged, this.initialValue = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.qr_code),
        labelText: 'Barcode',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Barcode is required';
        }
        return null;
      },
      initialValue: initialValue,
      onChanged: (value) {
        onChanged(value);
      },
    );
  }
}
