import 'package:flutter/material.dart';

class NameFormField extends StatelessWidget {
  final Function(String?) onChanged;
  final String initialValue;
  const NameFormField({Key? key, required this.onChanged, this.initialValue = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.badge),
        labelText: 'Name',
      ),
      validator: (value) {
        if (value != null && value.length > 100) {
          return 'Name must be less than 100 characters';
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
