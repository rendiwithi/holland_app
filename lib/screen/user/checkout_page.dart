import 'package:flutter/material.dart';
import 'package:holland/data/colorData.dart';
import 'package:holland/data/textStyleData.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundApp,
      appBar: AppBar(
        title: const Text("Checkout Page"),
        centerTitle: true,
        backgroundColor: backgroundApp,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Alamat Pengiriman", style: boldWhite),
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xffFED2AA),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: TextField(
                      controller: addressController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Masukkan Alamat Detail Anda",
                        hintStyle: TextStyle(color: Color(0xff777777)),
                        prefixIcon: Icon(
                          Icons.golf_course_sharp,
                          color: Color(0xff777777),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  "lokasi Gerai: Jl Mayjend Sungkono",
                  style: mediumBlack,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
