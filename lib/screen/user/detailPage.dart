import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holland/data/colorData.dart';
import 'package:holland/data/variableModel.dart';
import 'package:holland/logic/addExtra.dart';
import 'package:holland/logic/totalPrice.dart';
import 'package:holland/model/extra_item.dart';
import 'package:holland/model/menu_item.dart';
import 'package:holland/screen/user/cartPage.dart';
import 'package:holland/widget/extraOrder.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key? key,
    required this.menuDetail,
    required this.index,
  }) : super(key: key);
  final MenuItem menuDetail;
  final int index;
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int order = 0;
  @override
  void initState() {
    super.initState();
    listShopOrder = [];
    total = 0;
  }

  @override
  Widget build(BuildContext context) {
    // final MenuItem extra = listMenuItem[widget.index];
    addToCart() {
      listCartOrder = List.from(listCartOrder)..addAll(listShopOrder);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const CartPage(),
        ),
      );
      setState(() {});
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
                  image: NetworkImage(widget.menuDetail.imgUrl),
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
                    "Rp. " + widget.menuDetail.price.toString(),
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      widget.menuDetail.position,
                      style: const TextStyle(
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
                                    addExtraWidget(
                                      isAdd: false,
                                      index: widget.index,
                                      order: order,
                                    );
                                    total -= widget.menuDetail.price;
                                  }
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
                                  addExtraWidget(
                                    isAdd: true,
                                    index: widget.index,
                                    order: order,
                                  );
                                  total += widget.menuDetail.price;
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
                  (order >= 1)
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (context, i) {
                            MenuItem menuOrder = listShopOrder[i];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tambah Extra untuk " +
                                      listShopOrder.length.toString() +
                                      " order",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: menuOrder.extraItem.length,
                                    itemBuilder: (context, j) {
                                      return CheckboxListTile(
                                        title: Text(
                                          listShopOrder[i].extraItem[j].name +
                                              " (Rp. " +
                                              listShopOrder[i]
                                                  .extraItem[j]
                                                  .price
                                                  .toString() +
                                              ")",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        value:
                                            menuOrder.extraItem[j].isSelected,
                                        onChanged: (check) {
                                          addExtraItem(
                                              i: i, j: j, check: check!);
                                          setState(() {});
                                        },
                                      );
                                    })
                              ],
                            );
                          })
                      : Container(),
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
                            ),
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
                  if (order > 0) {
                    addToCart();
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
      ),
    );
  }
}
