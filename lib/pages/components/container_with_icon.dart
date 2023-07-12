
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContainerWithIcon extends StatelessWidget {
  const ContainerWithIcon({
    this.color = Colors.red,
    required this.icon,
    super.key,
    this.alignment = Alignment.centerLeft,
  });

  final Color color;
  final Icon icon;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: icon,
      ),
    );
  }
}
