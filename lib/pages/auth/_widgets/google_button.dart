import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoogleButton extends StatelessWidget {
  final Function action;

  const GoogleButton({
    Key? key,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54.0,
      width: double.infinity,
      child: TextButton.icon(
        label: const Text(
          "Login with Google",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        icon: const FaIcon(FontAwesomeIcons.google),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color.fromRGBO(215, 103, 53, 1),
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
              const Color.fromRGBO(251, 239, 227, 1)),
          overlayColor: MaterialStateProperty.all<Color>(
              const Color.fromRGBO(234, 198, 164, 1)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        onPressed: () => action,
      ),
    );
  }
}
