import 'package:flutter/material.dart';
import 'package:holland/data/textStyleData.dart';

Widget cardInput({
  required TextEditingController controller,
  required String title,
  required String hint,
  required bool isSecure,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: mediumBlack),
      Container(
        margin: const EdgeInsets.only(bottom: 6, top: 8),
        padding: const EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
          color: const Color(0xffFED2AA),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: controller,
          obscureText: isSecure,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    ],
  );
}
