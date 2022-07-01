import 'package:flutter/material.dart';
import 'package:holland/data/static.dart';
import 'package:holland/model/menu_model.dart';
import 'package:holland/model/pesanan_model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<Pesanan> listPesanan = [];
  List<MenuModel> listKeranjang = [];
  _getData() async {
    await Pesanan.connectToApi().then((value) {
      listPesanan = [];
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

  _changeStatus({
    required int status,
    required int idMenu,
  }) async {
    await Pesanan.statusChange(idMenu: idMenu, status: status).then((value) {
      Navigator.pop(context);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              if (listPesanan.isEmpty) {
                return const Center(
                  child: Text("Maaf Menu Belum Tersedia"),
                );
              } else {
                return ListView.builder(
                  itemCount: listPesanan.length,
                  itemBuilder: ((context, index) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (listPesanan[index].status == 1 ||
                                listPesanan[index].status == 4)
                            ? Colors.white
                            : (listPesanan[index].status == 2)
                                ? Colors.yellow
                                : (listPesanan[index].status == 3)
                                    ? Colors.green
                                    : Colors.red,
                      ),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(listKeranjang[index].title),
                            Text(
                                "Rp. ${listPesanan[index].hargatotal.toString()}"),
                                Text(listPesanan[index].userName),
                                Text("Jl. Mayjen Sungkono, Gn. Sari")
                          ],
                        ),
                        onTap: () {
                          Alert(
                            context: context,
                            type: AlertType.info,
                            title: "Info",
                            desc: "Pilih Source Gambar",
                            buttons: [
                              DialogButton(
                                child: const Text(
                                  "Proses",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () {
                                  _changeStatus(
                                      status: 2, idMenu: listPesanan[index].id);
                                },
                                color: Colors.yellow,
                              ),
                              DialogButton(
                                child: const Text(
                                  "done",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () {
                                  _changeStatus(
                                      status: 3, idMenu: listPesanan[index].id);
                                },
                                color: Colors.green,
                              ),
                              DialogButton(
                                child: const Text(
                                  "Tolak",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () {
                                  _changeStatus(
                                      status: 5, idMenu: listPesanan[index].id);
                                },
                                color: Colors.red,
                              )
                            ],
                          ).show();
                        },
                      ),
                    );
                  }),
                );
              }
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
