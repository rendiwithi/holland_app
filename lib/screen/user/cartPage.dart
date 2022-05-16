import 'package:flutter/material.dart';
import 'package:holland/data/colorData.dart';
import 'package:holland/data/variableModel.dart';
import 'package:holland/model/extra_item.dart';
import 'package:holland/screen/user/checkout_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int totalAll = 0;
  int totalItem = 0;

  int totalExtra(List<ExtraItem> listex) {
    int result = 0;
    for (var i = 0; i < listex.length; i++) {
      if (listex[i].isSelected) {
        result += listex[i].price;
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundApp,
      appBar: AppBar(
        title: const Text("Keranjang"),
        backgroundColor: backgroundApp,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: listCartOrder.length,
                itemBuilder: (context, index) {
                  int extra = totalExtra(listCartOrder[index].extraItem);
                  totalItem = listCartOrder[index].price + extra;
                  totalAll += totalItem;
                  return Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(
                      top: 5,
                      bottom: 15,
                      left: 20,
                      right: 20,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  blurRadius: 2),
                            ],
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                listCartOrder[index].imgUrl,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(listCartOrder[index].title),
                              Text(listCartOrder[index].position),
                              (extra > 0) ? const Text("Extra :") : Container(),
                              (extra > 0)
                                  ? Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: ListView.builder(
                                          itemCount: listCartOrder[index]
                                              .extraItem
                                              .length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, yindex) {
                                            return (listCartOrder[index]
                                                    .extraItem[yindex]
                                                    .isSelected)
                                                ? Text("- " +
                                                    listCartOrder[index]
                                                        .extraItem[yindex]
                                                        .name)
                                                : Container();
                                          }),
                                    )
                                  : Container(),
                              Text("Rp. " + totalItem.toString())
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.remove,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CheckoutPage(
                            totalAll: totalAll,
                          )),
                );
              },
              child: Text("Checkout"),
            ),
          ),
        ],
      ),
    );
  }
}
