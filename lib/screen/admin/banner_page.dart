import 'package:flutter/material.dart';
import 'package:holland/data/colorData.dart';
import 'package:holland/model/banner_model.dart';
import 'package:holland/screen/admin/add_banner_page.dart';
import 'package:holland/screen/admin/edit_banner_page.dart';
import 'package:holland/screen/admin/home_page_admin.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BannerPage extends StatefulWidget {
  const BannerPage({Key? key}) : super(key: key);

  @override
  State<BannerPage> createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  List<BannerModel> listBanner = [];
  _getData() async {
    await BannerModel.connectToApi().then((value) {
      listBanner = [];
      listBanner = value;
    });
  }

  _deleteBanner({required String idBanner}) async {
    await BannerModel.deleteBanner(idBanner: idBanner).then((value) {
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
          desc: "Delete Banner Gagal",
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
      backgroundColor: backgroundApp,
      appBar: AppBar(
        title: const Text("Kelola Banner"),
        backgroundColor: backgroundApp,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddBannerPage()));
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder(
          future: _getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                if (listBanner.isEmpty) {
                  return const Center(
                    child: Text("Maaf Menu Belum Tersedia"),
                  );
                } else {
                  return ListView.builder(
                    itemCount: listBanner.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: ListTile(
                          leading: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: 44,
                              minHeight: 44,
                              maxWidth: 64,
                              maxHeight: 64,
                            ),
                            child: Image.network(listBanner[index].image,
                                fit: BoxFit.cover),
                          ),
                          onTap: () {},
                          trailing: SizedBox(
                            width: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditBannerPage(
                                              model: listBanner[index]),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      _deleteBanner(
                                          idBanner:
                                              listBanner[index].id.toString());
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                              ],
                            ),
                          ),
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
          }),
    );
  }
}
