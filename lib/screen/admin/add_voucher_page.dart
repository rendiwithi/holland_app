import 'package:flutter/material.dart';
import 'package:holland/data/colorData.dart';
import 'package:holland/widget/cardInput.dart';

class AddVoucherPage extends StatefulWidget {
  const AddVoucherPage({Key? key}) : super(key: key);

  @override
  State<AddVoucherPage> createState() => _AddVoucherPageState();
}

class _AddVoucherPageState extends State<AddVoucherPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController imgController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Voucher"),
        backgroundColor: backgroundApp,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: cardInput(
                controller: titleController,
                title: "Nama menu",
                hint: "Masukkan Menu baru",
                isSecure: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: cardInput(
                controller: positionController,
                title: "Alamat toko",
                hint: "Masukkan alamat toko menu",
                isSecure: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: cardInput(
                controller: titleController,
                title: "Nama menu",
                hint: "Masukkan Menu baru",
                isSecure: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: cardInput(
                controller: titleController,
                title: "Deskripsi menu",
                hint: "Masukkan deskripsi menu",
                isSecure: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: cardInput(
                controller: titleController,
                title: "Harga menu",
                hint: "Masukkan Harga menu",
                isSecure: false,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const BannerPage()),
                    // );
                    // listMenuItem.add(
                    //   MenuItem(
                    //     id: listMenuItem.length,
                    //     title: "title",
                    //     position: "position",
                    //     imgUrl: "imgUrl",
                    //     desc: "desc",
                    //     price: 1,
                    //     extraItem: listExtraAsin,
                    //   ),
                    // );
                  },
                  child: const Text("Tambah Menu"),
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      width: 3.0,
                      color: Colors.white,
                    ),
                    fixedSize: const Size(300, 60),
                    primary: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
