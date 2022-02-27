import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? size;
  final FontWeight? weight;

  const CommonText({Key? key, this.text, this.weight, this.size, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: TextStyle(
          color: color ?? Colors.grey.shade800,
          fontSize: size,
          fontWeight: weight ?? FontWeight.w400),
    );
  }
}
