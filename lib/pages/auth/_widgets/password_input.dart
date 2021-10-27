import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  final TextEditingController passwordController;

  const PasswordInput({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      // keyboardType: keyboardType,
      decoration: const InputDecoration(
        labelText: 'Password',
      ),
      obscureText: true,
      onChanged: (val) {},
    );
  }
}
