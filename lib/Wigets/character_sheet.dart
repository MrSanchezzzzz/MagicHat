import 'package:flutter/material.dart';

class CharacterSheet extends StatefulWidget {
  const CharacterSheet({
    super.key,
    required this.url,
    required this.name,
  });

  final String url;
  final String name;

  @override
  _CharacterSheetState createState() => _CharacterSheetState();
}

class _CharacterSheetState extends State<CharacterSheet>{
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final double imageWidth = MediaQuery.of(context).size.width * 0.5;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.url),
                fit: BoxFit.contain,
              ),
            ),
            width: imageWidth,
          ),
        ),
        Text(
          widget.name,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
