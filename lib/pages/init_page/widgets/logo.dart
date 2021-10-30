import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      key: const Key('logoIcon'),
      child: const SizedBox(
        width: 150 * 1.2,
        height: 150 * 1.2,
        child: Icon(
          FontAwesomeIcons.xing,
          size: 150,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        var rect = const Rect.fromLTRB(0, 0, 150, 150);
        return const LinearGradient(
          colors: <Color>[
            Colors.red,
            Colors.blue,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ).createShader(rect);
      },
    );
  }
}
