import 'package:flutter/material.dart';

class PrimaryOutlinedLoadingButton extends StatelessWidget {
  const PrimaryOutlinedLoadingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      width: double.infinity,
      child: OutlinedButton(
        child: const CircularProgressIndicator(),
        onPressed: () {},
      ),
    );
  }
}
