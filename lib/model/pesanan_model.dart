import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:holland/data/static.dart';

class Pesanan {
  int id;
  int idUser;
  int idMenu;
  int hargatotal;
  String topping;
  int harga;
  int status;
  String statusDesc;
  String keterangan;
  String userName;
  Pesanan({
    required this.id,
    required this.idUser,
    required this.idMenu,
    required this.topping,
    required this.hargatotal,
    required this.harga,
    required this.status,
    required this.statusDesc,
    required this.keterangan,
    required this.userName,
  });

  factory Pesanan.fromJson(Map<String, dynamic> object) {
    return Pesanan(
      id: object["id"],
      idMenu: object["id_detail_menu"],
      idUser: object["id_user"],
      hargatotal: object["harga"],
      status: object["status"],
      statusDesc: object["status_order"]["name"],
      userName: object["user"]["nama"],
      topping: (object["topping"] == null) ? "" : object["toping"]["title"],
      keterangan: (object["keterangan"] == null)
          ? "Tidak Ada Tambahan"
          : object["keterangan"],
      harga: (object["toping"] == null) ? 0 : object["toping"]["harga"],
    );
  }

  static Future<List<Pesanan>> connectToApi() async {
    String apiUrl = "$baseUrl/pesanan";
    List<Pesanan> listPesanan = [];
    var apiResult = await http.get(Uri.parse(apiUrl));
    var jsonObject = json.decode(apiResult.body);
    if (jsonObject['status'] == true) {
      for (var i = 0; i < jsonObject['data'].length; i++) {
        listPesanan.add(Pesanan.fromJson(jsonObject['data'][i]));
      }
    }
    print(listPesanan.length.toString());
    return listPesanan;
  }

  static Future<bool> postData({
    required int idMenu,
    required int topping,
    required int harga,
    required String keterangan,
  }) async {
    String apiUrl = "$baseUrl/pesanan";
    var apiResult = await http.post(Uri.parse(apiUrl), body: {
      "id_user": idUsr.toString(),
      "id_detail_menu": idMenu.toString(),
      "topping": (topping == 0) ? null : topping.toString(),
      "keterangan": (keterangan.isEmpty) ? null : keterangan,
      "harga": harga.toString(),
    });
    var jsonObject = json.decode(apiResult.body);

    return jsonObject['status'];
  }

  static Future<bool> statusChange({
    required int idMenu,
    required int status,
  }) async {
    String apiUrl = "$baseUrl/pesanan";
    var apiResult = await http.put(
      Uri.parse(apiUrl),
      body: {"id": idMenu.toString(), "status": status.toString()},
    );
    var jsonObject = json.decode(apiResult.body);

    return jsonObject['status'];
  }

  static Future<bool> disc({
    required int idMenu,
    required int harga,
  }) async {
    String apiUrl = "$baseUrl/pesanan/disc";
    var apiResult = await http.put(
      Uri.parse(apiUrl),
      body: {"id": idMenu.toString(), "harga": harga.toString()},
    );
    var jsonObject = json.decode(apiResult.body);

    return jsonObject['status'];
  }
}
