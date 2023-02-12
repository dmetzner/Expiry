import 'package:flutter/material.dart';
import 'package:expiry/Item/AddItemPage.dart';

class AddItemActionButton extends StatefulWidget {
  const AddItemActionButton({Key? key}) : super(key: key);

  @override
  State<AddItemActionButton> createState() => _AddItemActionButtonState();
}

class _AddItemActionButtonState extends State<AddItemActionButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        await Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddItemPage()));
      },
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
