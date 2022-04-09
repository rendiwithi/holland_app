import 'package:flutter/material.dart';
import 'package:holland/widget/extraOrder.dart';

class ExtraWidgetOrder extends StatefulWidget {
  const ExtraWidgetOrder(
      {Key? key, required this.index, required this.extraOrders})
      : super(key: key);
  final List<Widget> extraOrders;
  final int index;
  @override
  State<ExtraWidgetOrder> createState() => _ExtraWidgetOrderState();
}

class _ExtraWidgetOrderState extends State<ExtraWidgetOrder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pesanan ke-" + widget.index.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Column(
          children: widget.extraOrders,
        )
      ],
    );
  }
}
