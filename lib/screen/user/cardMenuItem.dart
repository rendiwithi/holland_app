import 'package:flutter/material.dart';
import 'package:holland/model/menu_item.dart';

class CardMenuItem extends StatelessWidget {
  const CardMenuItem({Key? key, required this.item}) : super(key: key);
  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: 50,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(item.imgUrl),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(item.title),
                  Text(item.price.toString()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
