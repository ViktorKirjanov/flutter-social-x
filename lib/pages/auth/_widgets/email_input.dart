import 'package:flutter/material.dart';

class EmailInput extends StatelessWidget {
  final TextEditingController emailController;

  const EmailInput({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      // keyboardType: keyboardType,
      decoration: const InputDecoration(
        labelText: 'Email',
      ),
      onChanged: (val) {},
    );
  }
}
