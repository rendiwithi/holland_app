import 'package:flutter/material.dart';
import 'package:holland/data/static.dart';
import 'package:holland/screen/admin/home_page_admin.dart';
import 'package:holland/screen/loginPage.dart';
import 'package:holland/screen/user/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({Key? key}) : super(key: key);

  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  check() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool('isLogin') == true) {
      tokenUsr = pref.getString('token').toString();
      roleUsr = pref.getString('role').toString();
      idUsr = pref.getString('idUsr').toString();
      // cek ping
      if (roleUsr == "Member") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else if (roleUsr == "Admin") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePageAdmin(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    check();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
