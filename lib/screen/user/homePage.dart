import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:holland/data/colorData.dart';
import 'package:holland/data/textStyleData.dart';
import 'package:holland/data/variableModel.dart';
import 'package:holland/model/banner_model.dart';
import 'package:holland/model/menu_model.dart';
import 'package:holland/screen/user/cardMenuItem.dart';
import 'package:holland/screen/user/cartPage.dart';
import 'package:holland/screen/user/detailPage.dart';
import 'package:holland/screen/user/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  List<BannerModel> listBanner = [];
  List<MenuModel> listMenu = [];
  @override
  Widget build(BuildContext context) {
    _getData() async {
      listBanner = [];
      listMenu = [];
      await BannerModel.connectToApi().then((value) => listBanner = value);
      await MenuModel.connectToApi().then((value) => listMenu = value);
    }

    var sizeApp = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundApp,
      body: FutureBuilder(
          future: _getData(),
          builder: (context, snapshot) {
            return SafeArea(
              child: Column(
                children: [
                  //AppBarCustom
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 6, top: 8),
                            padding: const EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              color: const Color(0xffFED2AA),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search",
                                hintStyle:
                                    const TextStyle(color: Color(0xff777777)),
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.search),
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CartPage()),
                            );
                          },
                          icon: const Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfilePage()),
                            );
                          },
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //sliders
                  SizedBox(
                    height: 200,
                    width: sizeApp.width,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        pauseAutoPlayOnTouch: true,
                        enlargeCenterPage: true,
                        viewportFraction: 0.8,
                      ),
                      items: listBanner.map((item) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.6,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  blurRadius: 2),
                            ],
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(item.image),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Text(
                    "Daftar Menu",
                    style: boldWhite,
                  ),
                  //box item
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: GridView.builder(
                        itemCount: listMenu.length,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 250,
                          childAspectRatio: 4 / 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (BuildContext ctx, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                      menuDetail: listMenu[index],
                                      index: index),
                                ),
                              );
                            },
                            child: CardMenuItem(item: listMenu[index]),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
