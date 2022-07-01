import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:holland/data/colorData.dart';
import 'package:holland/data/static.dart';
import 'package:holland/model/pesanan_model.dart';
import 'package:holland/screen/check_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:latlong2/latlong.dart';
import 'package:timelines/timelines.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    List<Pesanan> listPesanan = [];
    List<String> listCondition = [
      "Di Keranjang",
      "Sedang di Masak",
      "Sedang di Antar",
      "Selesai",
      "Ditolak",
    ];
    _logOut() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('token', "");
      pref.setString('role', "");
      pref.setString('idUsr', "");
      pref.setBool('isLogin', false);
      tokenUsr = "";
      roleUsr = "";
      idUsr = "";
    }

    _getData() async {
      listPesanan = [];
      await Pesanan.connectToApi().then((value) => listPesanan = value);
    }

    return Scaffold(
        backgroundColor: backgroundApp,
        appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: backgroundApp,
          centerTitle: true,
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                color: const Color(0xff015007),
                onPressed: () {
                  _logOut();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CheckPage(),
                    ),
                  );
                }),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: boxInput,
                ),
                child: Column(
                  children: const [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          'https://i.pinimg.com/736x/79/b3/59/79b35959bed4bdc686fabe244a2c6ca4.jpg'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'User',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    Text('user'),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text("Status Pesanan", style: TextStyle(fontSize: 24)),
              ),
              FutureBuilder(
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
                            child: Text("Maaf Pesanan Belum Tersedia"),
                          );
                        } else {
                          return Timeline.tileBuilder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            builder: TimelineTileBuilder.connectedFromStyle(
                              contentsAlign: ContentsAlign.alternating,
                              connectorStyleBuilder: (context, index) {
                                return (index >= listPesanan[0].status||listPesanan[0].status==4)
                                    ? ConnectorStyle.transparent
                                    : ConnectorStyle.solidLine;
                              },
                              indicatorStyleBuilder: (context, index) =>
                                  IndicatorStyle.dot,
                              contentsBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Text(listCondition[index]),
                              ),
                              itemCount: 5,
                            ),
                          );
                        }
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text("Posisi Anda", style: TextStyle(fontSize: 24)),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                height: 250,
                width: 250,
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(-7.290985, 112.718403),
                    zoom: 18.0,
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
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
