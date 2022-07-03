import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:holland/data/static.dart';
import 'package:http_parser/http_parser.dart';

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

  static Future<bool> deleteBanner({required String idBanner}) async {
    String apiUrl = "$baseUrl/banner/delete/$idBanner";
    var apiResult = await http.delete(Uri.parse(apiUrl));
    var jsonObject = json.decode(apiResult.body);

    return jsonObject['status'];
  }

  static Future<bool> uploadBanner({
    required File banner,
  }) async {
    String apiUrl = "$baseUrl/banner/upload";
    bool isSucces = false;
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(
        apiUrl,
      ),
    );
    request.headers["Content-Type"] = 'multipart/form-data';
    request.files.add(http.MultipartFile.fromBytes(
      'image',
      banner.readAsBytesSync(),
      filename: "ktp.${banner.path.split(".").last}",
      contentType: MediaType("image", banner.path.split(".").last),
    ));

    await request.send().then((response) async {
      if (response.statusCode == 201) {
        isSucces = true;
      }
    });
    return isSucces;
  }

  static Future<bool> editBanner({
    required File banner,
    required String id,
  }) async {
    String apiUrl = "$baseUrl/banner/edit";
    bool isSucces = false;
    var request = http.MultipartRequest(
      "PUT",
      Uri.parse(
        apiUrl,
      ),
    );
    request.headers["Content-Type"] = 'multipart/form-data';
    request.fields['id'] = id;
    request.files.add(http.MultipartFile.fromBytes(
      'image',
      banner.readAsBytesSync(),
      filename: "ktp.${banner.path.split(".").last}",
      contentType: MediaType("image", banner.path.split(".").last),
    ));

    await request.send().then((response) async {
      if (response.statusCode == 201) {
        isSucces = true;
      }
    });
    return isSucces;
  }
}
