import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:holland/data/colorData.dart';
import 'package:holland/data/textStyleData.dart';
import 'package:holland/data/variableModel.dart';
import 'package:holland/screen/user/cardMenuItem.dart';
import 'package:holland/screen/user/detailPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> cardList = [
      "https://i.pinimg.com/564x/b7/83/e5/b783e50c98526b8bea753e9ae3eac1f4.jpg",
      "https://i.pinimg.com/236x/5a/8b/17/5a8b1715b0599a6b41c4ce5fe1f55c28.jpg",
      "https://i.pinimg.com/236x/9c/41/d6/9c41d6e8c80f4e04806410166346d880.jpg",
    ];
    var sizeApp = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundApp,
      body: SafeArea(
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
                          hintStyle: const TextStyle(color: Color(0xff777777)),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shop,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
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
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pauseAutoPlayOnTouch: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.8,
                ),
                items: cardList.map((item) {
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
                        image: NetworkImage(item),
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
                  itemCount: listMenuItem.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
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
                            builder: (context) =>
                                DetailPage(item: listMenuItem[index]),
                          ),
                        );
                      },
                      child: CardMenuItem(item: listMenuItem[index]),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
