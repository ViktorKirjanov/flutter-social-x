import 'package:flutter/material.dart';

class PrimaryOutlinedButton extends StatelessWidget {
  final String title;
  final Function action;

  const PrimaryOutlinedButton({
    Key? key,
    required this.title,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      width: double.infinity,
      child: OutlinedButton(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        onPressed: () => action(),
      ),
    );
  }
}
