import 'package:flutter/material.dart';
import 'package:holland/data/colorData.dart';
import 'package:holland/data/variableModel.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundApp,
      appBar: AppBar(
        title: const Text("Keranjang"),
        backgroundColor: backgroundApp,
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return Container();
          }),
    );
  }
}
