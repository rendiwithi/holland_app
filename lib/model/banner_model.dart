import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:holland/data/static.dart';

class BannerModel {
  int id;
  String image;
  BannerModel({
    required this.id,
    required this.image,
  });

  factory BannerModel.fromJson(Map<String, dynamic> object) {
    return BannerModel(
      id: object["id"],
      image: object["image"],
    );
  }

  static Future<List<BannerModel>> connectToApi() async {
    String apiUrl = "$baseUrl/banner";
    List<BannerModel> listBanner = [];
    var apiResult = await http.get(Uri.parse(apiUrl));
    var jsonObject = json.decode(apiResult.body);
    if (jsonObject['status'] == true) {
      for (var i = 0; i < jsonObject['data'].length; i++) {
        listBanner.add(BannerModel.fromJson(jsonObject['data'][i]));
      }
    }

    return listBanner;
  }
}
