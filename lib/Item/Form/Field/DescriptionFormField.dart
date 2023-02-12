import 'package:flutter/material.dart';

class DescriptionFormField extends StatelessWidget {
  final Function(String?) onChanged;
  const DescriptionFormField({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.description),
        labelText: 'Description',
      ),
      onChanged: (value) {
        onChanged(value);
      },
    );
  }
}
