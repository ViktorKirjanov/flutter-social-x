import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  final TextEditingController passwordController;
  final String? errorText;
  final Function onChanged;

  const PasswordInput({
    Key? key,
    required this.passwordController,
    required this.errorText,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: errorText,
      ),
      obscureText: true,
      onChanged: (val) => onChanged(val),
    );
  }
}
