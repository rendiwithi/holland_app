import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:holland/data/colorData.dart';
import 'package:holland/data/static.dart';
import 'package:holland/data/textStyleData.dart';
import 'package:holland/data/variableModel.dart';
import 'package:holland/model/extra_item.dart';
import 'package:holland/model/menu_model.dart';
import 'package:holland/model/pesanan_model.dart';
import 'package:holland/screen/user/homePage.dart';
import 'package:holland/screen/user/voucher_page.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({
    Key? key,
    required this.listKeranjang,
    required this.listPesanan,
  }) : super(key: key);
  final List<Pesanan> listPesanan;
  final List<MenuModel> listKeranjang;
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int totalItem = 0;
  int totalProduct = 0;
  int totalDisc = 0;
  int totalCheckout = 0;
  int voucherIndex = 99;
  int totalExtra(List<ExtraItem> listex) {
    int result = 0;
    for (var i = 0; i < listex.length; i++) {
      if (listex[i].isSelected) {
        result += listex[i].price;
      }
    }
    return result;
  }

  totalProductCounter() {
    totalProduct = 0;
    for (var i = 0; i < widget.listPesanan.length; i++) {
      totalProduct = totalProduct + widget.listPesanan[i].hargatotal;
    }
  }

  TextEditingController addressController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  void _navigateVoucher(BuildContext context) async {
    final int result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const VoucherPage()),
    );
    voucherIndex = result;
    totalDisc = listVoucher[voucherIndex].discount;
    setState(() {});
  }

  _sendData() async {
    for (var i = 0; i < widget.listPesanan.length; i++) {
      await Pesanan.statusChange(idMenu: widget.listPesanan[i].id, status: 1);
    }
  }

  _sendDisc() async {
    await Pesanan.disc(
      idMenu: widget.listPesanan[0].id,
      harga: (widget.listPesanan[0].hargatotal - totalDisc),
    );
  }

  Future<void> _launchInBrowser() async {
    if (!await launchUrl(
      Uri.parse("https://wa.me/628176963129"),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Anda Bukan Admin';
    }
  }

  @override
  Widget build(BuildContext context) {
    totalProductCounter();
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
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text("Posisi Anda & Gerai",
                      style: TextStyle(fontSize: 18)),
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    height: 250,
                    width: 250,
                    child: FlutterMap(
                      options: MapOptions(
                        center: LatLng(-7.290985, 112.718403),
                        zoom: 15.0,
                      ),
                      layers: [
                        TileLayerOptions(
                          urlTemplate:
                              "https://tile.thunderforest.com/cycle/{z}/{x}/{y}.png?apikey=98bcad190bdc4d34af5b8fb8fe0ba0fa",
                          additionalOptions: {
                            "apikey": "98bcad190bdc4d34af5b8fb8fe0ba0fa"
                          },
                        ),
                        MarkerLayerOptions(
                          markers: [
                            Marker(
                              point: LatLng(-7.290985, 112.718403),
                              width: 80,
                              height: 80,
                              builder: (context) => Icon(
                                Icons.person_pin_circle,
                                size: 48,
                                color: Colors.orange,
                              ),
                            ),
                            Marker(
                              point: LatLng(-7.292010, 112.718133),
                              width: 80,
                              height: 80,
                              builder: (context) => Icon(
                                Icons.pin_drop,
                                size: 48,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  "lokasi Gerai: Jl Mayjend Sungkono",
                  style: mediumBlack,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listCartOrder.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(
                        top: 5,
                        bottom: 15,
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
                                  listCartOrder[index].image,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [Text("Rp. " + totalItem.toString())],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2.0,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Pesan"),
                          Text("Total Pesanan (" +
                              widget.listPesanan.length.toString() +
                              " produk)"),
                        ],
                      ),
                      Text("Rp. " + totalProduct.toString())
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2.0,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Voucher"),
                          TextButton(
                            onPressed: () {
                              _navigateVoucher(context);
                            },
                            child: (voucherIndex == 99)
                                ? Row(
                                    children: const [
                                      Text(
                                        "pilih Voucher",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.black,
                                      )
                                    ],
                                  )
                                : Text(
                                    "-" +
                                        listVoucher[voucherIndex]
                                            .discount
                                            .toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Metode Pembayaran"),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Hanya Tersedia Transfer",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total Pembayaran : "),
                    Text("Rp. " +
                        (totalCheckout + totalProduct - totalDisc).toString()),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Harap Melakukan Transfer ke nomor rek : "),
                      Text("1298570 (Holland Mayjend)"),
                      Text(
                          "SS Bukti Transfer lalu kirim ke WA Holland Di bawah"),
                    ],
                  ),
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        if (totalDisc > 0) {
                          _sendDisc();
                        }
                        _launchInBrowser();
                      },
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                          width: 3.0,
                          color: Colors.white,
                        ),
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text("Upload Foto Transaksi melalui Wa")),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
