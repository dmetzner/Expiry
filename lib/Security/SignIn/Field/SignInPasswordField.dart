import 'package:flutter/material.dart';

class SignInPasswordField extends StatefulWidget {
  final Function(String) onChanged;
  const SignInPasswordField({Key? key, required this.onChanged})
      : super(key: key);

  @override
  State<SignInPasswordField> createState() => _SignInPasswordFieldState();
}

class _SignInPasswordFieldState extends State<SignInPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscureText,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock),
        labelText: 'Password',
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is required';
        }
        return null;
      },
      onChanged: (value) {
        widget.onChanged(value);
      },
    );
  }
}
