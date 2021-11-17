import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PopButton extends StatelessWidget {
  const PopButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16.0,
      left: 16.0,
      child: SafeArea(
        child: IconButton(
          key: const Key('popButtonKey'),
          icon: FaIcon(
            FontAwesomeIcons.arrowLeft,
            size: 25.0,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
