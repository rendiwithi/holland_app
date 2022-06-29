import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:holland/data/static.dart';

class MenuModel {
  int id;
  String title;
  String desc;
  int harga;
  String image;
  MenuModel({
    required this.id,
    required this.title,
    required this.desc,
    required this.harga,
    required this.image,
  });

  factory MenuModel.fromJson(Map<String, dynamic> object) {
    return MenuModel(
      id: object["id"],
      title: object["title"],
      desc: object["desc"],
      harga: object["harga"],
      image: object["img"],
    );
  }

  static Future<List<MenuModel>> connectToApi() async {
    String apiUrl = "$baseUrl/menu";
    List<MenuModel> listMenu = [];
    var apiResult = await http.get(Uri.parse(apiUrl));
    var jsonObject = json.decode(apiResult.body);
    if (jsonObject['status'] == true) {
      for (var i = 0; i < jsonObject['data'].length; i++) {
        listMenu.add(MenuModel.fromJson(jsonObject['data'][i]));
      }
    }
    return listMenu;
  }
}
