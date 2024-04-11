import 'package:blocpractice1/features/auth/presentation/widgets/button_clipper.dart';
import 'package:flutter/material.dart';

class AUTHBUTTONS extends StatelessWidget {
  const AUTHBUTTONS({
    super.key,
    required this.label,
    required this.color,
    required this.color2,
    required this.ontap,
  });
  final Widget label;
  final Color color;
  final Color color2;
  final void Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ClipBottomRight(),
      child: InkWell(
        onTap: ontap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              color: color,
              border: Border.all(
                color: color2,
                strokeAlign: BorderSide.strokeAlignCenter,
                style: BorderStyle.solid,
              )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: label,
            // child:
          ),
        ),
      ),
    );
  }
}
