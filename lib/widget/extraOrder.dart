import 'package:flutter/material.dart';
import 'package:holland/data/variableModel.dart';

import '../model/extra_item.dart';

class ExtraOrder extends StatefulWidget {
  const ExtraOrder({Key? key, required this.extra, required this.idMenu})
      : super(key: key);
  final ExtraItem extra;
  final int idMenu;

  @override
  State<ExtraOrder> createState() => _ExtraOrderState();
}

class _ExtraOrderState extends State<ExtraOrder> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        widget.extra.name + " (Rp. " + widget.extra.price.toString() + ")",
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      value: widget.extra.isSelected,
      onChanged: (check) {
        setState(() {
          widget.extra.isSelected = check!;
        });
      },
    );
  }
}
