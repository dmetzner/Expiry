import 'package:flutter/material.dart';

class BarCodeFormField extends StatelessWidget {
  final Function(String?) onChanged;
  const BarCodeFormField({Key? key, required this.onChanged}) : super(key: key);

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
      onChanged: (value) {
        onChanged(value);
      },
    );
  }
}
