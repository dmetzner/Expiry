import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpiryDateFormField extends StatelessWidget {
  final Function(DateTime?) onChanged;
  final DateTime initialDate;

  const ExpiryDateFormField(
      {Key? key, required this.onChanged, required this.initialDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = initialDate;

    return TextFormField(
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.calendar_today),
        labelText: 'Expiry Date',
      ),
      onTap: () async {
        date = await showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            ) ??
            date;
        onChanged(date);
      },
      controller:
          TextEditingController(text: DateFormat('dd-MM-yyyy').format(date)),
      readOnly: true,
    );
  }
}
