import 'package:flutter/material.dart';
import 'package:holland/data/colorData.dart';
import 'package:holland/data/variableModel.dart';
import 'package:holland/logic/totalPrice.dart';
import 'package:holland/model/menu_item.dart';
import 'package:holland/widget/extraOrder.dart';
import 'package:holland/widget/extraWidgetOrder.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.item}) : super(key: key);
  final MenuItem item;
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int order = 0;
  List<ExtraOrder> listOrders = [];
  List<Widget> listExtraWidget = [];
  int totalPrice = 0;
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    addExtraWidget() {
      listExtraWidget = [];
      listOrders = [];
      listShopOrder = [];
      for (var i = 0; i < order; i++) {
        listOrders = [];
        listShopOrder.add(widget.item);
        for (var j = 0; j < widget.item.extraItem.length; j++) {
          listOrders.add(ExtraOrder(
            index: i,
            idExtra: j,
            order: order,
          ));
        }
        listExtraWidget
            .add(ExtraWidgetOrder(index: i + 1, extraOrders: listOrders));
      }
      totalPriceAll();
    }

    var sizeApp = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundApp,
      body: SafeArea(
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
                  image: NetworkImage(widget.item.imgUrl),
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
              decoration: BoxDecoration(
                color: boxInput,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.title,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Rp. " + widget.item.price.toString(),
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      widget.item.position,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Text(
                    widget.item.desc,
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
                                  }
                                  addExtraWidget();
                                  setState(() {});
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  margin: const EdgeInsets.all(8),
                                  decoration:
                                      const BoxDecoration(color: Colors.blue),
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
                                  addExtraWidget();
                                  setState(() {});
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  margin: const EdgeInsets.all(8),
                                  decoration:
                                      const BoxDecoration(color: Colors.blue),
                                  child: const Icon(
                                    Icons.add,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        total += 1;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: listExtraWidget,
                      ),
                    ),
                  ),
                  (order >= 1)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            )
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 20, left: 25, right: 25),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {});
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
      ),
    );
  }
}
