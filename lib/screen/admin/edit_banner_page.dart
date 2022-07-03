import 'dart:io';

import 'package:flutter/material.dart';
import 'package:holland/data/colorData.dart';
import 'package:holland/model/banner_model.dart';
import 'package:holland/screen/admin/home_page_admin.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class EditBannerPage extends StatefulWidget {
  const EditBannerPage({Key? key, required this.model}) : super(key: key);
  final BannerModel model;
  @override
  State<EditBannerPage> createState() => _EditBannerPageState();
}

class _EditBannerPageState extends State<EditBannerPage> {
  File? banner;
  final ImagePicker _picker = ImagePicker();
  getImageBanner() async {
    // Capture a photo
    final photo = await _picker.pickImage(source: ImageSource.gallery);
    if (photo == null) {
      return;
    }
    setState(() {
      banner = File(photo.path);
    });
  }

  _sendData({required String id}) async {
    await BannerModel.editBanner(banner: banner!, id: id).then((value) {
      if (value == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePageAdmin(),
          ),
        );
      } else {
        Alert(
          context: context,
          type: AlertType.error,
          title: "Error",
          desc: "Upload Image Banner Gagal",
          buttons: [
            DialogButton(
              child: const Text(
                "Kembali",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Banner"),
        backgroundColor: backgroundApp,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                getImageBanner();
              },
              child: Container(
                width: 150,
                height: 150,
                margin: const EdgeInsets.all(10),
                color: Colors.grey[200],
                child: (banner != null)
                    ? Image.file(
                        banner!,
                        fit: BoxFit.cover,
                      )
                    : (widget.model.image.isNotEmpty)
                        ? Image.network(
                            widget.model.image,
                            fit: BoxFit.cover,
                          )
                        : const SizedBox(
                            child: Icon(Icons.image),
                          ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    _sendData(id: widget.model.id.toString());
                  },
                  child: const Text("Edit Banner"),
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      width: 3.0,
                      color: Colors.white,
                    ),
                    fixedSize: const Size(300, 60),
                    primary: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
