import 'package:flutter/material.dart';
import 'package:holland/data/variableModel.dart';

class TotalDetail extends StatelessWidget {
  const TotalDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String totalPrice() {
      for (var i = 0; i < listShopOrder.length; i++) {
        for (var j = 0; j < listShopOrder[i].extraItem.length; j++) {
          total += listShopOrder[i].extraItem[j].price;
        }
      }
      String ttl = "Rp. " + total.toString();
      return ttl;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Total",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          totalPrice(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
