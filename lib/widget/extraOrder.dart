// import 'package:flutter/material.dart';
// import 'package:holland/data/variableModel.dart';
// import 'package:holland/logic/totalPrice.dart';

// import '../model/extra_item.dart';

// class ExtraOrder extends StatefulWidget {
//   const ExtraOrder({
//     Key? key,
//     required this.index,
//     required this.idExtra,
//   }) : super(key: key);
//   final int index;
//   final int idExtra;
//   @override
//   State<ExtraOrder> createState() => _ExtraOrderState();
// }

// class _ExtraOrderState extends State<ExtraOrder> {
//   @override
//   Widget build(BuildContext context) {
//     int index = widget.index;
//     int idExtra = widget.idExtra;
//     var extra = listShopOrder[index].extraItem[idExtra];
//     return CheckboxListTile(
//       title: Text(
//         extra.name + " (Rp. " + extra.price.toString() + ")",
//         style: const TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.w600,
//           letterSpacing: 0.5,
//         ),
//       ),
//       value: extra.isSelected,
//       onChanged: (check) {
//         extra.isSelected = check!;
//         // totalPrice(index, idExtra, widget.order);
//         setState(() {});
//       },
//     );
//   }
// }
