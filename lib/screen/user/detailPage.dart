import 'package:flutter/material.dart';
import 'package:holland/data/colorData.dart';
import 'package:holland/data/variableModel.dart';
import 'package:holland/widget/extraOrder.dart';
import 'package:holland/widget/extraWidgetOrder.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int order = 0;
  List<ExtraOrder> listOrders = [];
  List<Widget> listExtraWidget = [];

  @override
  Widget build(BuildContext context) {
    addExtraWidget() async {
      listExtraWidget = [];
      listOrders = [];
      for (var i = 0; i < order; i++) {
        listOrders = [];
        for (var j = 0; j < listExtra.length; j++) {
          listOrders.add(ExtraOrder(index: j));
        }
        listExtraWidget
            .add(ExtraWidgetOrder(index: i + 1, extraOrders: listOrders));
      }
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
              padding: EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    "https://i.pinimg.com/564x/b7/83/e5/b783e50c98526b8bea753e9ae3eac1f4.jpg",
                  ),
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
                  Text("Terang Bulan "),
                  Text("Rp. 25.000"),
                  Text("Jl Mayjend Sungkono, Surabaya"),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Jumlah"),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                if (order > 0) {
                                  order--;
                                }
                                await addExtraWidget();
                                setState(() {});
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(color: Colors.blue),
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
                                decoration: BoxDecoration(color: Colors.blue),
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
                  const Text("Extra"),
                  Column(
                    children: listExtraWidget,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 20, left: 25, right: 25),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Tambahkan Ke keranjang"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
