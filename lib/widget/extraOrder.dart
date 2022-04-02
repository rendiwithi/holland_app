import 'package:flutter/material.dart';
import 'package:holland/data/variableModel.dart';

class ExtraOrder extends StatefulWidget {
  const ExtraOrder({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<ExtraOrder> createState() => _ExtraOrderState();
}

class _ExtraOrderState extends State<ExtraOrder> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        listExtra[widget.index].name,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      value: listExtra[widget.index].isSelected,
      onChanged: (check) {
        setState(() {
          listExtra[widget.index].isSelected = check!;
        });
      },
    );
  }
}
