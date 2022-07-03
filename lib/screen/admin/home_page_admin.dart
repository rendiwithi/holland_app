import 'package:flutter/material.dart';
import 'package:holland/data/colorData.dart';
import 'package:holland/data/static.dart';
import 'package:holland/screen/admin/beranda_page.dart';
import 'package:holland/screen/admin/order_page.dart';
import 'package:holland/screen/admin/user_page.dart';
import 'package:holland/screen/admin/voucher_page_admin.dart';
import 'package:holland/screen/check_page.dart';
import 'package:holland/screen/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({Key? key}) : super(key: key);

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  TextEditingController searchController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: backgroundApp,
        appBar: AppBar(
          backgroundColor: backgroundApp,
          title: const Text('Admin Home Page'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Beranda'),
              Tab(
                text: 'Voucher',
              ),
              Tab(text: 'Pesanan'),
              Tab(text: 'Web'),
            ],
          ),
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                color: const Color(0xff015007),
                onPressed: () {
                  _logOut();

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const LoginPage(),
                      ),
                      (route) => false);
                }),
          ],
        ),
        body: const TabBarView(children: [
          BerandaPage(),
          VoucherPageAdmin(),
          OrderPage(),
          UserPage(),
        ]),
      ),
    );
  }
}
