import 'package:flutter/material.dart';
import 'package:holland/data/colorData.dart';
import 'package:holland/data/textStyleData.dart';
import 'package:holland/data/variableModel.dart';
import 'package:holland/model/extra_item.dart';
import 'package:holland/screen/user/voucher_page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key, required this.totalAll}) : super(key: key);
  final int totalAll;
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int totalItem = 0;
  int totalProduct = 0;
  int totalOngkir = 15000;
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

  totalProductCounter(int totalAll) {
    totalProduct = 0;
    totalProduct = totalProduct + totalAll;
  }

  TextEditingController addressController = TextEditingController();
  @override
  void initState() {
    super.initState();
    totalCheckout = totalOngkir;
  }

  void _navigateVoucher(BuildContext context) async {
    final int result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const VoucherPage()),
    );
    voucherIndex = result;
    totalCheckout = totalOngkir - listVoucher[voucherIndex].discount;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    totalProductCounter(widget.totalAll);
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
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xffFED2AA),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: TextField(
                      controller: addressController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Masukkan Alamat Detail Anda",
                        hintStyle: TextStyle(color: Color(0xff777777)),
                        prefixIcon: Icon(
                          Icons.pin_drop,
                          color: Color(0xff777777),
                        ),
                      ),
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
                    // int extra = totalExtra(listCartOrder[index].extraItem);
                    // totalItem = listCartOrder[index].price + extra;
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
                              children: [
                                Text(listCartOrder[index].title),
                                // Text(listCartOrder[index].position),
                                // (extra > 0)
                                //     ? const Text("Extra :")
                                //     : Container(),
                                // (extra > 0)
                                //     ? Padding(
                                //         padding:
                                //             const EdgeInsets.only(left: 20),
                                //         child: ListView.builder(
                                //             itemCount: listCartOrder[index]
                                //                 .extraItem
                                //                 .length,
                                //             shrinkWrap: true,
                                //             itemBuilder: (context, yindex) {
                                //               return (listCartOrder[index]
                                //                       .extraItem[yindex]
                                //                       .isSelected)
                                //                   ? Text("- " +
                                //                       listCartOrder[index]
                                //                           .extraItem[yindex]
                                //                           .name)
                                //                   : Container();
                                //             }),
                                //       )
                                //     : Container(),
                                Text("Rp. " + totalItem.toString())
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const Text("Opsi Pengiriman"),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
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
                        children: const [
                          Text("Reguler"),
                          Text("Jarak 1Km = Rp.5000"),
                        ],
                      ),
                      Text("Rp. " + totalOngkir.toString())
                    ],
                  ),
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
                              listCartOrder.length.toString() +
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
                            child: Row(
                              children: const [
                                Text(
                                  "pilih pembayaran",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                )
                              ],
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
                    Text("Rp. " + (totalCheckout + totalProduct).toString()),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
