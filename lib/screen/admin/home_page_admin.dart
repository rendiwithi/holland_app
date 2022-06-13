import 'package:flutter/material.dart';
import 'package:holland/data/colorData.dart';
import 'package:holland/screen/admin/beranda_page.dart';
import 'package:holland/screen/admin/order_page.dart';
import 'package:holland/screen/admin/user_page.dart';
import 'package:holland/screen/admin/voucher_page_admin.dart';

class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({Key? key}) : super(key: key);

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  TextEditingController searchController = TextEditingController();

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
              Tab(text: 'Akun'),
            ],
          ),
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
