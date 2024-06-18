
import 'package:flutter/material.dart';
import 'package:magic_hat/models/personage.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.personage});
  final Personage personage;
  @override
  Widget build(BuildContext context) {
    int attempts=personage.attempts;
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        height: MediaQuery.of(context).size.height*0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  Image.network(personage.image,
                    width: MediaQuery.of(context).size.height*0.075,
                    height: MediaQuery.of(context).size.height*0.1,
                    fit: BoxFit.fill,),
                  SizedBox(width: 8,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(personage.name,style: TextStyle(fontSize: 18),),
                      Text("Attempts:$attempts")
                    ],
                  ),
                ],
              ),
              Row(children: [
                personage.isGuessedCorrect?
                IconButton(icon:Icon(Icons.add),onPressed: (){},)
                    :IconButton(onPressed: (){}, icon: Icon(Icons.calculate_rounded))
              ],)

            ]
        ),
      )
      ,);
  }
}
