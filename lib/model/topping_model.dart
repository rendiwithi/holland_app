import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:holland/data/static.dart';

class TopingModel {
  int id;
  int harga;
  String title;
  TopingModel({
    required this.id,
    required this.harga,
    required this.title,
  });

  factory TopingModel.fromJson(Map<String, dynamic> object) {
    return TopingModel(
      id: object["toping"]["id"],
      title: object["toping"]["title"],
      harga: object["toping"]["harga"],
    );
  }

  static Future<List<TopingModel>> connectToApi({required int idMenu}) async {
    String apiUrl = "$baseUrl/detail_toping";
    List<TopingModel> listBanner = [];
    var apiResult =
        await http.post(Uri.parse(apiUrl), body: {"idMenu": idMenu.toString()});
    var jsonObject = json.decode(apiResult.body);
    if (jsonObject['status'] == true) {
      for (var i = 0; i < jsonObject['data'].length; i++) {
        listBanner.add(TopingModel.fromJson(jsonObject['data'][i]));
      }
    }

    return listBanner;
  }
}
