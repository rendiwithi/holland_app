import 'package:flutter/material.dart';
import 'package:holland/data/colorData.dart';
import 'package:holland/data/static.dart';
import 'package:holland/data/variableModel.dart';
import 'package:holland/logic/addExtra.dart';
import 'package:holland/model/menu_item.dart';
import 'package:holland/model/menu_model.dart';
import 'package:holland/model/pesanan_model.dart';
import 'package:holland/model/topping_model.dart';
import 'package:holland/screen/user/cartPage.dart';
import 'package:holland/screen/user/homePage.dart';
import 'package:holland/widget/cardInput.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key? key,
    required this.menuDetail,
    required this.index,
  }) : super(key: key);
  final MenuModel menuDetail;
  final int index;
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int order = 0;
  List<TopingModel> listToping = [];
  TextEditingController extraController = TextEditingController();

  @override
  void initState() {
    super.initState();
    listShopOrder = [];
    total = 0;
  }

  @override
  Widget build(BuildContext context) {
    _getData() async {
      listToping = [];
      await TopingModel.connectToApi(idMenu: widget.menuDetail.id)
          .then((value) {
        listToping = value;
      });
    }

    _sendData({required int harga}) async {
      await Pesanan.postData(
          idMenu: widget.menuDetail.id,
          topping: toping,
          keterangan: extraController.text,
          harga: harga);
    }

    addToCart() {
      for (var i = 0; i < order; i++) {
        _sendData(harga: total ~/ order);
      }
      listCartOrder = List.from(listCartOrder)..addAll(listShopOrder);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
      setState(() {});
    }

    var sizeApp = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundApp,
      body: FutureBuilder(
          future: _getData(),
          builder: (context, snapshot) {
            return SafeArea(
              child: ListView(
                children: [
                  Container(
                    height: 200,
                    width: sizeApp.width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.menuDetail.image),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey,
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(20),
                    width: sizeApp.width - 40,
                    decoration: BoxDecoration(
                      color: boxInput,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.menuDetail.title,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Rp. " + widget.menuDetail.harga.toString(),
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            "Jln Raya Nginden no.34",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          widget.menuDetail.desc,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Jumlah"),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (order > 0) {
                                        order--;
                                        total -= widget.menuDetail.harga;
                                      }
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      margin: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                          color: Colors.blue),
                                      child: const Icon(
                                        Icons.remove,
                                        size: 24,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(order.toString()),
                                  GestureDetector(
                                    onTap: () {
                                      order++;
                                      for (var i = 0;
                                          i < listToping.length;
                                          i++) {}
                                      // addExtraWidget(
                                      //   isAdd: true,
                                      //   index: widget.index,
                                      //   order: order,
                                      // );
                                      total += widget.menuDetail.harga;
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      margin: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                          color: Colors.blue),
                                      child: const Icon(
                                        Icons.add,
                                        size: 24,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        (order >= 1)
                            ? const Text(
                                "Extra",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Container(),
                        (order >= 1)
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: listToping.length,
                                itemBuilder: (context, index) {
                                  return CheckboxListTile(
                                    title: Text(
                                      listToping[index].title +
                                          " (Rp. " +
                                          listToping[index].harga.toString() +
                                          ")",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    value: (listToping[index].id == toping),
                                    onChanged: (check) {
                                      setState(() {
                                        if (check == true) {
                                          toping = listToping[index].id;
                                          total = total +
                                              (order * listToping[index].harga);
                                        } else {
                                          toping = 0;
                                          total = total -
                                              (order * listToping[index].harga);
                                        }
                                      });
                                    },
                                  );
                                },
                              )
                            : Container(),
                        (order >= 1)
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Total",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Rp. " + total.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                        (order >= 1)
                            ? cardInput(
                                controller: extraController,
                                title: "Keterangan",
                                hint: "contoh: extra plastik ya...",
                                isSecure: false)
                            : Container(),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(bottom: 20, left: 25, right: 25),
                    child: ElevatedButton(
                      onPressed: () {
                        if (order > 0) {
                          addToCart();
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      child: (order >= 1)
                          ? const Text("Tambahkan Ke keranjang")
                          : const Text("Hapus pilihan"),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        primary: (order >= 1) ? Colors.blue : Colors.red,
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
