import 'package:flutter/material.dart';
import 'package:holland/data/colorData.dart';
import 'package:holland/data/static.dart';
import 'package:holland/model/extra_item.dart';
import 'package:holland/model/menu_model.dart';
import 'package:holland/model/pesanan_model.dart';
import 'package:holland/screen/user/checkout_page.dart';
import 'package:holland/screen/user/profile_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int totalAll = 0;
  int totalItem = 0;
  List<Pesanan> listPesanan = [];
  List<MenuModel> listKeranjang = [];
  int totalExtra(List<ExtraItem> listex) {
    int result = 0;
    for (var i = 0; i < listex.length; i++) {
      if (listex[i].isSelected) {
        result += listex[i].price;
      }
    }
    return result;
  }

  _getDataApi() async {
    await Pesanan.connectToApi().then((value) {
      listPesanan = value;
      String title = "";
      String desc = "";
      String img = "";
      int harga = 0;
      for (var i = 0; i < listPesanan.length; i++) {
        for (var y = 0; y < listMenu.length; y++) {
          if (listMenu[y].id == listPesanan[i].idMenu) {
            title = listMenu[y].title;
            desc = listMenu[y].desc;
            harga = listMenu[y].harga;
            img = listMenu[y].image;
            y = listMenu.length;
          }
        }
        listKeranjang.add(
          MenuModel(
            id: listPesanan[i].id,
            title: title,
            desc: desc,
            harga: (listPesanan[i].harga == 0)
                ? harga
                : harga + listPesanan[i].harga,
            image: img,
          ),
        );
      }
    });
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
      body: FutureBuilder(
          future: _getDataApi(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                if (listKeranjang.isEmpty||listPesanan.isEmpty) {
                  return const Center(
                    child: Text("Maaf Banner Belum Tersedia"),
                  );
                } else {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: listKeranjang.length,
                            itemBuilder: (context, index) {
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
                                              color:
                                                  Colors.black.withOpacity(0.4),
                                              blurRadius: 2),
                                        ],
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            listKeranjang[index].image,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(listKeranjang[index].title),
                                          const Text("Jln. Mayjend Sungkono"),
                                          (listPesanan[index].topping != "")
                                              ? const Text("Extra :")
                                              : Container(),
                                          (listPesanan[index].topping != "")
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20),
                                                  child: Text(
                                                    "- " +
                                                        listPesanan[index]
                                                            .topping,
                                                  ),
                                                )
                                              : Container(),
                                          Text("Rp. " +
                                              listPesanan[index]
                                                  .hargatotal
                                                  .toString())
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
                          style: ElevatedButton.styleFrom(
                            primary: (listKeranjang.isNotEmpty)
                                ? Colors.blue
                                : Colors.red,
                          ),
                          onPressed: () {
                            (listPesanan[0].status == 1)
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ProfilePage(),
                                    ),
                                  )
                                : (listKeranjang.isNotEmpty)
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CheckoutPage(
                                                  listKeranjang: listKeranjang,
                                                  listPesanan: listPesanan,
                                                )),
                                      )
                                    : Navigator.pop(context);
                          },
                          child: Text((listPesanan[0].status == 1)
                              ? "Cek Pesanan"
                              : (listKeranjang.isNotEmpty)
                                  ? "Checkout"
                                  : "Beli Produk"),
                        ),
                      ),
                    ],
                  );
                }
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
