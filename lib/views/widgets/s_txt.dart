import 'package:flutter/material.dart';

class STxt extends StatelessWidget {
  final String txt;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;

  const STxt({Key? key, required this.txt, this.style, this.textAlign, this.maxLines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      txt,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}
