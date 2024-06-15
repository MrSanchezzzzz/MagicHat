import 'package:flutter/material.dart';

class HouseButton extends StatelessWidget {
  const HouseButton({super.key, required this.house, required this.onTap});
  final String house;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    final double imageSize = MediaQuery.of(context).size.width * 0.225;
    final url='Images/$house.png';
    return InkWell(
      onTap: onTap,
      child: Ink.image(
        image: AssetImage(
          url,
        ),
        height: imageSize,
        width: imageSize,
      ),
    );
  }
}
