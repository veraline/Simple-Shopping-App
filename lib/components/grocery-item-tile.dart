import 'package:flutter/material.dart';
import 'package:shopping_app/Screens/item-detail-screen.dart';

class GroceryItemTile extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final String imagePath;
  final color;
  final String description;
  final void Function() onPressed;
  final int index;
  const GroceryItemTile(
      {super.key,
      required this.itemName,
      required this.itemPrice,
      required this.imagePath,
      required this.color,
      required this.description,
      required this.onPressed,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ItemDetailScreen(
          itemName: itemName,
          itemPrice: itemPrice,
          imagePath: imagePath,
          color: color,
          description: description,
          index: index,

        )));
      },
      
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: color[100], borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //image
              Image.asset(
                imagePath,
                height: 64,
              ),

              //itemName
              Text(itemName),

              //price and button
              MaterialButton(
                  onPressed: onPressed,
                  color: color[800],
                  child: Text(
                    '\$$itemPrice',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
