import 'package:flutter/material.dart';

class BorderedContainer extends StatelessWidget {
  BorderedContainer({super.key, this.child,this.height,this.width});
  final Widget? child;
  double? height;
  double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.amber[900]??Colors.amber
        ),
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      child: child,
    );
  }
}
