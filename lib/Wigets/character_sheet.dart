import 'package:flutter/material.dart';

class CharacterSheet extends StatelessWidget {
  const CharacterSheet({super.key, required this.url, required this.name});
  final String url;
  final String name;
  @override
  Widget build(BuildContext context) {
    final double imageWidth=MediaQuery.of(context).size.width*0.5;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.contain
              )
            ),
          ),
        ),
        SizedBox(height: 8,),
        Text(name,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),)
      ],
    );
  }
}
