import 'package:flutter/material.dart';
import 'package:holland/data/textStyleData.dart';

Widget cardInput({
  required String title,
  required TextEditingController controller,
  required String hint,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: mediumBlack),
      Container(
        margin: const EdgeInsets.only(bottom: 6, top: 8),
        decoration: BoxDecoration(
          color: const Color(0xffFED2AA),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xff777777)),
            prefixIcon: const Icon(
              Icons.lock,
              color: Color(0xff777777),
            ),
          ),
        ),
      ),
    ],
  );
}
