import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthIcon extends StatelessWidget {
  final IconData iconData;

  const AuthIcon({
    Key? key,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withAlpha(75),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: FaIcon(
          iconData,
          size: 50.0,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
