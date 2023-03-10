import 'package:flutter/material.dart';

class DescriptionFormField extends StatelessWidget {
  final Function(String?) onChanged;
  final String initialValue;
  const DescriptionFormField({Key? key, required this.onChanged, this.initialValue = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.description),
        labelText: 'Description',
      ),
      initialValue: initialValue,
      onChanged: (value) {
        onChanged(value);
      },
    );
  }
}
