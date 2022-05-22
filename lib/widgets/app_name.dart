import 'package:flutter/material.dart';

class AppName extends StatelessWidget {
  const AppName({
    this.fontSize=28,
    Key? key
  }) : super(key: key);
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: fontSize,
        ),
        children: const <InlineSpan>[
          TextSpan(
            text: 'CareShare',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          TextSpan(text: 'EyeWear'),
        ],
      ),
    );
  }
}
