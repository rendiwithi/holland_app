import 'package:flutter/material.dart';
import 'package:holland/data/colorData.dart';
import 'package:holland/data/textStyleData.dart';
import 'package:holland/screen/user/homePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundApp,
      body: SafeArea(
          child: SizedBox(
        height: size.height,
        width: size.width,
        child: ListView(
          children: [
            Image.asset(
              'assets/images/logoHolland.png',
              width: 300,
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text("Login", style: boldWhite),
            ),
            Container(
              height: 300,
              width: size.width,
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: boxInput,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Username", style: mediumBlack),
                  Container(
                    margin: const EdgeInsets.only(bottom: 6, top: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xffFED2AA),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: userController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Username atau email anda",
                        hintStyle: TextStyle(color: Color(0xff777777)),
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: Color(0xff777777),
                        ),
                      ),
                    ),
                  ),
                  Text("Password", style: mediumBlack),
                  Container(
                    margin: const EdgeInsets.only(bottom: 6, top: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xffFED2AA),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        hintStyle: TextStyle(color: Color(0xff777777)),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color(0xff777777),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                      child: const Text("Login"),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(100, 25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Belum punya akun ?",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
